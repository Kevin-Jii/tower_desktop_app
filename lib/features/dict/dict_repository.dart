import '../../core/error/app_error.dart';
import '../../core/error/result.dart';
import 'dict_api.dart';
import 'models.dart';

class DictRepository {
  final DictApi _api;

  DictRepository(this._api);

  // ============= 字典类型 =============

  Future<Result<List<DictType>>> getDictTypes({String? keyword}) async {
    try {
      final list = await _api.getDictTypes(keyword: keyword);
      return Result.success(list);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<DictType>> getDictType(int id) async {
    try {
      final item = await _api.getDictType(id);
      return Result.success(item);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<DictType?>> createDictType(CreateDictTypeRequest req) async {
    try {
      final item = await _api.createDictType(req);
      return Result.success(item);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<DictType?>> updateDictType(int id, UpdateDictTypeRequest req) async {
    try {
      final item = await _api.updateDictType(id, req);
      return Result.success(item);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> deleteDictType(int id) async {
    try {
      await _api.deleteDictType(id);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  // ============= 字典数据 =============

  Future<Result<List<DictData>>> getDictDataByCode(String typeCode) async {
    try {
      final list = await _api.getDictDataByCode(typeCode);
      return Result.success(list);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<List<DictData>>> getDictDataByTypeId(int typeId) async {
    try {
      final list = await _api.getDictDataByTypeId(typeId);
      return Result.success(list);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<DictData?>> createDictData(CreateDictDataRequest req) async {
    try {
      final item = await _api.createDictData(req);
      return Result.success(item);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<DictData?>> updateDictData(int id, UpdateDictDataRequest req) async {
    try {
      final item = await _api.updateDictData(id, req);
      return Result.success(item);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> deleteDictData(int id) async {
    try {
      await _api.deleteDictData(id);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  // ============= 通用 =============

  Future<Result<Map<String, List<DictData>>>> getAllDicts() async {
    try {
      final data = await _api.getAllDicts();
      return Result.success(data);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
}
