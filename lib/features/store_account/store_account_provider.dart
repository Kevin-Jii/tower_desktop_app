import 'package:flutter/foundation.dart';
import 'store_account_repository.dart';
import 'models.dart';
import 'store_account_row.dart';
class StoreAccountProvider with ChangeNotifier {
  final StoreAccountRepository _repository;
  StoreAccountProvider(this._repository);
  List<StoreAccount> _accounts = [];
  List<StoreAccount> get accounts => _accounts;
  int _page = 1;
  int get page => _page;
  int _total = 0;
  int get total => _total;
  int _pageSize = 50;
  int get pageSize => _pageSize;
  bool _loading = false;
  bool get loading => _loading;
  String? _error;
  String? get error => _error;
  StoreAccountStats? _stats;
  StoreAccountStats? get stats => _stats;
  int? _filterStoreId;
  String? _filterChannel;
  String? _filterStartDate;
  String? _filterEndDate;
  bool _saving = false;
  bool get saving => _saving;
  Future<void> loadAccounts({
    int? page,
    int? pageSize,
    int? storeId,
    String? channel,
    String? startDate,
    String? endDate,
  }) async {
    if (page != null) _page = page;
    if (pageSize != null) _pageSize = pageSize;
    if (storeId != null) _filterStoreId = storeId;
    if (channel != null) _filterChannel = channel;
    if (startDate != null) _filterStartDate = startDate;
    if (endDate != null) _filterEndDate = endDate;
    _loading = true;
    _error = null;
    notifyListeners();
    final result = await _repository.getStoreAccounts(
      page: _page,
      pageSize: _pageSize,
      storeId: _filterStoreId,
      channel: _filterChannel,
      startDate: _filterStartDate,
      endDate: _filterEndDate,
    );
    result.when(
      success: (response) {
        _accounts = response.list;
        _total = response.total;
        _page = response.page;
        _pageSize = response.pageSize;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _accounts = [];
      },
    );
    _loading = false;
    notifyListeners();
  }
  Future<void> loadStats({
    int? storeId,
    String? startDate,
    String? endDate,
  }) async {
    final result = await _repository.getStoreAccountStats(
      storeId: storeId ?? _filterStoreId,
      startDate: startDate ?? _filterStartDate,
      endDate: endDate ?? _filterEndDate,
    );
    result.when(
      success: (stats) {
        _stats = stats;
        notifyListeners();
      },
      failure: (_) {},
    );
  }
  Future<bool> deleteAccount(int id) async {
    final result = await _repository.deleteStoreAccount(id);
    if (result.isFailure) {
      _error = result.errorOrNull?.message;
      notifyListeners();
      return false;
    }
    return true;
  }
  Future<bool> createBatchAccounts({
    required String channel,
    required String accountDate,
    required List<StoreAccountRow> items,
  }) async {
    if (items.isEmpty) {
      _error = '请至少添加一个商品';
      notifyListeners();
      return false;
    }
    _saving = true;
    _error = null;
    notifyListeners();
    final request = CreateStoreAccountRequest(
      channel: channel,
      accountDate: accountDate,
      items: items.map((item) => CreateStoreAccountItem(
        productId: item.productId!,
        spec: item.spec.isEmpty ? null : item.spec,
        quantity: item.quantity,
        unit: item.unit.isEmpty ? null : item.unit,
        price: item.price,
        amount: item.amount,
      )).toList(),
    );
    final result = await _repository.createStoreAccounts(request);
    final success = result.when(
      success: (_) => true,
      failure: (err) {
        _error = err.message;
        return false;
      },
    );
    _saving = false;
    notifyListeners();
    return success;
  }
  void clearFilters() {
    _filterStoreId = null;
    _filterChannel = null;
    _filterStartDate = null;
    _filterEndDate = null;
    loadAccounts(page: 1);
  }
}
