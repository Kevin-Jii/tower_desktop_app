import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/network/response_utils.dart';
import 'models.dart';
class GalleryApi {
  final ApiClient _client;
  GalleryApi(this._client);
  Dio get _dio => _client.dio;
  String get _basePath => '/galleries';
  Future<ApiResult<GalleryListResult>> list({
    int page = 1,
    int pageSize = 20,
    String? category,
    String? keyword,
    int? storeId,
  }) async {
    try {
      final params = <String, dynamic>{
        'page': page,
        'page_size': pageSize,
      };
      if (category != null) params['category'] = category;
      if (keyword != null) params['keyword'] = keyword;
      if (storeId != null) params['store_id'] = storeId;
      final resp = await _dio.get(_basePath, queryParameters: params);
      final body = resp.data;
      List<dynamic> listData = [];
      int total = 0;
      if (body is Map<String, dynamic>) {
        if (body['list'] is List) {
          listData = body['list'];
          total = body['total'] is int ? body['total'] : int.tryParse(body['total']?.toString() ?? '0') ?? 0;
        }
        else if (body['data'] is List) {
          listData = body['data'];
          total = body['total'] is int ? body['total'] : int.tryParse(body['total']?.toString() ?? '0') ?? 0;
        }
        else if (body['data'] is Map<String, dynamic>) {
          final data = body['data'] as Map<String, dynamic>;
          if (data['list'] is List) {
            listData = data['list'];
          }
          total = data['total'] is int ? data['total'] : int.tryParse(data['total']?.toString() ?? '0') ?? 0;
        }
      } else if (body is List) {
        listData = body;
      }
      final items = listData
          .where((e) => e is Map<String, dynamic>)
          .map((e) => GalleryImage.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(GalleryListResult(
        list: items,
        total: total,
        page: page,
        pageSize: pageSize,
      ));
    } on DioException catch (e) {
      return ApiResult.error('加载图片列表失败', e.response?.statusCode);
    } catch (e) {
      return ApiResult.error('加载图片列表失败: $e', null);
    }
  }
  Future<ApiResult<GalleryImage?>> upload(
    String filePath, {
    String? category,
    String? remark,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        if (category != null) 'category': category,
        if (remark != null) 'remark': remark,
      });
      final resp = await _dio.post('$_basePath/upload', data: formData);
      final data = ResponseUtils.extractData(resp.data);
      if (data == null) return ApiResult.success(null);
      return ApiResult.success(GalleryImage.fromJson(Map<String, dynamic>.from(data)));
    } on DioException catch (e) {
      return ApiResult.error('上传图片失败', e.response?.statusCode);
    } catch (e) {
      return ApiResult.error('上传图片失败: $e', null);
    }
  }
  Future<ApiResult<GalleryImage?>> get(int id) async {
    try {
      final resp = await _dio.get('$_basePath/$id');
      final data = ResponseUtils.extractData(resp.data);
      if (data == null) return ApiResult.success(null);
      return ApiResult.success(GalleryImage.fromJson(Map<String, dynamic>.from(data)));
    } on DioException catch (e) {
      return ApiResult.error('获取图片详情失败', e.response?.statusCode);
    } catch (e) {
      return ApiResult.error('获取图片详情失败: $e', null);
    }
  }
  Future<ApiResult<void>> update(int id, UpdateGalleryRequest payload) async {
    try {
      await _dio.put('$_basePath/$id', data: payload.toJson());
      return ApiResult.success(null);
    } on DioException catch (e) {
      return ApiResult.error('更新图片失败', e.response?.statusCode);
    } catch (e) {
      return ApiResult.error('更新图片失败: $e', null);
    }
  }
  Future<ApiResult<void>> delete(int id) async {
    try {
      await _dio.delete('$_basePath/$id');
      return ApiResult.success(null);
    } on DioException catch (e) {
      return ApiResult.error('删除图片失败', e.response?.statusCode);
    } catch (e) {
      return ApiResult.error('删除图片失败: $e', null);
    }
  }
  Future<ApiResult<void>> batchDelete(List<int> ids) async {
    try {
      await _dio.post('$_basePath/batch-delete', data: {'ids': ids});
      return ApiResult.success(null);
    } on DioException catch (e) {
      return ApiResult.error('批量删除失败', e.response?.statusCode);
    } catch (e) {
      return ApiResult.error('批量删除失败: $e', null);
    }
  }
}
class GalleryListResult {
  final List<GalleryImage> list;
  final int total;
  final int page;
  final int pageSize;
  GalleryListResult({
    required this.list,
    required this.total,
    required this.page,
    required this.pageSize,
  });
  bool get hasMore => page * pageSize < total;
}
