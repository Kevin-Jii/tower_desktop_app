import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import 'models.dart';
class InventoryApi {
  final ApiClient _client;
  InventoryApi(this._client);
  Future<PageResponse<Inventory>> getInventories({
    int page = 1,
    int pageSize = 20,
    int? storeId,
    int? productId,
  }) async {
    return _client.getPage<Inventory>(
      '/inventories',
      itemParser: Inventory.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (storeId != null) 'store_id': storeId,
        if (productId != null) 'product_id': productId,
      },
    );
  }
  Future<PageResponse<InventoryOrder>> getInventoryOrders({
    int page = 1,
    int pageSize = 20,
    int? storeId,
    int? type,
  }) async {
    return _client.getPage<InventoryOrder>(
      '/inventory-orders',
      itemParser: InventoryOrder.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (storeId != null) 'store_id': storeId,
        if (type != null) 'type': type,
      },
    );
  }
  Future<InventoryOrder?> getInventoryOrderByNo(String orderNo) async {
    return await _client.getSmart<InventoryOrder>(
      path: '/inventory-orders/no/$orderNo',
      fromJson: InventoryOrder.fromJson,
    );
  }
  Future<InventoryOrder?> getInventoryOrderById(int id) async {
    return await _client.getSmart<InventoryOrder>(
      path: '/inventory-orders/$id',
      fromJson: InventoryOrder.fromJson,
    );
  }
  Future<InventoryOrder?> createInventoryOrder(CreateInventoryOrderRequest request) async {
    return await _client.postSmart<InventoryOrder>(
      path: '/inventory-orders',
      data: request.toJson(),
      fromJson: InventoryOrder.fromJson,
    );
  }
  Future<PageResponse<InventoryRecord>> getInventoryRecords({
    int page = 1,
    int pageSize = 20,
    int? storeId,
    int? productId,
    int? type,
  }) async {
    return _client.getPage<InventoryRecord>(
      '/inventory-records',
      itemParser: InventoryRecord.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (storeId != null) 'store_id': storeId,
        if (productId != null) 'product_id': productId,
        if (type != null) 'type': type,
      },
    );
  }
  Future<InventoryRecord?> createInventoryRecord(CreateInventoryRecordRequest request) async {
    return await _client.postSmart<InventoryRecord>(
      path: '/inventory-records',
      data: request.toJson(),
      fromJson: InventoryRecord.fromJson,
    );
  }
  Future<Inventory?> updateInventory(int id, UpdateInventoryRequest request) async {
    return await _client.putSmart<Inventory>(
      path: '/inventories/$id',
      data: request.toJson(),
      fromJson: Inventory.fromJson,
    );
  }
}
