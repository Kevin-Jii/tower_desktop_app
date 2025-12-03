import 'package:flutter/foundation.dart';
import 'supplier_repository.dart';
import 'models.dart';
import '../../core/network/api_response.dart';

class SupplierProvider with ChangeNotifier {
  final SupplierRepository _repository;

  SupplierProvider(this._repository);

  // Supplier State
  List<Supplier> _suppliers = [];
  List<Supplier> get suppliers => _suppliers;
  
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

  // Supplier Category State
  List<SupplierCategory> _categories = [];
  List<SupplierCategory> get categories => _categories;

  // Supplier Product State
  List<SupplierProduct> _products = [];
  List<SupplierProduct> get products => _products;
  
  int _productPage = 1;
  int get productPage => _productPage;
  
  int _productTotal = 0;
  int get productTotal => _productTotal;

  // Store Binding State
  List<StoreSupplierProduct> _storeBindings = [];
  List<StoreSupplierProduct> get storeBindings => _storeBindings;
  
  int _bindingPage = 1;
  int get bindingPage => _bindingPage;
  
  int _bindingTotal = 0;
  int get bindingTotal => _bindingTotal;

  // Store Supplier Products (for purchase order creation)
  List<StoreSupplierProduct> _storeSupplierProducts = [];
  List<StoreSupplierProduct> get storeSupplierProducts => _storeSupplierProducts;

  // Supplier Methods
  Future<void> loadSuppliers({
    int? page,
    int? pageSize,
    String? keyword,
  }) async {
    if (page != null) _page = page;
    if (pageSize != null) _pageSize = pageSize;

    _loading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.getSuppliers(
      page: _page,
      pageSize: _pageSize,
      keyword: keyword,
    );

    result.when(
      success: (response) {
        _suppliers = response.list;
        _total = response.total;
        _page = response.page;
        _pageSize = response.pageSize;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _suppliers = [];
      },
    );

    _loading = false;
    notifyListeners();
  }

  Future<bool> createSupplier(Map<String, dynamic> data) async {
    final result = await _repository.createSupplier(data);
    return result.when(
      success: (_) {
        loadSuppliers(page: 1);
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> updateSupplier(int id, Map<String, dynamic> data) async {
    final result = await _repository.updateSupplier(id, data);
    return result.when(
      success: (_) {
        loadSuppliers(); // Refresh current page
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> deleteSupplier(int id) async {
    final result = await _repository.deleteSupplier(id);
    return result.when(
      success: (_) {
        loadSuppliers();
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  // Supplier Category Methods
  Future<void> loadCategories(int supplierId) async {
    _loading = true;
    notifyListeners();

    final result = await _repository.getSupplierCategories(supplierId);

    result.when(
      success: (list) {
        _categories = list;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _categories = [];
      },
    );

    _loading = false;
    notifyListeners();
  }

  Future<bool> createCategory(Map<String, dynamic> data) async {
    final result = await _repository.createSupplierCategory(data);
    return result.when(
      success: (category) {
        if (category != null) {
          loadCategories(category.supplierId);
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

  Future<bool> updateCategory(int id, Map<String, dynamic> data) async {
    final result = await _repository.updateSupplierCategory(id, data);
    return result.when(
      success: (category) {
        if (category != null) {
          loadCategories(category.supplierId);
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

  Future<bool> deleteCategory(int id, int supplierId) async {
    final result = await _repository.deleteSupplierCategory(id);
    return result.when(
      success: (_) {
        loadCategories(supplierId);
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  // Supplier Product Methods
  Future<void> loadProducts({
    int? page,
    int? pageSize,
    int? supplierId,
    int? categoryId,
    String? keyword,
  }) async {
    if (page != null) _productPage = page;
    
    _loading = true;
    notifyListeners();

    final result = await _repository.getSupplierProducts(
      page: _productPage,
      pageSize: pageSize ?? 10,
      supplierId: supplierId,
      categoryId: categoryId,
      keyword: keyword,
    );

    result.when(
      success: (response) {
        _products = response.list;
        _productTotal = response.total;
        _productPage = response.page;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _products = [];
      },
    );

    _loading = false;
    notifyListeners();
  }

  Future<bool> createProduct(Map<String, dynamic> data) async {
    final result = await _repository.createSupplierProduct(data);
    return result.when(
      success: (product) {
        if (product != null) {
          loadProducts(page: 1, supplierId: product.supplierId);
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

  Future<bool> updateProduct(int id, Map<String, dynamic> data) async {
    final result = await _repository.updateSupplierProduct(id, data);
    return result.when(
      success: (product) {
        if (product != null) {
          loadProducts(supplierId: product.supplierId);
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

  Future<bool> deleteProduct(int id, int supplierId) async {
    final result = await _repository.deleteSupplierProduct(id);
    return result.when(
      success: (_) {
        loadProducts(supplierId: supplierId);
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  // Store Binding Methods
  Future<void> loadStoreBindings({
    int? page,
    int? pageSize,
    required int storeId,
    int? supplierId,
  }) async {
    if (page != null) _bindingPage = page;

    _loading = true;
    notifyListeners();

    final result = await _repository.getStoreSupplierProducts(
      page: _bindingPage,
      pageSize: pageSize ?? 10,
      storeId: storeId,
      supplierId: supplierId,
    );

    result.when(
      success: (response) {
        _storeBindings = response.list;
        _bindingTotal = response.total;
        _bindingPage = response.page;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _storeBindings = [];
      },
    );

    _loading = false;
    notifyListeners();
  }

  // Store Bound Suppliers
  List<StoreSupplier> _storeSuppliers = [];
  List<StoreSupplier> get storeSuppliers => _storeSuppliers;

  // 从 StoreSupplier 中提取 Supplier 列表
  List<Supplier> get boundSuppliers =>
      _storeSuppliers.where((s) => s.supplier != null).map((s) => s.supplier!).toList();

  /// 加载门店已绑定的供应商
  Future<void> loadBoundSuppliers(int storeId) async {
    _loading = true;
    // 延迟通知，避免在 build 阶段触发 setState
    await Future.microtask(() => notifyListeners());

    final result = await _repository.getStoreBoundSuppliers(storeId);
    result.when(
      success: (list) {
        _storeSuppliers = list;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _storeSuppliers = [];
      },
    );

    _loading = false;
    notifyListeners();
  }

  /// 绑定供应商
  Future<bool> bindSuppliers(int storeId, List<int> supplierIds) async {
    final result = await _repository.bindSuppliers(storeId, supplierIds);
    return result.when(
      success: (_) {
        loadBoundSuppliers(storeId);
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  /// 解绑供应商
  Future<bool> unbindSupplier(int storeId, int supplierId) async {
    final result = await _repository.unbindSuppliers(storeId, [supplierId]);
    return result.when(
      success: (_) {
        loadBoundSuppliers(storeId);
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  // 保留旧方法兼容
  Future<bool> bindProducts(int storeId, List<int> productIds) async {
    return bindSuppliers(storeId, productIds);
  }

  Future<bool> unbindProducts(int storeId, List<int> productIds) async {
    final result = await _repository.unbindSuppliers(storeId, productIds);
    return result.when(
      success: (_) {
        loadBoundSuppliers(storeId);
        return true;
      },
      failure: (err) {
        _error = err.message;
        notifyListeners();
        return false;
      },
    );
  }

  /// 绑定单个供应商商品（兼容旧代码）
  Future<bool> bindProduct(BindSupplierProductRequest request) async {
    return bindSuppliers(request.storeId, [request.supplierProductId]);
  }

  /// 解绑单个供应商商品（兼容旧代码）
  Future<bool> unbindProduct(int productId, int storeId) async {
    return unbindSupplier(storeId, productId);
  }

  /// 设置默认供应商（暂时保留）
  Future<bool> setDefaultSupplier(int bindingId, int storeId) async {
    _error = null;
    notifyListeners();
    return true;
  }

  /// 加载当前门店绑定的供应商商品（用于采购单创建）
  Future<void> loadStoreSupplierProducts({int? storeId}) async {
    _loading = true;
    notifyListeners();

    final result = await _repository.listStoreSupplierProducts(storeId: storeId);

    result.when(
      success: (list) {
        _storeSupplierProducts = list;
        _error = null;
      },
      failure: (err) {
        _error = err.message;
        _storeSupplierProducts = [];
      },
    );

    _loading = false;
    notifyListeners();
  }

  // 门店可采购商品
  List<SupplierProduct> _purchasableProducts = [];
  List<SupplierProduct> get purchasableProducts => _purchasableProducts;

  /// 加载门店可采购的商品（基于已绑定的供应商）
  Future<void> loadPurchasableProducts({
    int? supplierId,
    int? categoryId,
    String? keyword,
  }) async {
    _loading = true;
    notifyListeners();

    debugPrint('=== Provider: loadPurchasableProducts ===');
    debugPrint('supplierId: $supplierId');

    final result = await _repository.getStorePurchasableProducts(
      supplierId: supplierId,
      categoryId: categoryId,
      keyword: keyword,
    );

    result.when(
      success: (list) {
        debugPrint('success: ${list.length} items');
        _purchasableProducts = list;
        _error = null;
      },
      failure: (err) {
        debugPrint('failure: ${err.message}');
        _error = err.message;
        _purchasableProducts = [];
      },
    );

    _loading = false;
    notifyListeners();
  }
}
