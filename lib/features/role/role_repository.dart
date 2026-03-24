import 'dart:convert';
import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_client.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'package:tower_desktop_app/core/repository/crud_repository.dart';
import 'package:tower_desktop_app/core/repository/page_query.dart';
import 'package:tower_desktop_app/core/constants/app_constants.dart';
import 'package:tower_desktop_app/core/constants/error_texts.dart';
import 'package:tower_desktop_app/core/utils/map_utils.dart';
import 'package:tower_desktop_app/core/utils/value_parsers.dart';
import 'role_models.dart';
class RoleRepository extends BaseCrudRepository<RoleItem> {
  RoleRepository(super.apiClient);
  @override
  String get basePath => ApiPaths.roles;
  @override
  RoleItem fromJson(Map<String, dynamic> map) {
    if (!map.containsKey('description') && map.containsKey('remark')) {
      map['description'] = map['remark'];
    }
    return RoleItem(
      id: parseInt(map['id']),
      name: map['name']?.toString() ?? '',
      code: map['code']?.toString() ?? '',
      description: map['description']?.toString(),
      status: parseIntNullable(map['status']),
      createdAt: parseStringNullable(map['created_at']),
      updatedAt: parseStringNullable(map['updated_at']),
    );
  }
  Future<Result<List<RoleItem>>> getRoles({String? keyword}) async {
    try {
      final resp = await apiClient.dio.get(basePath, queryParameters: {
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      });
      dynamic body = resp.data;
      if (body is String) {
        try {
          body = body.trim().isEmpty ? [] : jsonDecode(body);
        } on Object {
          return Result.failure(AppError(
            type: AppErrorType.unknown,
            message: ErrorTexts.loadRoles,
          ));
        }
      }
      List listData = [];
      if (body is List) {
        listData = body;
      } else if (body is Map) {
        final data = body['data'];
        if (data is List) {
          listData = data;
        } else if (data == null) {
          listData = [];
        } else {
          return Result.failure(AppError(
            type: AppErrorType.unknown,
            message: ErrorTexts.loadRoles,
          ));
        }
      } else {
        return Result.failure(AppError(
          type: AppErrorType.unknown,
          message: ErrorTexts.loadRoles,
        ));
      }
      final roles = listData.map((raw) {
        final map = Map<String, dynamic>.from(raw as Map);
        return fromJson(map);
      }).toList();
      return Result.success(roles);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<void>> createRole(CreateRoleRequest req) async {
    try {
      await apiClient.post<void>(basePath, data: req.toJson());
      return Result.success(null);
    } on ApiException catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handle(e, stackTrace));
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<void>> updateRole(int id, UpdateRoleRequest req) async {
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
  Future<Result<void>> deleteRole(int id) async {
    return delete(id);
  }
}
