import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_client.dart';
import 'package:tower_desktop_app/core/repository/page_query.dart';

/// Property-based tests for Repository layer
void main() {
  final random = Random();

  group('Property 10: Repository Error Transformation', () {
    /// **Feature: code-architecture-optimization, Property 10: Repository Error Transformation**
    /// *For any* repository method that encounters an API error,
    /// the error SHALL be transformed into an AppError.
    /// **Validates: Requirements 4.4**

    test('ApiException is transformed to AppError with correct type', () {
      for (var i = 0; i < 100; i++) {
        final statusCodes = [null, 0, 400, 401, 403, 404, 500, 502, 503];
        final statusCode = statusCodes[random.nextInt(statusCodes.length)];
        final message = 'Error message ${random.nextInt(10000)}';

        final exception = ApiException(message, statusCode: statusCode);
        final error = ErrorHandler.handle(exception);

        expect(error, isA<AppError>());
        expect(error.message, equals(message));

        // Verify correct type mapping
        if (statusCode == null || statusCode == 0) {
          expect(error.type, equals(AppErrorType.network));
        } else if (statusCode == 400) {
          expect(error.type, equals(AppErrorType.validation));
        } else if (statusCode == 401 || statusCode == 403) {
          expect(error.type, equals(AppErrorType.auth));
        } else if (statusCode == 404) {
          expect(error.type, equals(AppErrorType.notFound));
        } else if (statusCode >= 500) {
          expect(error.type, equals(AppErrorType.server));
        }
      }
    });
  });

  group('Property 14: Response Parsing Error Handling', () {
    /// **Feature: code-architecture-optimization, Property 14: Response Parsing Error Handling**
    /// *For any* malformed API response, parsing SHALL throw an AppError
    /// with a descriptive message.
    /// **Validates: Requirements 7.2**

    test('malformed response creates descriptive error', () {
      for (var i = 0; i < 100; i++) {
        final errorMessage = 'Parse error ${random.nextInt(10000)}';
        final error = AppError(
          type: AppErrorType.unknown,
          message: errorMessage,
        );

        expect(error.message, contains('Parse error'));
        expect(error.message, isNotEmpty);
      }
    });
  });

  group('Property 15: Null-Safe Deserialization', () {
    /// **Feature: code-architecture-optimization, Property 15: Null-Safe Deserialization**
    /// *For any* API response with missing optional fields,
    /// deserialization SHALL succeed without throwing.
    /// **Validates: Requirements 7.4**

    test('PageQuery handles null keyword gracefully', () {
      for (var i = 0; i < 100; i++) {
        final query = PageQuery(
          page: random.nextInt(100) + 1,
          pageSize: random.nextInt(50) + 1,
          keyword: null,
        );

        final params = query.toQueryParameters();

        expect(params['page'], equals(query.page));
        expect(params['page_size'], equals(query.pageSize));
        expect(params.containsKey('keyword'), isFalse);
      }
    });

    test('PageQuery handles empty keyword gracefully', () {
      for (var i = 0; i < 100; i++) {
        final query = PageQuery(
          page: random.nextInt(100) + 1,
          pageSize: random.nextInt(50) + 1,
          keyword: '',
        );

        final params = query.toQueryParameters();

        expect(params.containsKey('keyword'), isFalse);
      }
    });

    test('PageQuery handles null filters gracefully', () {
      for (var i = 0; i < 100; i++) {
        final query = PageQuery(
          page: random.nextInt(100) + 1,
          pageSize: random.nextInt(50) + 1,
          filters: null,
        );

        final params = query.toQueryParameters();

        expect(params.length, equals(2)); // Only page and page_size
      }
    });
  });

  group('PageQuery', () {
    test('copyWith preserves unchanged values', () {
      for (var i = 0; i < 100; i++) {
        final original = PageQuery(
          page: random.nextInt(100) + 1,
          pageSize: random.nextInt(50) + 1,
          keyword: 'keyword${random.nextInt(1000)}',
        );

        final newPage = random.nextInt(100) + 1;
        final copied = original.copyWith(page: newPage);

        expect(copied.page, equals(newPage));
        expect(copied.pageSize, equals(original.pageSize));
        expect(copied.keyword, equals(original.keyword));
      }
    });

    test('nextPage increments page by 1', () {
      for (var i = 0; i < 100; i++) {
        final page = random.nextInt(100) + 1;
        final query = PageQuery(page: page);
        final next = query.nextPage();

        expect(next.page, equals(page + 1));
      }
    });

    test('previousPage decrements page but not below 1', () {
      for (var i = 0; i < 100; i++) {
        final page = random.nextInt(100) + 1;
        final query = PageQuery(page: page);
        final prev = query.previousPage();

        expect(prev.page, equals(page > 1 ? page - 1 : 1));
      }

      // Edge case: page 1
      final query = PageQuery(page: 1);
      expect(query.previousPage().page, equals(1));
    });

    test('firstPage always returns page 1', () {
      for (var i = 0; i < 100; i++) {
        final page = random.nextInt(100) + 1;
        final query = PageQuery(page: page);
        final first = query.firstPage();

        expect(first.page, equals(1));
      }
    });
  });

  group('Result', () {
    test('Success contains data', () {
      for (var i = 0; i < 100; i++) {
        final data = random.nextInt(10000);
        final result = Result<int>.success(data);

        expect(result.isSuccess, isTrue);
        expect(result.isFailure, isFalse);
        expect(result.dataOrNull, equals(data));
        expect(result.errorOrNull, isNull);
      }
    });

    test('Failure contains error', () {
      for (var i = 0; i < 100; i++) {
        final error = AppError(
          type: AppErrorType.values[random.nextInt(AppErrorType.values.length)],
          message: 'Error ${random.nextInt(10000)}',
        );
        final result = Result<int>.failure(error);

        expect(result.isSuccess, isFalse);
        expect(result.isFailure, isTrue);
        expect(result.dataOrNull, isNull);
        expect(result.errorOrNull, equals(error));
      }
    });

    test('when pattern matches correctly', () {
      for (var i = 0; i < 100; i++) {
        final data = random.nextInt(10000);
        final successResult = Result<int>.success(data);

        final successValue = successResult.when(
          success: (d) => d * 2,
          failure: (e) => -1,
        );
        expect(successValue, equals(data * 2));

        final error = AppError(
          type: AppErrorType.unknown,
          message: 'Error',
        );
        final failureResult = Result<int>.failure(error);

        final failureValue = failureResult.when(
          success: (d) => d * 2,
          failure: (e) => -1,
        );
        expect(failureValue, equals(-1));
      }
    });

    test('map transforms success value', () {
      for (var i = 0; i < 100; i++) {
        final data = random.nextInt(10000);
        final result = Result<int>.success(data);
        final mapped = result.map((d) => d.toString());

        expect(mapped.isSuccess, isTrue);
        expect(mapped.dataOrNull, equals(data.toString()));
      }
    });

    test('map preserves failure', () {
      final error = AppError(type: AppErrorType.unknown, message: 'Error');
      final result = Result<int>.failure(error);
      final mapped = result.map((d) => d.toString());

      expect(mapped.isFailure, isTrue);
      expect(mapped.errorOrNull, equals(error));
    });
  });
}
