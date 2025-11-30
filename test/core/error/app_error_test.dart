import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/network/api_client.dart';

/// Property-based tests for AppError and ErrorHandler
void main() {
  final random = Random();

  group('Property 11: Error Handler Type Mapping', () {
    /// **Feature: code-architecture-optimization, Property 11: Error Handler Type Mapping**
    /// *For any* ApiException, `ErrorHandler.handle()` SHALL return an AppError
    /// with the correct AppErrorType based on status code.
    /// **Validates: Requirements 5.1**

    test('network errors (null or 0 status) map to AppErrorType.network', () {
      for (var i = 0; i < 100; i++) {
        final message = 'Network error ${random.nextInt(10000)}';
        final statusCode = random.nextBool() ? null : 0;

        final exception = ApiException(message, statusCode: statusCode);
        final error = ErrorHandler.handle(exception);

        expect(error.type, equals(AppErrorType.network));
        expect(error.message, equals(message));
      }
    });

    test('validation errors (400) map to AppErrorType.validation', () {
      for (var i = 0; i < 100; i++) {
        final message = 'Validation error ${random.nextInt(10000)}';

        final exception = ApiException(message, statusCode: 400);
        final error = ErrorHandler.handle(exception);

        expect(error.type, equals(AppErrorType.validation));
        expect(error.message, equals(message));
      }
    });

    test('auth errors (401, 403) map to AppErrorType.auth', () {
      for (var i = 0; i < 100; i++) {
        final message = 'Auth error ${random.nextInt(10000)}';
        final statusCode = random.nextBool() ? 401 : 403;

        final exception = ApiException(message, statusCode: statusCode);
        final error = ErrorHandler.handle(exception);

        expect(error.type, equals(AppErrorType.auth));
      }
    });

    test('not found errors (404) map to AppErrorType.notFound', () {
      for (var i = 0; i < 100; i++) {
        final message = 'Not found ${random.nextInt(10000)}';

        final exception = ApiException(message, statusCode: 404);
        final error = ErrorHandler.handle(exception);

        expect(error.type, equals(AppErrorType.notFound));
      }
    });

    test('server errors (5xx) map to AppErrorType.server', () {
      for (var i = 0; i < 100; i++) {
        final message = 'Server error ${random.nextInt(10000)}';
        final statusCode = 500 + random.nextInt(100); // 500-599

        final exception = ApiException(message, statusCode: statusCode);
        final error = ErrorHandler.handle(exception);

        expect(error.type, equals(AppErrorType.server));
      }
    });

    test('other status codes map to AppErrorType.unknown', () {
      final otherCodes = [201, 202, 301, 302, 402, 405, 406, 408, 409, 410];
      for (var i = 0; i < 100; i++) {
        final message = 'Other error ${random.nextInt(10000)}';
        final statusCode = otherCodes[random.nextInt(otherCodes.length)];

        final exception = ApiException(message, statusCode: statusCode);
        final error = ErrorHandler.handle(exception);

        expect(error.type, equals(AppErrorType.unknown));
      }
    });
  });

  group('Property 12: Error User Message', () {
    /// **Feature: code-architecture-optimization, Property 12: Error User Message**
    /// *For any* AppError, the `userMessage` property SHALL return a non-empty,
    /// user-friendly string.
    /// **Validates: Requirements 5.2**

    test('all error types return non-empty user messages', () {
      for (var i = 0; i < 100; i++) {
        for (final type in AppErrorType.values) {
          final error = AppError(
            type: type,
            message: 'Test message ${random.nextInt(10000)}',
          );

          expect(error.userMessage, isNotEmpty);
          expect(error.userMessage, isA<String>());
        }
      }
    });

    test('validation errors include original message when non-empty', () {
      for (var i = 0; i < 100; i++) {
        final message = 'Custom validation message ${random.nextInt(10000)}';
        final error = AppError(
          type: AppErrorType.validation,
          message: message,
        );

        expect(error.userMessage, equals(message));
      }
    });

    test('validation errors with empty message return default', () {
      final error = AppError(
        type: AppErrorType.validation,
        message: '',
      );

      expect(error.userMessage, equals('请求参数错误'));
    });
  });

  group('Property 13: Error Retryability', () {
    /// **Feature: code-architecture-optimization, Property 13: Error Retryability**
    /// *For any* AppError, the `isRetryable` property SHALL return true for
    /// network/server errors, false for validation/auth errors.
    /// **Validates: Requirements 5.3**

    test('network errors are retryable', () {
      for (var i = 0; i < 100; i++) {
        final error = AppError(
          type: AppErrorType.network,
          message: 'Network error ${random.nextInt(10000)}',
        );

        expect(error.isRetryable, isTrue);
      }
    });

    test('server errors are retryable', () {
      for (var i = 0; i < 100; i++) {
        final error = AppError(
          type: AppErrorType.server,
          message: 'Server error ${random.nextInt(10000)}',
        );

        expect(error.isRetryable, isTrue);
      }
    });

    test('validation errors are not retryable', () {
      for (var i = 0; i < 100; i++) {
        final error = AppError(
          type: AppErrorType.validation,
          message: 'Validation error ${random.nextInt(10000)}',
        );

        expect(error.isRetryable, isFalse);
      }
    });

    test('auth errors are not retryable', () {
      for (var i = 0; i < 100; i++) {
        final error = AppError(
          type: AppErrorType.auth,
          message: 'Auth error ${random.nextInt(10000)}',
        );

        expect(error.isRetryable, isFalse);
      }
    });

    test('notFound errors are not retryable', () {
      for (var i = 0; i < 100; i++) {
        final error = AppError(
          type: AppErrorType.notFound,
          message: 'Not found ${random.nextInt(10000)}',
        );

        expect(error.isRetryable, isFalse);
      }
    });

    test('unknown errors are not retryable', () {
      for (var i = 0; i < 100; i++) {
        final error = AppError(
          type: AppErrorType.unknown,
          message: 'Unknown error ${random.nextInt(10000)}',
        );

        expect(error.isRetryable, isFalse);
      }
    });
  });

  group('ErrorHandler.handleAny', () {
    test('handles ApiException correctly', () {
      final exception = ApiException('Test', statusCode: 500);
      final error = ErrorHandler.handleAny(exception);

      expect(error.type, equals(AppErrorType.server));
    });

    test('returns AppError as-is', () {
      final original = AppError(
        type: AppErrorType.validation,
        message: 'Original',
      );
      final result = ErrorHandler.handleAny(original);

      expect(identical(result, original), isTrue);
    });

    test('wraps unknown exceptions', () {
      final exception = Exception('Unknown');
      final error = ErrorHandler.handleAny(exception);

      expect(error.type, equals(AppErrorType.unknown));
    });
  });
}
