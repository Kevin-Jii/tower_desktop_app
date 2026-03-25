import '../../core/network/api_client.dart';
import '../../core/constants/app_constants.dart';
import 'models.dart';
class MemberApi {
  final ApiClient _client;
  MemberApi(this._client);
  Future<Member> createMember(CreateMemberReq req) async {
    final resp = await _client.post<Map<String, dynamic>>(
      ApiPaths.members,
      data: req.toJson(),
    );
    return Member.fromJson(resp);
  }
  Future<MemberListResp> getMembers({
    String? keyword,
    int page = 1,
    int pageSize = 20,
  }) async {
    final resp = await _client.get<Map<String, dynamic>>(
      ApiPaths.members,
      queryParameters: {
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
        'page': page,
        'page_size': pageSize,
      },
    );
    return MemberListResp.fromJson(resp);
  }
  Future<Member?> getMemberByPhone(String phone) async {
    final resp = await _client.get<Map<String, dynamic>>(
      '${ApiPaths.members}/phone',
      queryParameters: {'phone': phone},
    );
    if (resp['data'] == null) return null;
    return Member.fromJson(resp['data'] as Map<String, dynamic>);
  }
  Future<Member> getMemberById(int id) async {
    final resp = await _client.get<Map<String, dynamic>>(
      '${ApiPaths.members}/$id',
    );
    return Member.fromJson(resp);
  }
  Future<Member> updateMember(int id, UpdateMemberReq req) async {
    final resp = await _client.request<Map<String, dynamic>>(
      '${ApiPaths.members}/$id',
      method: 'PUT',
      data: req.toJson(),
    );
    return Member.fromJson(resp);
  }
  Future<void> deleteMember(int id) async {
    await _client.delete('${ApiPaths.members}/$id');
  }
  Future<void> adjustBalance(int id, AdjustBalanceReq req) async {
    await _client.post<void>(
      '${ApiPaths.members}/$id/adjust-balance',
      data: req.toJson(),
    );
  }
  Future<WalletLogListResp> getWalletLogs({
    int? memberId,
    int? changeType,
    String? startTime,
    String? endTime,
    int page = 1,
    int pageSize = 20,
  }) async {
    final resp = await _client.get<Map<String, dynamic>>(
      ApiPaths.walletLogs,
      queryParameters: {
        if (memberId != null) 'memberId': memberId,
        if (changeType != null) 'changeType': changeType,
        if (startTime != null) 'startTime': startTime,
        if (endTime != null) 'endTime': endTime,
        'page': page,
        'page_size': pageSize,
      },
    );
    return WalletLogListResp.fromJson(resp);
  }
  Future<RechargeOrder> createRechargeOrder(CreateRechargeOrderReq req) async {
    final resp = await _client.post<Map<String, dynamic>>(
      ApiPaths.rechargeOrders,
      data: req.toJson(),
    );
    return RechargeOrder.fromJson(resp);
  }
  Future<RechargeOrderListResp> getRechargeOrders({
    int? memberId,
    int? status,
    int page = 1,
    int pageSize = 20,
  }) async {
    final resp = await _client.get<Map<String, dynamic>>(
      ApiPaths.rechargeOrders,
      queryParameters: {
        if (memberId != null) 'memberId': memberId,
        if (status != null) 'status': status,
        'page': page,
        'page_size': pageSize,
      },
    );
    return RechargeOrderListResp.fromJson(resp);
  }
  Future<RechargeOrder> getRechargeOrderById(int id) async {
    final resp = await _client.get<Map<String, dynamic>>(
      '${ApiPaths.rechargeOrders}/$id',
    );
    return RechargeOrder.fromJson(resp);
  }
  Future<void> payRechargeOrder(PayRechargeOrderReq req) async {
    await _client.post<void>(
      '${ApiPaths.rechargeOrders}/pay',
      data: req.toJson(),
    );
  }
  Future<void> cancelRechargeOrder(String orderNo) async {
    await _client.post<void>(
      '${ApiPaths.rechargeOrders}/$orderNo/cancel',
    );
  }
}