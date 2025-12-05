import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'models.dart';
import 'purchase_order_api.dart';

class PurchaseOrderRepository {
  final PurchaseOrderApi _api;

  PurchaseOrderRepository(this._api);

  Future<Result<PageResponse<PurchaseOrder>>> getPurchaseOrders({
    int page = 1,
    int pageSize = 10,
    int? storeId,
    int? supplierId,
    int? status,
    String? date,
  }) async {
    try {
      final response = await _api.getPurchaseOrders(
        page: page,
        pageSize: pageSize,
        storeId: storeId,
        supplierId: supplierId,
        status: status,
        date: date,
      );
      return Result.success(response);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<PurchaseOrder?>> getPurchaseOrder(int id) async {
    try {
      final order = await _api.getPurchaseOrder(id);
      return Result.success(order);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<PurchaseOrder?>> createPurchaseOrder(CreatePurchaseOrderRequest request) async {
    try {
      final order = await _api.createPurchaseOrder(request);
      return Result.success(order);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> confirmPurchaseOrder(int id) async {
    try {
      await _api.confirmPurchaseOrder(id);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> cancelPurchaseOrder(int id) async {
    try {
      await _api.cancelPurchaseOrder(id);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<void>> deletePurchaseOrder(int id) async {
    try {
      await _api.deletePurchaseOrder(id);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
}
