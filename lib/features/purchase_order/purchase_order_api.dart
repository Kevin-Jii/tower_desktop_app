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

  Future<PurchaseOrder?> createPurchaseOrder(CreatePurchaseOrderRequest request) async {
    return await _client.postSmart<PurchaseOrder>(
      path: ApiPaths.purchaseOrders,
      data: request.toJson(),
      fromJson: PurchaseOrder.fromJson,
    );
  }

  Future<PurchaseOrder?> updatePurchaseOrder(int id, Map<String, dynamic> data) async {
    return await _client.putSmart<PurchaseOrder>(
      path: '${ApiPaths.purchaseOrders}/$id',
      data: data,
      fromJson: PurchaseOrder.fromJson,
    );
  }

  Future<void> deletePurchaseOrder(int id) async {
    await _client.deleteSmart(path: '${ApiPaths.purchaseOrders}/$id');
  }

  Future<PurchaseOrder?> confirmPurchaseOrder(int id) async {
    return await _client.putSmart<PurchaseOrder>(
      path: '${ApiPaths.purchaseOrders}/$id/confirm',
      data: {},
      fromJson: PurchaseOrder.fromJson,
    );
  }

  Future<PurchaseOrder?> cancelPurchaseOrder(int id) async {
    return await _client.putSmart<PurchaseOrder>(
      path: '${ApiPaths.purchaseOrders}/$id/cancel',
      data: {},
      fromJson: PurchaseOrder.fromJson,
    );
  }
}
