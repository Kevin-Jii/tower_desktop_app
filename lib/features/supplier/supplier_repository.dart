import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'models.dart';
import 'supplier_api.dart';

class SupplierRepository {
  final SupplierApi _api;

  SupplierRepository(this._api);

  // Supplier Methods
  Future<Result<PageResponse<Supplier>>> getSuppliers({
    int page = 1,
    int pageSize = 10,
    String? keyword,
  }) async {
    try {
      final response = await _api.getSuppliers(
        page: page,
        pageSize: pageSize,
        keyword: keyword,
      );
      return Result.success(response);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<List<Supplier>>> listSuppliers() async {
    try {
      final list = await _api.listSuppliers();
      return Result.success(list);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<Supplier?>> createSupplier(Map<String, dynamic> data) async {
    try {
      final supplier = await _api.createSupplier(data);
      return Result.success(supplier);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<Supplier?>> updateSupplier(int id, Map<String, dynamic> data) async {
    try {
      final supplier = await _api.updateSupplier(id, data);
      return Result.success(supplier);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> deleteSupplier(int id) async {
    try {
      await _api.deleteSupplier(id);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  // Supplier Category Methods
  Future<Result<List<SupplierCategory>>> getSupplierCategories(int supplierId) async {
    try {
      final list = await _api.getSupplierCategories(supplierId);
      return Result.success(list);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<SupplierCategory?>> createSupplierCategory(Map<String, dynamic> data) async {
    try {
      final category = await _api.createSupplierCategory(data);
      return Result.success(category);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<SupplierCategory?>> updateSupplierCategory(int id, Map<String, dynamic> data) async {
    try {
      final category = await _api.updateSupplierCategory(id, data);
      return Result.success(category);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> deleteSupplierCategory(int id) async {
    try {
      await _api.deleteSupplierCategory(id);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  // Supplier Product Methods
  Future<Result<PageResponse<SupplierProduct>>> getSupplierProducts({
    int page = 1,
    int pageSize = 10,
    int? supplierId,
    int? categoryId,
    String? keyword,
  }) async {
    try {
      final response = await _api.getSupplierProducts(
        page: page,
        pageSize: pageSize,
        supplierId: supplierId,
        categoryId: categoryId,
        keyword: keyword,
      );
      return Result.success(response);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<SupplierProduct?>> createSupplierProduct(Map<String, dynamic> data) async {
    try {
      final product = await _api.createSupplierProduct(data);
      return Result.success(product);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<SupplierProduct?>> updateSupplierProduct(int id, Map<String, dynamic> data) async {
    try {
      final product = await _api.updateSupplierProduct(id, data);
      return Result.success(product);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> deleteSupplierProduct(int id) async {
    try {
      await _api.deleteSupplierProduct(id);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  // Store Supplier Product Binding Methods
  Future<Result<PageResponse<StoreSupplierProduct>>> getStoreSupplierProducts({
    int page = 1,
    int pageSize = 10,
    required int storeId,
    int? supplierId,
  }) async {
    try {
      final response = await _api.getStoreSupplierProducts(
        page: page,
        pageSize: pageSize,
        storeId: storeId,
        supplierId: supplierId,
      );
      return Result.success(response);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  /// 获取当前门店绑定的供应商商品列表（不分页）
  Future<Result<List<StoreSupplierProduct>>> listStoreSupplierProducts({int? storeId}) async {
    try {
      final list = await _api.listStoreSupplierProducts(storeId: storeId);
      return Result.success(list);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> bindSuppliers(int storeId, List<int> supplierIds) async {
    try {
      await _api.bindSuppliers(storeId, supplierIds);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> unbindSuppliers(int storeId, List<int> supplierIds) async {
    try {
      await _api.unbindSuppliers(storeId, supplierIds);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<List<StoreSupplier>>> getStoreBoundSuppliers(int storeId) async {
    try {
      final list = await _api.getStoreBoundSuppliers(storeId);
      return Result.success(list);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  /// 获取门店可采购的商品列表
  Future<Result<List<SupplierProduct>>> getStorePurchasableProducts({
    int? supplierId,
    int? categoryId,
    String? keyword,
  }) async {
    try {
      final list = await _api.getStorePurchasableProducts(
        supplierId: supplierId,
        categoryId: categoryId,
        keyword: keyword,
      );
      return Result.success(list);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
}
