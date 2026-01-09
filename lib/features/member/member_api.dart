import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import 'models.dart';
class MemberApi {
  final ApiClient _client;
  MemberApi(this._client);
  Future<PageResponse<Member>> getMembers({
    int page = 1,
    int pageSize = 20,
    String? keyword,
  }) async {
    return _client.getPage<Member>(
      '/members',
      itemParser: Member.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      },
    );
  }
  Future<Member?> getMemberByPhone(String phone) async {
    return await _client.getSmart<Member>(
      path: '/members/phone?phone=$phone',
      fromJson: Member.fromJson,
    );
  }
  Future<Member?> getMemberById(int id) async {
    return await _client.getSmart<Member>(
      path: '/members/$id',
      fromJson: Member.fromJson,
    );
  }
  Future<Member?> createMember(CreateMemberRequest request) async {
    return await _client.postSmart<Member>(
      path: '/members',
      data: request.toJson(),
      fromJson: Member.fromJson,
    );
  }
  Future<Member?> updateMember(int id, UpdateMemberRequest request) async {
    return await _client.putSmart<Member>(
      path: '/members/$id',
      data: request.toJson(),
      fromJson: Member.fromJson,
    );
  }
  Future<void> deleteMember(int id) async {
    await _client.delete('/members/$id');
  }
  Future<Member?> adjustBalance(int id, AdjustBalanceRequest request) async {
    return await _client.postSmart<Member>(
      path: '/members/$id/adjust-balance',
      data: request.toJson(),
      fromJson: Member.fromJson,
    );
  }
  Future<PageResponse<WalletLog>> getWalletLogs({
    int page = 1,
    int pageSize = 20,
    int? memberId,
    int? type,
    String? startDate,
    String? endDate,
  }) async {
    return _client.getPage<WalletLog>(
      '/wallet-logs',
      itemParser: WalletLog.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (memberId != null) 'member_id': memberId,
        if (type != null) 'type': type,
        if (startDate != null) 'start_date': startDate,
        if (endDate != null) 'end_date': endDate,
      },
    );
  }
  Future<RechargeOrder?> createRechargeOrder(
      CreateRechargeOrderRequest request) async {
    return await _client.postSmart<RechargeOrder>(
      path: '/recharge-orders',
      data: request.toJson(),
      fromJson: RechargeOrder.fromJson,
    );
  }
  Future<PageResponse<RechargeOrder>> getRechargeOrders({
    int page = 1,
    int pageSize = 20,
    int? memberId,
    int? status,
    String? startDate,
    String? endDate,
  }) async {
    return _client.getPage<RechargeOrder>(
      '/recharge-orders',
      itemParser: RechargeOrder.fromJson,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
        if (memberId != null) 'member_id': memberId,
        if (status != null) 'status': status,
        if (startDate != null) 'start_date': startDate,
        if (endDate != null) 'end_date': endDate,
      },
    );
  }
  Future<RechargeOrder?> getRechargeOrderById(int id) async {
    return await _client.getSmart<RechargeOrder>(
      path: '/recharge-orders/$id',
      fromJson: RechargeOrder.fromJson,
    );
  }
  Future<RechargeOrder?> payRechargeOrder(
      String orderNo, PayRechargeOrderRequest request) async {
    return await _client.postSmart<RechargeOrder>(
      path: '/recharge-orders/pay',
      data: request.toJson(),
      fromJson: RechargeOrder.fromJson,
    );
  }
  Future<void> cancelRechargeOrder(String orderNo) async {
    await _client.post('/recharge-orders/$orderNo/cancel', data: {});
  }
}
