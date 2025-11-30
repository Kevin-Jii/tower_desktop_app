import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'package:tower_desktop_app/core/providers/paged_provider.dart';
import 'package:tower_desktop_app/core/repository/page_query.dart';

/// Test implementation of PagedProvider
class TestPagedProvider extends PagedProvider<String> {
  final Future<Result<PageResponse<String>>> Function(PageQuery query)?
      fetchPageImpl;

  TestPagedProvider({this.fetchPageImpl});

  @override
  Future<Result<PageResponse<String>>> fetchPage(PageQuery query) async {
    if (fetchPageImpl != null) {
      return fetchPageImpl!(query);
    }
    // Default implementation returns empty page
    return Result.success(PageResponse(
      list: [],
      total: 0,
      page: query.page,
      pageSize: query.pageSize,
    ));
  }
}

void main() {
  final random = Random();

  group('Property 4: Provider Loading State Transitions', () {
    /// **Feature: code-architecture-optimization, Property 4: Provider Loading State Transitions**
    /// *For any* PagedProvider, when `load()` is called, the state SHALL transition
    /// from idle to loading, then to either idle (success) or error (failure).
    /// **Validates: Requirements 2.2**

    test('load transitions: idle -> loading -> idle on success', () async {
      for (var i = 0; i < 20; i++) {
        final states = <LoadingState>[];
        final provider = TestPagedProvider(
          fetchPageImpl: (query) async {
            return Result.success(PageResponse(
              list: List.generate(5, (i) => 'Item $i'),
              total: 100,
              page: query.page,
              pageSize: query.pageSize,
            ));
          },
        );

        provider.addListener(() {
          states.add(provider.loadingState);
        });

        expect(provider.loadingState, equals(LoadingState.idle));
        await provider.load();

        // Should have transitioned through loading to idle
        expect(states, contains(LoadingState.loading));
        expect(provider.loadingState, equals(LoadingState.idle));
      }
    });

    test('load transitions: idle -> loading -> error on failure', () async {
      for (var i = 0; i < 20; i++) {
        final states = <LoadingState>[];
        final provider = TestPagedProvider(
          fetchPageImpl: (query) async {
            return Result.failure(AppError(
              type: AppErrorType.server,
              message: 'Server error',
            ));
          },
        );

        provider.addListener(() {
          states.add(provider.loadingState);
        });

        expect(provider.loadingState, equals(LoadingState.idle));
        await provider.load();

        expect(states, contains(LoadingState.loading));
        expect(provider.loadingState, equals(LoadingState.error));
      }
    });
  });

  group('Property 5: Provider Error Capture', () {
    /// **Feature: code-architecture-optimization, Property 5: Provider Error Capture**
    /// *For any* PagedProvider or CrudProvider, when an operation fails,
    /// the error property SHALL contain a non-null error message.
    /// **Validates: Requirements 2.3, 3.4**

    test('error property is set on failure', () async {
      for (var i = 0; i < 100; i++) {
        final errorMessage = 'Error message ${random.nextInt(10000)}';
        final provider = TestPagedProvider(
          fetchPageImpl: (query) async {
            return Result.failure(AppError(
              type: AppErrorType.server,
              message: errorMessage,
            ));
          },
        );

        await provider.load();

        expect(provider.error, isNotNull);
        expect(provider.error, isNotEmpty);
      }
    });

    test('error is cleared on successful load', () async {
      var shouldFail = true;
      final provider = TestPagedProvider(
        fetchPageImpl: (query) async {
          if (shouldFail) {
            return Result.failure(AppError(
              type: AppErrorType.server,
              message: 'Error',
            ));
          }
          return Result.success(PageResponse(
            list: ['Item'],
            total: 1,
            page: 1,
            pageSize: 10,
          ));
        },
      );

      // First load fails
      await provider.load();
      expect(provider.error, isNotNull);

      // Second load succeeds
      shouldFail = false;
      await provider.load();
      expect(provider.error, isNull);
    });
  });

  group('Property 6: Provider Refresh Behavior', () {
    /// **Feature: code-architecture-optimization, Property 6: Provider Refresh Behavior**
    /// *For any* PagedProvider with existing data, calling `refresh()` SHALL
    /// reset page to 1 and clear items before loading.
    /// **Validates: Requirements 2.4**

    test('refresh resets page to 1', () async {
      for (var i = 0; i < 20; i++) {
        final provider = TestPagedProvider(
          fetchPageImpl: (query) async {
            return Result.success(PageResponse(
              list: List.generate(10, (i) => 'Item $i'),
              total: 100,
              page: query.page,
              pageSize: query.pageSize,
            ));
          },
        );

        // Load page 3
        await provider.load(page: 3);
        expect(provider.page, equals(3));

        // Refresh should reset to page 1
        await provider.refresh();
        expect(provider.page, equals(1));
      }
    });

    test('refresh replaces existing items', () async {
      var callCount = 0;
      final provider = TestPagedProvider(
        fetchPageImpl: (query) async {
          callCount++;
          return Result.success(PageResponse(
            list: ['Call $callCount Item'],
            total: 1,
            page: 1,
            pageSize: 10,
          ));
        },
      );

      await provider.load();
      expect(provider.items, equals(['Call 1 Item']));

      await provider.refresh();
      expect(provider.items, equals(['Call 2 Item']));
    });
  });

  group('PagedProvider additional tests', () {
    test('loadMore appends items', () async {
      var page = 0;
      final provider = TestPagedProvider(
        fetchPageImpl: (query) async {
          page = query.page;
          return Result.success(PageResponse(
            list: ['Page ${query.page} Item'],
            total: 30,
            page: query.page,
            pageSize: 10,
          ));
        },
      );

      await provider.load();
      expect(provider.items.length, equals(1));

      await provider.loadMore();
      expect(provider.items.length, equals(2));
      expect(provider.items, contains('Page 1 Item'));
      expect(provider.items, contains('Page 2 Item'));
    });

    test('search updates keyword and resets page', () async {
      String? capturedKeyword;
      final provider = TestPagedProvider(
        fetchPageImpl: (query) async {
          capturedKeyword = query.keyword;
          return Result.success(PageResponse(
            list: [],
            total: 0,
            page: 1,
            pageSize: 10,
          ));
        },
      );

      await provider.search('test keyword');

      expect(capturedKeyword, equals('test keyword'));
      expect(provider.keyword, equals('test keyword'));
      expect(provider.page, equals(1));
    });

    test('hasMore returns correct value', () async {
      final provider = TestPagedProvider(
        fetchPageImpl: (query) async {
          return Result.success(PageResponse(
            list: List.generate(10, (i) => 'Item $i'),
            total: 25,
            page: query.page,
            pageSize: 10,
          ));
        },
      );

      await provider.load();
      expect(provider.hasMore, isTrue); // 10 < 25

      await provider.loadMore();
      expect(provider.hasMore, isTrue); // 20 < 25

      await provider.loadMore();
      expect(provider.hasMore, isFalse); // 30 >= 25
    });

    test('reset clears all state', () async {
      final provider = TestPagedProvider(
        fetchPageImpl: (query) async {
          return Result.success(PageResponse(
            list: ['Item'],
            total: 100,
            page: 5,
            pageSize: 20,
          ));
        },
      );

      await provider.load(page: 5, pageSize: 20, keyword: 'test');

      provider.reset();

      expect(provider.items, isEmpty);
      expect(provider.page, equals(1));
      expect(provider.pageSize, equals(10));
      expect(provider.total, equals(0));
      expect(provider.keyword, isNull);
      expect(provider.error, isNull);
      expect(provider.loadingState, equals(LoadingState.idle));
    });
  });
}
