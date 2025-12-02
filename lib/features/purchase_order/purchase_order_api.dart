import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import '../../core/constants/app_constants.dart';
import 'models.dart';

class PurchaseOrderApi {
  final ApiClient _client;

  PurchaseOrderApi(this._client);

  Future<PageResponse<PurchaseOrder>> getPurchaseOrders({
    int page = 1,
    int pageSize = 10,
    int? storeId,
    int? supplierId,
    int? status,
    String? startDate,
    String? endDate,
  }) async {
    return _client.getPage<PurchaseOrder>(
      ApiPaths.purchaseOrders,
      itemParser: PurchaseOrder.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (storeId != null) 'store_id': storeId,
        if (supplierId != null) 'supplier_id': supplierId,
        if (status != null) 'status': status,
        if (startDate != null) 'start_date': startDate,
        if (endDate != null) 'end_date': endDate,
      },
    );
  }

  Future<PurchaseOrder?> getPurchaseOrder(int id) async {
    return await _client.getSmart<PurchaseOrder>(
      path: '${ApiPaths.purchaseOrders}/$id',
      fromJson: PurchaseOrder.fromJson,
    );
  }

  /// 按供应商分组获取采购单明细
  Future<Map<String, dynamic>?> getPurchaseOrderBySupplier(int id) async {
    return await _client.getSmart<Map<String, dynamic>>(
      path: '${ApiPaths.purchaseOrders}/$id/by-supplier',
      fromJson: (json) => json,
    );
  }

  Future<PurchaseOrder?> createPurchaseOrder(CreatePurchaseOrderRequest request) async {
    return await _client.postSmart<PurchaseOrder>(
      path: ApiPaths.purchaseOrders,
      data: request.toJson(),
      fromJson: PurchaseOrder.fromJson,
    );
  }

  Future<void> updatePurchaseOrder(int id, UpdatePurchaseOrderRequest request) async {
    await _client.putSmart<PurchaseOrder>(
      path: '${ApiPaths.purchaseOrders}/$id',
      data: request.toJson(),
      fromJson: PurchaseOrder.fromJson,
    );
  }

  Future<void> deletePurchaseOrder(int id) async {
    await _client.deleteSmart(path: '${ApiPaths.purchaseOrders}/$id');
  }

  /// 确认订单 - 更新状态为已确认(2)
  Future<void> confirmPurchaseOrder(int id) async {
    await updatePurchaseOrder(id, const UpdatePurchaseOrderRequest(status: PurchaseOrderStatus.confirmed));
  }

  /// 取消订单 - 更新状态为已取消(4)
  Future<void> cancelPurchaseOrder(int id) async {
    await updatePurchaseOrder(id, const UpdatePurchaseOrderRequest(status: PurchaseOrderStatus.cancelled));
  }
}
