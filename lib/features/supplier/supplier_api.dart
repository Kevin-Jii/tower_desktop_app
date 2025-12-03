import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import '../../core/constants/app_constants.dart';
import 'models.dart';

class SupplierApi {
  final ApiClient _client;

  SupplierApi(this._client);

  // Supplier Methods
  Future<PageResponse<Supplier>> getSuppliers({
    int page = 1,
    int pageSize = 10,
    String? keyword,
  }) async {
    return _client.getPage<Supplier>(
      ApiPaths.suppliers,
      itemParser: Supplier.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      },
    );
  }

  Future<List<Supplier>> listSuppliers() async {
    try {
      return await _client.getSimpleList<Supplier>(
        path: '${ApiPaths.suppliers}/all',
        fromJson: Supplier.fromJson,
      );
    } catch (e) {
      return [];
    }
  }

  Future<Supplier?> createSupplier(Map<String, dynamic> data) async {
    return await _client.postSmart<Supplier>(
      path: ApiPaths.suppliers,
      data: data,
      fromJson: Supplier.fromJson,
    );
  }

  Future<Supplier?> updateSupplier(int id, Map<String, dynamic> data) async {
    return await _client.putSmart<Supplier>(
      path: '${ApiPaths.suppliers}/$id',
      data: data,
      fromJson: Supplier.fromJson,
    );
  }

  Future<void> deleteSupplier(int id) async {
    await _client.deleteSmart(path: '${ApiPaths.suppliers}/$id');
  }

  // Supplier Category Methods
  Future<List<SupplierCategory>> getSupplierCategories(int supplierId) async {
    return await _client.getSimpleList<SupplierCategory>(
      path: ApiPaths.supplierCategories,
      fromJson: SupplierCategory.fromJson,
      queryParameters: {'supplier_id': supplierId},
    );
  }

  Future<SupplierCategory?> createSupplierCategory(Map<String, dynamic> data) async {
    return await _client.postSmart<SupplierCategory>(
      path: ApiPaths.supplierCategories,
      data: data,
      fromJson: SupplierCategory.fromJson,
    );
  }

  Future<SupplierCategory?> updateSupplierCategory(int id, Map<String, dynamic> data) async {
    return await _client.putSmart<SupplierCategory>(
      path: '${ApiPaths.supplierCategories}/$id',
      data: data,
      fromJson: SupplierCategory.fromJson,
    );
  }

  Future<void> deleteSupplierCategory(int id) async {
    await _client.deleteSmart(path: '${ApiPaths.supplierCategories}/$id');
  }

  // Supplier Product Methods
  Future<PageResponse<SupplierProduct>> getSupplierProducts({
    int page = 1,
    int pageSize = 10,
    int? supplierId,
    int? categoryId,
    String? keyword,
  }) async {
    return _client.getPage<SupplierProduct>(
      ApiPaths.supplierProducts,
      itemParser: SupplierProduct.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (supplierId != null) 'supplier_id': supplierId,
        if (categoryId != null) 'category_id': categoryId,
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      },
    );
  }

  Future<SupplierProduct?> createSupplierProduct(Map<String, dynamic> data) async {
    return await _client.postSmart<SupplierProduct>(
      path: ApiPaths.supplierProducts,
      data: data,
      fromJson: SupplierProduct.fromJson,
    );
  }

  Future<SupplierProduct?> updateSupplierProduct(int id, Map<String, dynamic> data) async {
    return await _client.putSmart<SupplierProduct>(
      path: '${ApiPaths.supplierProducts}/$id',
      data: data,
      fromJson: SupplierProduct.fromJson,
    );
  }

  Future<void> deleteSupplierProduct(int id) async {
    await _client.deleteSmart(path: '${ApiPaths.supplierProducts}/$id');
  }

  // Store Supplier Product Binding Methods
  Future<PageResponse<StoreSupplierProduct>> getStoreSupplierProducts({
    int page = 1,
    int pageSize = 10,
    required int storeId,
    int? supplierId,
  }) async {
    return _client.getPage<StoreSupplierProduct>(
      ApiPaths.storeSuppliers,
      itemParser: StoreSupplierProduct.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        'store_id': storeId,
        if (supplierId != null) 'supplier_id': supplierId,
      },
    );
  }

  /// 获取当前门店绑定的供应商商品列表（不分页）
  Future<List<StoreSupplierProduct>> listStoreSupplierProducts({int? storeId}) async {
    return await _client.getSimpleList<StoreSupplierProduct>(
      path: ApiPaths.storeSuppliers,
      fromJson: StoreSupplierProduct.fromJson,
      queryParameters: {
        if (storeId != null) 'store_id': storeId,
      },
    );
  }

  /// 门店绑定供应商
  Future<void> bindSuppliers(int storeId, List<int> supplierIds) async {
    await _client.postSmart<void>(
      path: '${ApiPaths.storeSuppliers}',
      data: {
        'store_id': storeId,
        'supplier_ids': supplierIds,
      },
      fromJson: (_) => null,
    );
  }

  /// 门店解绑供应商
  /// DELETE /api/v1/store-suppliers
  Future<void> unbindSuppliers(int storeId, List<int> supplierIds) async {
    await _client.deleteSmart(
      path: ApiPaths.storeSuppliers,
      data: {
        'store_id': storeId,
        'supplier_ids': supplierIds,
      },
    );
  }

  /// 获取门店已绑定的供应商列表
  /// GET /api/v1/store-suppliers?store_id=xxx
  /// 返回数组格式，每项包含 supplier 嵌套对象
  Future<List<StoreSupplier>> getStoreBoundSuppliers(int storeId) async {
    return await _client.getSimpleList<StoreSupplier>(
      path: ApiPaths.storeSuppliers,
      fromJson: StoreSupplier.fromJson,
      queryParameters: {'store_id': storeId},
    );
  }

  /// 获取门店可采购的商品列表（基于已绑定的供应商）
  /// GET /api/v1/store-suppliers/products
  Future<List<SupplierProduct>> getStorePurchasableProducts({
    int? supplierId,
    int? categoryId,
    String? keyword,
  }) async {
    return await _client.getSimpleList<SupplierProduct>(
      path: '${ApiPaths.storeSuppliers}/products',
      fromJson: SupplierProduct.fromJson,
      queryParameters: {
        if (supplierId != null) 'supplier_id': supplierId,
        if (categoryId != null) 'category_id': categoryId,
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      },
    );
  }
}
