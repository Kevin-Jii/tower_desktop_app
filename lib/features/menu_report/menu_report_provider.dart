import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../auth/session_manager.dart';
import '../dish/dish_api.dart';
import '../dish/dish_category_api.dart';
import 'menu_report_api.dart';
import 'models.dart';

class MenuReportProvider with ChangeNotifier {
  final MenuReportApi _api;
  final DishApi _dishApi;
  final DishCategoryApi _categoryApi;

  MenuReportProvider(this._api, this._dishApi, this._categoryApi);

  List<MenuReportOrder> _reportOrders = [];
  List<MenuReportOrder> get reportOrders => _reportOrders;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  int _page = PaginationDefaults.firstPage;
  int get page => _page;

  int _pageSize = PaginationDefaults.pageSize;
  int get pageSize => _pageSize;

  int _total = 0;
  int get total => _total;

  DateTime? _startDate;
  DateTime? _endDate;

  DateTimeRange? get dateRange => (_startDate != null &&
          _endDate != null &&
          !_endDate!.isBefore(_startDate!))
      ? DateTimeRange(start: _startDate!, end: _endDate!)
      : null;

  bool get hasFilter => _startDate != null && _endDate != null;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  List<MenuReportOptionCategory>? _optionCache;

  // 加载报菜记录单列表
  Future<void> loadReportOrders({int? page, bool silent = false}) async {
    final targetPage = page ?? _page;
    if (!silent) {
      _loading = true;
      _error = null;
      notifyListeners();
    } else {
      _refreshing = true;
      notifyListeners();
    }
    try {
      final resp = await _api.getReportOrders(
        page: targetPage,
        pageSize: _pageSize,
        startDate: _formatDate(_startDate),
        endDate: _formatDate(_endDate),
      );
      _reportOrders = resp.list;
      _total = resp.total;
      _page = resp.page;
      _pageSize = resp.pageSize;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _reportOrders = [];
    } finally {
      _loading = false;
      _refreshing = false;
      notifyListeners();
    }
  }

  // 创建报菜记录单
  Future<bool> createReportOrder(String? remark, List<CreateMenuReportItemRequest> items) async {
    if (items.isEmpty) return false;

    final userId = _getCurrentUserId();
    if (userId == null) {
      _error = '无法获取当前用户ID';
      notifyListeners();
      return false;
    }

    final storeId = _currentStoreId;
    if (storeId == null) {
      _error = '无法获取当前门店ID';
      notifyListeners();
      return false;
    }

    try {
      final request = CreateMenuReportOrderRequest(
        storeId: storeId,
        userId: userId,
        remark: remark,
        items: items,
      );
      await _api.createReportOrder(request);
      _error = null;
      await loadReportOrders(page: PaginationDefaults.firstPage);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // 删除报菜记录单
  Future<bool> deleteReportOrder(int id) async {
    try {
      await _api.deleteReportOrder(id);
      final targetPage = _reportOrders.length == 1 && _page > 1 ? _page - 1 : _page;
      await loadReportOrders(page: targetPage);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // 创建报菜详情 (单个)
  Future<bool> createReportItem(int reportOrderId, CreateMenuReportItemRequest request) async {
    try {
      await _api.createReportItem(request);
      _error = null;
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // 更新报菜详情
  Future<bool> updateReportItem(int id, UpdateMenuReportItemRequest request) async {
    try {
      await _api.updateReportItem(id, request);
      _error = null;
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // 删除报菜详情
  Future<bool> deleteReportItem(int id) async {
    try {
      await _api.deleteReportItem(id);
      _error = null;
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // 为了向后兼容，保留旧方法
  @Deprecated('Use loadReportOrders instead')
  Future<void> loadReports({int? page, bool silent = false}) => loadReportOrders(page: page, silent: silent);

  @Deprecated('Use createReportOrder instead')
  Future<bool> createReport(CreateMenuReportRequest request) async {
    final userId = _getCurrentUserId();
    if (userId == null) {
      _error = '无法获取当前用户ID';
      notifyListeners();
      return false;
    }
    final storeId = _currentStoreId;
    if (storeId == null) {
      _error = '无法获取当前门店ID';
      notifyListeners();
      return false;
    }
    return createReportOrder(request.remark, [
      CreateMenuReportItemRequest(
        dishId: request.dishId,
        quantity: request.quantity,
        remark: request.remark,
      )
    ]);
  }

  @Deprecated('Use createReportOrder instead')
  Future<bool> createReports(List<CreateMenuReportRequest> requests) async {
    if (requests.isEmpty) return false;

    final userId = _getCurrentUserId();
    if (userId == null) {
      _error = '无法获取当前用户ID';
      notifyListeners();
      return false;
    }

    final storeId = _currentStoreId;
    if (storeId == null) {
      _error = '无法获取当前门店ID';
      notifyListeners();
      return false;
    }

    final items = requests.map((r) => CreateMenuReportItemRequest(
      dishId: r.dishId,
      quantity: r.quantity,
      remark: r.remark,
    )).toList();

    return createReportOrder(null, items);
  }

  @Deprecated('Use deleteReportOrder instead')
  Future<bool> deleteReport(int id) => deleteReportOrder(id);

  @Deprecated('Use updateReportItem instead')
  Future<bool> updateReport(int id, UpdateMenuReportRequest request) async {
    try {
      await _api.updateReport(id, request);
      await loadReportOrders(page: _page, silent: true);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void setDateRange(DateTimeRange? range) {
    if (range == null) {
      _startDate = null;
      _endDate = null;
    } else {
      _startDate =
          DateTime(range.start.year, range.start.month, range.start.day);
      _endDate = DateTime(range.end.year, range.end.month, range.end.day);
    }
    notifyListeners();
  }

  Future<void> applyDateFilter(DateTimeRange? range) async {
    setDateRange(range);
    await loadReportOrders(page: PaginationDefaults.firstPage);
  }

  void clearFilters() {
    _startDate = null;
    _endDate = null;
    notifyListeners();
  }

  Future<MenuReportStats?> fetchStatistics({DateTimeRange? range}) async {
    final start = range?.start ?? _startDate;
    final end = range?.end ?? _endDate;
    if (start == null || end == null) {
      return null;
    }
    throw UnsupportedError('旧统计接口已废弃，数据统计功能需要重新实现');
  }

  int? get _currentStoreId {
    final storeId = SessionManager().userInfo?.storeId;
    if (storeId == null || storeId <= 0) return null;
    return storeId;
  }

  int? _getCurrentUserId() {
    final userId = SessionManager().userInfo?.id;
    if (userId == null || userId <= 0) return null;
    return userId;
  }

  Future<List<MenuReportOptionCategory>> fetchDishOptions(
      {bool forceRefresh = false}) async {
    final storeId = _currentStoreId;
    if (storeId == null) {
      _optionCache = [];
      return _optionCache!;
    }
    if (!forceRefresh && _optionCache != null) {
      return _optionCache!;
    }

    final categoryResult = await _categoryApi.list(storeId);
    List<MenuReportOptionCategory> categoryOptions = [];
    categoryResult.when(
      success: (categories) {
        categoryOptions = categories
            .map((c) => MenuReportOptionCategory(category: c, dishes: const []))
            .toList();
      },
      error: (msg, code) {
        throw Exception(msg);
      },
    );

    final List<MenuReportOptionCategory> filled = [];
    for (final option in categoryOptions) {
      final dishResult = await _dishApi.list(
        storeId: storeId,
        categoryId: option.category.id,
      );
      dishResult.when(
        success: (dishes) {
          filled.add(MenuReportOptionCategory(
            category: option.category,
            dishes: dishes,
          ));
        },
        error: (msg, code) {
          throw Exception(msg);
        },
      );
    }
    _optionCache = filled;
    return _optionCache!;
  }

  void setPageSize(int size) {
    if (size <= 0) return;
    _pageSize = size;
    notifyListeners();
  }

  String? get filterLabel {
    if (_startDate == null || _endDate == null) return null;
    final start = _formatDate(_startDate);
    final end = _formatDate(_endDate);
    if (start == null || end == null) return null;
    return '$start ~ $end';
  }

  static String? _formatDate(DateTime? date) {
    if (date == null) return null;
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
