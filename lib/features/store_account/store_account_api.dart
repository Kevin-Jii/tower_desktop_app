import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import 'models.dart';
class StoreAccountApi {
  final ApiClient _client;
  StoreAccountApi(this._client);
  Future<PageResponse<StoreAccount>> getStoreAccounts({
    int page = 1,
    int pageSize = 20,
    int? storeId,
    String? channel,
    String? startDate,
    String? endDate,
  }) async {
    return _client.getPage<StoreAccount>(
      '/store-accounts',
      itemParser: StoreAccount.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (storeId != null) 'store_id': storeId,
        if (channel != null) 'channel': channel,
        if (startDate != null) 'start_date': startDate,
        if (endDate != null) 'end_date': endDate,
      },
    );
  }
  Future<StoreAccountStats?> getStoreAccountStats({
    int? storeId,
    String? startDate,
    String? endDate,
  }) async {
    return await _client.getSmart<StoreAccountStats>(
      path: '/store-accounts/stats',
      fromJson: StoreAccountStats.fromJson,
      queryParameters: {
        if (storeId != null) 'store_id': storeId,
        if (startDate != null) 'start_date': startDate,
        if (endDate != null) 'end_date': endDate,
      },
    );
  }
  Future<StoreAccount?> getStoreAccountById(int id) async {
    return await _client.getSmart<StoreAccount>(
      path: '/store-accounts/$id',
      fromJson: StoreAccount.fromJson,
    );
  }
  Future<List<StoreAccount>> createStoreAccounts(
      CreateStoreAccountRequest request) async {
    final data = request.toJson();
    final response = await _client.postPage<StoreAccount>(
      '/store-accounts',
      data: data,
      itemParser: StoreAccount.fromJson,
    );
    return response.list;
  }
  Future<StoreAccount?> updateStoreAccount(
      int id, UpdateStoreAccountRequest request) async {
    return await _client.putSmart<StoreAccount>(
      path: '/store-accounts/$id',
      data: request.toJson(),
      fromJson: StoreAccount.fromJson,
    );
  }
  Future<void> deleteStoreAccount(int id) async {
    await _client.delete('/store-accounts/$id');
  }
}
