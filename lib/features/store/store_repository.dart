import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_client.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'package:tower_desktop_app/core/repository/crud_repository.dart';
import 'package:tower_desktop_app/core/repository/page_query.dart';
import 'package:tower_desktop_app/core/constants/app_constants.dart';
import 'package:tower_desktop_app/core/utils/map_utils.dart';
import 'models.dart';

/// Repository for Store entity
///
/// Provides CRUD operations and additional store-specific methods.
class StoreRepository extends BaseCrudRepository<Store> {
  StoreRepository(super.apiClient);

  @override
  String get basePath => ApiPaths.stores;

  @override
  Store fromJson(Map<String, dynamic> json) => Store.fromJson(json);

  /// Get stores with pagination
  Future<Result<PageResponse<Store>>> getStores({
    int page = 1,
    int pageSize = 10,
    String? keyword,
  }) async {
    final query = PageQuery(
      page: page,
      pageSize: pageSize,
      keyword: keyword,
    );
    return getPage(query);
  }

  /// Get all stores (for dropdown selection)
  Future<Result<List<Store>>> listStores() async {
    try {
      final stores = await apiClient.getSimpleList<Store>(
        path: '$basePath/all',
        fromJson: Store.fromJson,
      );
      return Result.success(stores);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  /// Create a new store
  Future<Result<Store?>> createStore(CreateStoreRequest request) async {
    try {
      final store = await apiClient.postSmart<Store>(
        path: basePath,
        data: compact(request.toJson()),
        fromJson: Store.fromJson,
        filterNulls: true,
      );
      return Result.success(store);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  /// Update an existing store
  Future<Result<Store?>> updateStore(int id, UpdateStoreRequest request) async {
    try {
      final store = await apiClient.putSmart<Store>(
        path: '$basePath/$id',
        data: compact(request.toJson()),
        fromJson: Store.fromJson,
        filterNulls: true,
      );
      return Result.success(store);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  /// Delete a store
  Future<Result<void>> deleteStore(int id) async {
    return delete(id);
  }
}
