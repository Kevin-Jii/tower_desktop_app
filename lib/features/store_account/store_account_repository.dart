import 'package:tower_desktop_app/core/error/app_error.dart';
import 'package:tower_desktop_app/core/error/result.dart';
import 'package:tower_desktop_app/core/network/api_response.dart';
import 'models.dart';
import 'store_account_api.dart';
class StoreAccountRepository {
  final StoreAccountApi _api;
  StoreAccountRepository(this._api);
  Future<Result<PageResponse<StoreAccount>>> getStoreAccounts({
    int page = 1,
    int pageSize = 20,
    int? storeId,
    String? channel,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _api.getStoreAccounts(
        page: page,
        pageSize: pageSize,
        storeId: storeId,
        channel: channel,
        startDate: startDate,
        endDate: endDate,
      );
      return Result.success(response);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<StoreAccountStats?>> getStoreAccountStats({
    int? storeId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final stats = await _api.getStoreAccountStats(
        storeId: storeId,
        startDate: startDate,
        endDate: endDate,
      );
      return Result.success(stats);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<StoreAccount?>> getStoreAccountById(int id) async {
    try {
      final account = await _api.getStoreAccountById(id);
      return Result.success(account);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<List<StoreAccount>>> createStoreAccounts(CreateStoreAccountRequest request) async {
    try {
      final accounts = await _api.createStoreAccounts(request);
      return Result.success(accounts);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<StoreAccount?>> updateStoreAccount(int id, UpdateStoreAccountRequest request) async {
    try {
      final account = await _api.updateStoreAccount(id, request);
      return Result.success(account);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
  Future<Result<void>> deleteStoreAccount(int id) async {
    try {
      await _api.deleteStoreAccount(id);
      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(ErrorHandler.handleAny(e, stackTrace));
    }
  }
}
