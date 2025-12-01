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
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _api.getPurchaseOrders(
        page: page,
        pageSize: pageSize,
        storeId: storeId,
        supplierId: supplierId,
        status: status,
        startDate: startDate,
        endDate: endDate,
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

  Future<Result<PurchaseOrder?>> confirmPurchaseOrder(int id) async {
    try {
      final order = await _api.confirmPurchaseOrder(id);
      return Result.success(order);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }

  Future<Result<PurchaseOrder?>> cancelPurchaseOrder(int id) async {
    try {
      final order = await _api.cancelPurchaseOrder(id);
      return Result.success(order);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
}
