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
      ApiPaths.storeSupplierProducts,
      itemParser: StoreSupplierProduct.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        'store_id': storeId,
        if (supplierId != null) 'supplier_id': supplierId,
      },
    );
  }

  Future<StoreSupplierProduct?> bindSupplierProduct(BindSupplierProductRequest request) async {
    return await _client.postSmart<StoreSupplierProduct>(
      path: ApiPaths.storeSupplierProducts,
      data: request.toJson(),
      fromJson: StoreSupplierProduct.fromJson,
    );
  }

  Future<void> unbindSupplierProduct(int id) async {
    await _client.deleteSmart(path: '${ApiPaths.storeSupplierProducts}/$id');
  }

  Future<StoreSupplierProduct?> setDefaultSupplier(int id, int storeId) async {
    return await _client.putSmart<StoreSupplierProduct>(
      path: '${ApiPaths.storeSupplierProducts}/$id/set-default',
      data: {'store_id': storeId},
      fromJson: StoreSupplierProduct.fromJson,
    );
  }
}
