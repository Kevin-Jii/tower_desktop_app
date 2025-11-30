import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_client.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'package:tower_desktop_app/core/repository/crud_repository.dart';
import 'package:tower_desktop_app/core/repository/page_query.dart';
import 'package:tower_desktop_app/core/constants/app_constants.dart';
import 'package:tower_desktop_app/core/utils/map_utils.dart';
import 'models.dart';

/// Repository for User entity
///
/// Provides CRUD operations and additional user-specific methods.
class UserRepository extends BaseCrudRepository<User> {
  UserRepository(super.apiClient);

  @override
  String get basePath => ApiPaths.users;

  @override
  User fromJson(Map<String, dynamic> json) => User.fromJson(json);

  /// Get users with additional filters
  Future<Result<PageResponse<User>>> getUsers({
    int page = 1,
    int pageSize = 10,
    String? keyword,
    int? roleId,
    int? storeId,
    int? status,
  }) async {
    final query = PageQuery(
      page: page,
      pageSize: pageSize,
      keyword: keyword,
      filters: {
        if (roleId != null) 'role_id': roleId,
        if (storeId != null) 'store_id': storeId,
        if (status != null) 'status': status,
      },
    );
    return getPage(query);
  }

  /// Create a new user
  Future<Result<void>> createUser(CreateUserRequest req) async {
    try {
      await apiClient.post<void>(
        basePath,
        data: compact(req.toJson()),
      );
      return Result.success(null);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  /// Update an existing user
  Future<Result<void>> updateUser(int id, UpdateUserRequest req) async {
    try {
      await apiClient.request<void>(
        '$basePath/$id',
        method: 'PUT',
        data: compact(req.toJson()),
      );
      return Result.success(null);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  /// Delete a user
  Future<Result<void>> deleteUser(int id) async {
    return delete(id);
  }

  /// Batch delete users
  Future<Result<void>> batchDelete(List<int> ids) async {
    try {
      await apiClient.post('$basePath/batch-delete', data: {'ids': ids});
      return Result.success(null);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  /// Reset user password
  Future<Result<void>> resetPassword(int id, String newPassword) async {
    try {
      await apiClient.post(
        '$basePath/$id/reset-password',
        data: {'password': newPassword},
      );
      return Result.success(null);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
}
