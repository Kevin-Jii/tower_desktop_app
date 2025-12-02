import 'package:flutter/foundation.dart';
import 'purchase_order_repository.dart';
import 'models.dart';

class PurchaseOrderProvider with ChangeNotifier {
  final PurchaseOrderRepository _repository;

  PurchaseOrderProvider(this._repository);

  // Order List State
  List<PurchaseOrder> _orders = [];
  List<PurchaseOrder> get orders => _orders;

  int _page = 1;
  int get page => _page;

  int _total = 0;
  int get total => _total;

  int _pageSize = 10;
  int get pageSize => _pageSize;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  // Filter State
  int? _filterStoreId;
  int? get filterStoreId => _filterStoreId;

  int? _filterSupplierId;
  int? get filterSupplierId => _filterSupplierId;

  int? _filterStatus;
  int? get filterStatus => _filterStatus;

  String? _filterStartDate;
  String? get filterStartDate => _filterStartDate;

  String? _filterEndDate;
  String? get filterEndDate => _filterEndDate;

  // Current Order Detail
  PurchaseOrder? _currentOrder;
  PurchaseOrder? get currentOrder => _currentOrder;

  bool _detailLoading = false;
  bool get detailLoading => _detailLoading;

  // Creating State
  bool _creating = false;
  bool get creating => _creating;

  Future<void> loadOrders({
    int? page,
    int? pageSize,
    int? storeId,
    int? supplierId,
    int? status,
    String? startDate,
    String? endDate,
  }) async {
    if (page != null) _page = page;
    if (pageSize != null) _pageSize = pageSize;
    if (storeId != null) _filterStoreId = storeId;
    if (supplierId != null) _filterSupplierId = supplierId;
    if (status != null) _filterStatus = status;
    if (startDate != null) _filterStartDate = startDate;
    if (endDate != null) _filterEndDate = endDate;

    _loading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.getPurchaseOrders(
      page: _page,
      pageSize: _pageSize,
      storeId: _filterStoreId,
      supplierId: _filterSupplierId,
      status: _filterStatus,
      startDate: _filterStartDate,
      endDate: _filterEndDate,
    );

    result.when(
      success: (response) {
        _orders = response.list;
        _total = response.total;
        _page = response.page;
        _pageSize = response.pageSize;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _orders = [];
      },
    );

    _loading = false;
    notifyListeners();
  }

  void clearFilters() {
    _filterStoreId = null;
    _filterSupplierId = null;
    _filterStatus = null;
    _filterStartDate = null;
    _filterEndDate = null;
    loadOrders(page: 1);
  }

  Future<void> loadOrderDetail(int id) async {
    _detailLoading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.getPurchaseOrder(id);

    result.when(
      success: (order) {
        _currentOrder = order;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _currentOrder = null;
      },
    );

    _detailLoading = false;
    notifyListeners();
  }

  Future<bool> createOrder(CreatePurchaseOrderRequest request) async {
    _creating = true;
    _error = null;
    notifyListeners();

    final result = await _repository.createPurchaseOrder(request);
    _creating = false;

    return result.when(
      success: (order) {
        loadOrders(page: 1);
        notifyListeners();
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> confirmOrder(int id) async {
    final result = await _repository.confirmPurchaseOrder(id);
    return result.when(
      success: (_) {
        // 重新加载详情和列表
        loadOrderDetail(id);
        loadOrders();
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> cancelOrder(int id) async {
    final result = await _repository.cancelPurchaseOrder(id);
    return result.when(
      success: (_) {
        // 重新加载详情和列表
        loadOrderDetail(id);
        loadOrders();
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> deleteOrder(int id) async {
    final result = await _repository.deletePurchaseOrder(id);
    return result.when(
      success: (_) {
        loadOrders();
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  void clearCurrentOrder() {
    _currentOrder = null;
    notifyListeners();
  }
}
