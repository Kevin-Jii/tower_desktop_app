import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_client.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'package:tower_desktop_app/core/repository/page_query.dart';

/// Abstract interface for CRUD repository operations
///
/// Provides a standard interface for data access operations.
/// Type parameters:
/// - [T]: The entity type
/// - [ID]: The identifier type (usually int or String)
abstract class CrudRepository<T, ID> {
  /// Get a paginated list of items
  Future<Result<PageResponse<T>>> getPage(PageQuery query);

  /// Get a single item by ID
  Future<Result<T>> getById(ID id);

  /// Create a new item
  Future<Result<T?>> create(Map<String, dynamic> data);

  /// Update an existing item
  Future<Result<T?>> update(ID id, Map<String, dynamic> data);

  /// Delete an item by ID
  Future<Result<void>> delete(ID id);
}

/// Base implementation of CrudRepository
///
/// Provides common functionality for CRUD operations.
/// Subclasses should override [basePath] and [fromJson].
abstract class BaseCrudRepository<T> implements CrudRepository<T, int> {
  final ApiClient apiClient;

  BaseCrudRepository(this.apiClient);

  /// Base API path for this resource (e.g., '/users', '/stores')
  String get basePath;

  /// Parse JSON to entity
  T fromJson(Map<String, dynamic> json);

  @override
  Future<Result<PageResponse<T>>> getPage(PageQuery query) async {
    try {
      final response = await apiClient.getPage<T>(
        basePath,
        queryParameters: query.toQueryParameters(),
        itemParser: fromJson,
      );
      return Result.success(response);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  @override
  Future<Result<T>> getById(int id) async {
    try {
      final response = await apiClient.getSmart<T>(
        path: '$basePath/$id',
        fromJson: fromJson,
      );
      return Result.success(response);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  @override
  Future<Result<T?>> create(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.postSmart<T>(
        path: basePath,
        data: data,
        fromJson: fromJson,
        filterNulls: true,
      );
      return Result.success(response);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  @override
  Future<Result<T?>> update(int id, Map<String, dynamic> data) async {
    try {
      final response = await apiClient.putSmart<T>(
        path: '$basePath/$id',
        data: data,
        fromJson: fromJson,
        filterNulls: true,
      );
      return Result.success(response);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  @override
  Future<Result<void>> delete(int id) async {
    try {
      await apiClient.deleteSmart(path: '$basePath/$id');
      return Result.success(null);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
}
