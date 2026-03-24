import 'dart:convert';
import '../../core/network/api_client.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/value_parsers.dart';
import '../../core/utils/map_utils.dart';
import '../../core/constants/error_texts.dart';
import '../../core/network/crud_api.dart';
import 'role_models.dart';
class RoleApi extends CrudApi<RoleItem> {
  RoleApi(ApiClient client) : super(client);
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
  Future<List<RoleItem>> getRoles({String? keyword}) async {
    try {
      final resp = await client.dio.get(basePath, queryParameters: {
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      });
      dynamic body = resp.data;
      if (body is String) {
        try {
          body = body.trim().isEmpty ? [] : jsonDecode(body);
        } on Object {
          throw ApiException(ErrorTexts.loadRoles);
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
          throw ApiException(ErrorTexts.loadRoles);
        }
      } else {
        throw ApiException(ErrorTexts.loadRoles);
      }
      return listData.map((raw) {
        try {
          final map = Map<String, dynamic>.from(raw as Map);
          return fromJson(map);
        } catch (e) {
          throw ApiException('${ErrorTexts.parseRoleItem}: $e 原始条目: $raw');
        }
      }).toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('${ErrorTexts.loadRoles}: $e');
    }
  }
  Future<void> createRole(CreateRoleRequest req) async {
    await create(req.toJson());
  }
  Future<void> updateRole(int id, UpdateRoleRequest req) async {
    await update(id, compact(req.toJson()));
  }
  Future<void> deleteRole(int id) async {
    await delete(id);
  }
}
