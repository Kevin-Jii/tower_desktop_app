import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/response_utils.dart';
import '../../core/constants/error_texts.dart';
import '../../core/utils/map_utils.dart';
import 'models.dart';

/// 菜单管理 & 用户菜单 API
/// 假设后端 REST 设计：
/// GET    /menus            分页查询菜单
/// POST   /menus            创建菜单
/// PUT    /menus/{id}       更新菜单
/// DELETE /menus/{id}       删除菜单
/// GET    /menus/user-menus 当前用户可见树
/// GET    /menus/user-permissions 当前用户权限
/// 如与后端不符，可在此集中适配。

class MenuApi {
  final Dio _dio = ApiClient().dio;
  final ApiClient _client = ApiClient();

  Future<List<MenuItem>> getUserMenus() async {
    try {
      final resp = await _dio.get('${ApiPaths.menus}/user-menus');
      final list = ResponseUtils.payloadToList(resp.data, listKey: 'menus');
      return list.map(MenuItem.fromJson).toList();
    } on DioException catch (e) {
      throw ApiException(e.message ?? ErrorTexts.loadMenus,
          statusCode: e.response?.statusCode);
    }
  }

  Future<List<String>> getUserPermissions() async {
    try {
      final resp = await _dio.get('${ApiPaths.menus}/user-permissions');
      final list =
          ResponseUtils.payloadToList(resp.data, listKey: 'permissions');
      return list
          .map((e) => e['permission']?.toString() ?? e.values.first.toString())
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.message ?? ErrorTexts.loadPermissions,
          statusCode: e.response?.statusCode);
    }
  }

  /// 获取完整菜单树（管理界面使用）
  Future<List<MenuItem>> getMenuTree() async {
    try {
      // 使用 /menus/tree 接口获取树形结构
      final resp = await _dio.get('${ApiPaths.menus}/tree');
      final list = ResponseUtils.payloadToList(resp.data, listKey: 'menus');
      return list.map(MenuItem.fromJson).toList();
    } on DioException catch (e) {
      throw ApiException(e.message ?? ErrorTexts.loadMenuTree,
          statusCode: e.response?.statusCode);
    }
  }

  /// 创建菜单
  Future<void> createMenu(CreateMenuRequest req) async {
    await _client.post<void>(ApiPaths.menus, data: req.toJson());
  }

  /// 更新菜单
  Future<void> updateMenu(int id, UpdateMenuRequest req) async {
    final data = compact(req.toJson());
    await _client.request<void>('${ApiPaths.menus}/$id',
        method: 'PUT', data: data);
  }

  /// 删除菜单
  Future<void> deleteMenu(int id) async {
    await _client.request<void>('${ApiPaths.menus}/$id', method: 'DELETE');
  }

  /// 获取角色已分配的菜单ID列表（用于回显）
  Future<List<int>> getRoleMenuIds(int roleId) async {
    try {
      final resp = await _dio.get(
        '${ApiPaths.menus}/role-ids',
        queryParameters: {'role_id': roleId},
      );
      
      // 解析响应数据
      dynamic body = resp.data;
      List<dynamic> rawList = [];
      
      if (body is Map) {
        // 尝试多种可能的key
        rawList = body['menu_ids'] ?? body['data'] ?? body['list'] ?? [];
      } else if (body is List) {
        rawList = body;
      }
      
      final result = <int>[];
      for (final e in rawList) {
        if (e is int) {
          result.add(e);
        } else if (e is Map) {
          // 如果是 {id: 1} 或 {menu_id: 1} 格式
          final id = e['id'] ?? e['menu_id'];
          if (id != null) {
            result.add(id is int ? id : int.parse(id.toString()));
          }
        } else {
          result.add(int.parse(e.toString()));
        }
      }
      return result;
    } on DioException catch (e) {
      throw ApiException(e.message ?? '获取角色菜单失败',
          statusCode: e.response?.statusCode);
    }
  }

  /// 为角色分配菜单权限
  Future<void> assignRoleMenus(int roleId, List<int> menuIds) async {
    await _client.post<void>(
      '${ApiPaths.menus}/assign-role',
      data: {
        'role_id': roleId,
        'menu_ids': menuIds,
      },
    );
  }

  /// 获取角色菜单树
  Future<List<MenuItem>> getRoleMenuTree(int roleId) async {
    try {
      final resp = await _dio.get(
        '${ApiPaths.menus}/role',
        queryParameters: {'role_id': roleId},
      );
      final list = ResponseUtils.payloadToList(resp.data, listKey: 'menus');
      return list.map(MenuItem.fromJson).toList();
    } on DioException catch (e) {
      throw ApiException(e.message ?? '获取角色菜单树失败',
          statusCode: e.response?.statusCode);
    }
  }
}
