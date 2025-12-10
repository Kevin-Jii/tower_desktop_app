import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'models.dart';
import 'inventory_api.dart';
class InventoryRepository {
  final InventoryApi _api;
  InventoryRepository(this._api);
  Future<Result<PageResponse<Inventory>>> getInventories({
    int page = 1,
    int pageSize = 20,
    int? storeId,
    int? productId,
  }) async {
    try {
      final response = await _api.getInventories(
        page: page,
        pageSize: pageSize,
        storeId: storeId,
        productId: productId,
      );
      return Result.success(response);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<PageResponse<InventoryOrder>>> getInventoryOrders({
    int page = 1,
    int pageSize = 20,
    int? storeId,
    int? type,
  }) async {
    try {
      final response = await _api.getInventoryOrders(
        page: page,
        pageSize: pageSize,
        storeId: storeId,
        type: type,
      );
      return Result.success(response);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<InventoryOrder?>> getInventoryOrderByNo(String orderNo) async {
    try {
      final order = await _api.getInventoryOrderByNo(orderNo);
      return Result.success(order);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<InventoryOrder?>> getInventoryOrderById(int id) async {
    try {
      final order = await _api.getInventoryOrderById(id);
      return Result.success(order);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<InventoryOrder?>> createInventoryOrder(CreateInventoryOrderRequest request) async {
    try {
      final order = await _api.createInventoryOrder(request);
      return Result.success(order);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<PageResponse<InventoryRecord>>> getInventoryRecords({
    int page = 1,
    int pageSize = 20,
    int? storeId,
    int? productId,
    int? type,
  }) async {
    try {
      final response = await _api.getInventoryRecords(
        page: page,
        pageSize: pageSize,
        storeId: storeId,
        productId: productId,
        type: type,
      );
      return Result.success(response);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<InventoryRecord?>> createInventoryRecord(CreateInventoryRecordRequest request) async {
    try {
      final record = await _api.createInventoryRecord(request);
      return Result.success(record);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<Inventory?>> updateInventory(int id, UpdateInventoryRequest request) async {
    try {
      final inventory = await _api.updateInventory(id, request);
      return Result.success(inventory);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
}
