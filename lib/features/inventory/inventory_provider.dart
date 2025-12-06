import 'package:flutter/foundation.dart';
import 'inventory_repository.dart';
import 'models.dart';
class InventoryProvider with ChangeNotifier {
  final InventoryRepository _repository;
  InventoryProvider(this._repository);
  List<Inventory> _inventories = [];
  List<Inventory> get inventories => _inventories;
  int _inventoryPage = 1;
  int get inventoryPage => _inventoryPage;
  int _inventoryTotal = 0;
  int get inventoryTotal => _inventoryTotal;
  int _inventoryPageSize = 20;
  int get inventoryPageSize => _inventoryPageSize;
  bool _inventoryLoading = false;
  bool get inventoryLoading => _inventoryLoading;
  String? _inventoryError;
  String? get inventoryError => _inventoryError;
  List<InventoryOrder> _orders = [];
  List<InventoryOrder> get orders => _orders;
  int _orderPage = 1;
  int get orderPage => _orderPage;
  int _orderTotal = 0;
  int get orderTotal => _orderTotal;
  int _orderPageSize = 20;
  int get orderPageSize => _orderPageSize;
  bool _orderLoading = false;
  bool get orderLoading => _orderLoading;
  String? _orderError;
  String? get orderError => _orderError;
  List<InventoryRecord> _records = [];
  List<InventoryRecord> get records => _records;
  int _recordPage = 1;
  int get recordPage => _recordPage;
  int _recordTotal = 0;
  int get recordTotal => _recordTotal;
  int _recordPageSize = 20;
  int get recordPageSize => _recordPageSize;
  bool _recordLoading = false;
  bool get recordLoading => _recordLoading;
  String? _recordError;
  String? get recordError => _recordError;
  int? _filterStoreId;
  int? get filterStoreId => _filterStoreId;
  int? _filterProductId;
  int? get filterProductId => _filterProductId;
  int? _filterType;
  int? get filterType => _filterType;
  bool _creating = false;
  bool get creating => _creating;
  Future<void> loadInventories({
    int? page,
    int? pageSize,
    int? storeId,
    int? productId,
  }) async {
    if (page != null) _inventoryPage = page;
    if (pageSize != null) _inventoryPageSize = pageSize;
    if (storeId != null) _filterStoreId = storeId;
    if (productId != null) _filterProductId = productId;
    _inventoryLoading = true;
    _inventoryError = null;
    notifyListeners();
    final result = await _repository.getInventories(
      page: _inventoryPage,
      pageSize: _inventoryPageSize,
      storeId: _filterStoreId,
      productId: _filterProductId,
    );
    result.when(
      success: (response) {
        _inventories = response.list;
        _inventoryTotal = response.total;
        _inventoryPage = response.page;
        _inventoryPageSize = response.pageSize;
        _inventoryError = null;
      },
      failure: (err) {
        _inventoryError = err.message;
        _inventories = [];
      },
    );
    _inventoryLoading = false;
    notifyListeners();
  }
  Future<void> loadOrders({
    int? page,
    int? pageSize,
    int? storeId,
    int? type,
  }) async {
    if (page != null) _orderPage = page;
    if (pageSize != null) _orderPageSize = pageSize;
    if (storeId != null) _filterStoreId = storeId;
    if (type != null) _filterType = type;
    _orderLoading = true;
    _orderError = null;
    notifyListeners();
    final result = await _repository.getInventoryOrders(
      page: _orderPage,
      pageSize: _orderPageSize,
      storeId: _filterStoreId,
      type: _filterType,
    );
    result.when(
      success: (response) {
        _orders = response.list;
        _orderTotal = response.total;
        _orderPage = response.page;
        _orderPageSize = response.pageSize;
        _orderError = null;
      },
      failure: (err) {
        _orderError = err.message;
        _orders = [];
      },
    );
    _orderLoading = false;
    notifyListeners();
  }
  Future<InventoryOrder?> getOrderDetail(int id) async {
    final result = await _repository.getInventoryOrderById(id);
    return result.when(
      success: (order) => order,
      failure: (_) => null,
    );
  }
  Future<bool> createOrder(CreateInventoryOrderRequest request) async {
    _creating = true;
    _orderError = null;
    notifyListeners();
    final result = await _repository.createInventoryOrder(request);
    _creating = false;
    return result.when(
      success: (_) {
        loadInventories(page: 1);
        loadOrders(page: 1);
        notifyListeners();
        return true;
      },
      failure: (err) {
        _orderError = err.message;
        notifyListeners();
        return false;
      },
    );
  }
  Future<void> loadRecords({
    int? page,
    int? pageSize,
    int? storeId,
    int? productId,
    int? type,
  }) async {
    if (page != null) _recordPage = page;
    if (pageSize != null) _recordPageSize = pageSize;
    if (storeId != null) _filterStoreId = storeId;
    if (productId != null) _filterProductId = productId;
    if (type != null) _filterType = type;
    _recordLoading = true;
    _recordError = null;
    notifyListeners();
    final result = await _repository.getInventoryRecords(
      page: _recordPage,
      pageSize: _recordPageSize,
      storeId: _filterStoreId,
      productId: _filterProductId,
      type: _filterType,
    );
    result.when(
      success: (response) {
        _records = response.list;
        _recordTotal = response.total;
        _recordPage = response.page;
        _recordPageSize = response.pageSize;
        _recordError = null;
      },
      failure: (err) {
        _recordError = err.message;
        _records = [];
      },
    );
    _recordLoading = false;
    notifyListeners();
  }
  Future<bool> createRecord(CreateInventoryRecordRequest request) async {
    _creating = true;
    _recordError = null;
    notifyListeners();
    final result = await _repository.createInventoryRecord(request);
    _creating = false;
    return result.when(
      success: (_) {
        loadInventories(page: 1);
        loadRecords(page: 1);
        notifyListeners();
        return true;
      },
      failure: (err) {
        _recordError = err.message;
        notifyListeners();
        return false;
      },
    );
  }
  void clearInventoryFilters() {
    _filterStoreId = null;
    _filterProductId = null;
    loadInventories(page: 1);
  }
  void clearRecordFilters() {
    _filterStoreId = null;
    _filterProductId = null;
    _filterType = null;
    loadRecords(page: 1);
  }
}
