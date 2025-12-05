import 'package:flutter/foundation.dart';
import 'dict_repository.dart';
import 'models.dart';

class DictProvider with ChangeNotifier {
  final DictRepository _repository;

  DictProvider(this._repository);

  // ============= 字典类型状态 =============
  List<DictType> _types = [];
  List<DictType> get types => _types;

  DictType? _selectedType;
  DictType? get selectedType => _selectedType;

  // ============= 字典数据状态 =============
  List<DictData> _dataList = [];
  List<DictData> get dataList => _dataList;

  // ============= 通用状态 =============
  bool _loading = false;
  bool get loading => _loading;

  bool _dataLoading = false;
  bool get dataLoading => _dataLoading;

  String? _error;
  String? get error => _error;

  String? _keyword;
  String? get keyword => _keyword;

  // ============= 字典缓存 =============
  Map<String, List<DictData>> _dictCache = {};
  Map<String, List<DictData>> get dictCache => _dictCache;

  // ============= 字典类型方法 =============

  Future<void> loadTypes({String? keyword}) async {
    _keyword = keyword;
    _loading = true;
    _error = null;
    await Future.microtask(() => notifyListeners());

    final result = await _repository.getDictTypes(keyword: keyword);
    result.when(
      success: (list) {
        _types = list;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _types = [];
      },
    );

    _loading = false;
    notifyListeners();
  }

  void selectType(DictType? type) {
    _selectedType = type;
    _dataList = [];
    notifyListeners();
    if (type != null) {
      loadDataByTypeId(type.id);
    }
  }

  Future<bool> createType(CreateDictTypeRequest req) async {
    final result = await _repository.createDictType(req);
    return result.when(
      success: (_) {
        loadTypes(keyword: _keyword);
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> updateType(int id, UpdateDictTypeRequest req) async {
    final result = await _repository.updateDictType(id, req);
    return result.when(
      success: (_) {
        loadTypes(keyword: _keyword);
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> deleteType(int id) async {
    final result = await _repository.deleteDictType(id);
    return result.when(
      success: (_) {
        if (_selectedType?.id == id) {
          _selectedType = null;
          _dataList = [];
        }
        loadTypes(keyword: _keyword);
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  // ============= 字典数据方法 =============

  Future<void> loadDataByTypeId(int typeId) async {
    _dataLoading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.getDictDataByTypeId(typeId);
    result.when(
      success: (list) {
        _dataList = list;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _dataList = [];
      },
    );

    _dataLoading = false;
    notifyListeners();
  }

  Future<bool> createData(CreateDictDataRequest req) async {
    final result = await _repository.createDictData(req);
    return result.when(
      success: (_) {
        if (_selectedType != null) {
          loadDataByTypeId(_selectedType!.id);
        }
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> updateData(int id, UpdateDictDataRequest req) async {
    final result = await _repository.updateDictData(id, req);
    return result.when(
      success: (_) {
        if (_selectedType != null) {
          loadDataByTypeId(_selectedType!.id);
        }
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> deleteData(int id) async {
    final result = await _repository.deleteDictData(id);
    return result.when(
      success: (_) {
        if (_selectedType != null) {
          loadDataByTypeId(_selectedType!.id);
        }
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  // ============= 缓存方法 =============

  Future<void> loadAllDicts() async {
    debugPrint('=== 开始加载字典缓存 ===');
    final result = await _repository.getAllDicts();
    result.when(
      success: (data) {
        _dictCache = data;
        debugPrint('字典缓存加载成功，共 ${data.length} 个类型');
        data.forEach((key, value) {
          debugPrint('  $key: ${value.length} 条数据');
        });
      },
      failure: (err) {
        debugPrint('加载字典缓存失败: ${err.message}');
      },
    );
  }

  /// 根据类型编码获取字典数据（从缓存）
  List<DictData> getDictByCode(String typeCode) {
    return _dictCache[typeCode] ?? [];
  }

  /// 根据类型编码和值获取标签
  String? getLabelByValue(String typeCode, String value) {
    final list = getDictByCode(typeCode);
    try {
      return list.firstWhere((d) => d.value == value).label;
    } catch (_) {
      return null;
    }
  }
}
