import '../../core/network/api_client.dart';
import 'models.dart';

class DictApi {
  final ApiClient _client;
  
  DictApi(this._client);

  static const String _typesPath = '/dict-types';
  static const String _dataPath = '/dict-data';
  static const String _dictsPath = '/dicts';

  // ============= 字典类型接口 =============

  /// 获取字典类型列表
  Future<List<DictType>> getDictTypes({String? keyword}) async {
    return _client.getSimpleList<DictType>(
      path: _typesPath,
      queryParameters: {
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      },
      fromJson: DictType.fromJson,
    );
  }

  /// 获取字典类型详情
  Future<DictType> getDictType(int id) async {
    return _client.getSmart<DictType>(
      path: '$_typesPath/$id',
      fromJson: DictType.fromJson,
    );
  }

  /// 创建字典类型
  Future<DictType?> createDictType(CreateDictTypeRequest req) async {
    return _client.postSmart<DictType>(
      path: _typesPath,
      data: req.toJson(),
      fromJson: DictType.fromJson,
    );
  }

  /// 更新字典类型
  Future<DictType?> updateDictType(int id, UpdateDictTypeRequest req) async {
    return _client.putSmart<DictType>(
      path: '$_typesPath/$id',
      data: req.toJson(),
      fromJson: DictType.fromJson,
    );
  }

  /// 删除字典类型
  Future<void> deleteDictType(int id) async {
    await _client.deleteSmart(path: '$_typesPath/$id');
  }

  // ============= 字典数据接口 =============

  /// 根据type_code获取字典数据
  Future<List<DictData>> getDictDataByCode(String typeCode) async {
    return _client.getSimpleList<DictData>(
      path: _dataPath,
      queryParameters: {'type_code': typeCode},
      fromJson: DictData.fromJson,
    );
  }

  /// 根据type_id获取字典数据
  Future<List<DictData>> getDictDataByTypeId(int typeId) async {
    return _client.getSimpleList<DictData>(
      path: _dataPath,
      queryParameters: {'type_id': typeId},
      fromJson: DictData.fromJson,
    );
  }

  /// 获取字典数据详情
  Future<DictData> getDictData(int id) async {
    return _client.getSmart<DictData>(
      path: '$_dataPath/$id',
      fromJson: DictData.fromJson,
    );
  }

  /// 创建字典数据
  Future<DictData?> createDictData(CreateDictDataRequest req) async {
    return _client.postSmart<DictData>(
      path: _dataPath,
      data: req.toJson(),
      fromJson: DictData.fromJson,
    );
  }

  /// 更新字典数据
  Future<DictData?> updateDictData(int id, UpdateDictDataRequest req) async {
    return _client.putSmart<DictData>(
      path: '$_dataPath/$id',
      data: req.toJson(),
      fromJson: DictData.fromJson,
    );
  }

  /// 删除字典数据
  Future<void> deleteDictData(int id) async {
    await _client.deleteSmart(path: '$_dataPath/$id');
  }

  // ============= 通用接口 =============

  /// 获取所有字典（用于前端缓存）
  Future<Map<String, List<DictData>>> getAllDicts() async {
    final resp = await _client.dio.get(_dictsPath);
    final body = resp.data;
    if (body is! Map || body['data'] is! Map) {
      return {};
    }
    final data = body['data'] as Map<String, dynamic>;
    final result = <String, List<DictData>>{};
    data.forEach((key, value) {
      if (value is List) {
        result[key] = value
            .map((item) => DictData.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
    });
    return result;
  }
}
