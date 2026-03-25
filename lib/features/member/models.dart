import 'package:freezed_annotation/freezed_annotation.dart';
part 'models.freezed.dart';
part 'models.g.dart';
@freezed
class Member with _$Member {
  const factory Member({
    required int id,
    @JsonKey(name: 'uid') String? uid,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'level_id') int? levelId,
    @JsonKey(name: 'level_name') String? levelName,
    @JsonKey(name: 'balance') String? balance,
    @JsonKey(name: 'points') int? points,
    @JsonKey(name: 'version') int? version,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Member;
  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}
@freezed
class WalletLog with _$WalletLog {
  const factory WalletLog({
    required int id,
    @JsonKey(name: 'member_id') int? memberId,
    @JsonKey(name: 'change_type') int? changeType,
    @JsonKey(name: 'change_amount') String? changeAmount,
    @JsonKey(name: 'balance_before') String? balanceBefore,
    @JsonKey(name: 'balance_after') String? balanceAfter,
    @JsonKey(name: 'remark') String? remark,
    @JsonKey(name: 'order_no') String? orderNo,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _WalletLog;
  factory WalletLog.fromJson(Map<String, dynamic> json) => _$WalletLogFromJson(json);
}
@freezed
class RechargeOrder with _$RechargeOrder {
  const factory RechargeOrder({
    required int id,
    @JsonKey(name: 'order_no') String? orderNo,
    @JsonKey(name: 'member_id') int? memberId,
    @JsonKey(name: 'member_name') String? memberName,
    @JsonKey(name: 'pay_amount') String? payAmount,
    @JsonKey(name: 'gift_amount') String? giftAmount,
    @JsonKey(name: 'pay_type') int? payType,
    @JsonKey(name: 'pay_status') int? payStatus,
    @JsonKey(name: 'pay_time') String? payTime,
    @JsonKey(name: 'remark') String? remark,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _RechargeOrder;
  factory RechargeOrder.fromJson(Map<String, dynamic> json) => _$RechargeOrderFromJson(json);
}
@freezed
class CreateMemberReq with _$CreateMemberReq {
  const factory CreateMemberReq({
    String? uid,
    required String name,
    required String phone,
    int? levelId,
  }) = _CreateMemberReq;
  factory CreateMemberReq.fromJson(Map<String, dynamic> json) => _$CreateMemberReqFromJson(json);
}
@freezed
class UpdateMemberReq with _$UpdateMemberReq {
  const factory UpdateMemberReq({
    String? name,
    String? phone,
    int? points,
    int? level,
  }) = _UpdateMemberReq;
  factory UpdateMemberReq.fromJson(Map<String, dynamic> json) => _$UpdateMemberReqFromJson(json);
}
@freezed
class AdjustBalanceReq with _$AdjustBalanceReq {
  const factory AdjustBalanceReq({
    required String amount,
    required int type,
    String? remark,
    int? version,
  }) = _AdjustBalanceReq;
  factory AdjustBalanceReq.fromJson(Map<String, dynamic> json) => _$AdjustBalanceReqFromJson(json);
}
@freezed
class CreateRechargeOrderReq with _$CreateRechargeOrderReq {
  const factory CreateRechargeOrderReq({
    required int memberId,
    required String payAmount,
    String? giftAmount,
    required int payType,
    String? remark,
  }) = _CreateRechargeOrderReq;
  factory CreateRechargeOrderReq.fromJson(Map<String, dynamic> json) => _$CreateRechargeOrderReqFromJson(json);
}
@freezed
class PayRechargeOrderReq with _$PayRechargeOrderReq {
  const factory PayRechargeOrderReq({
    required String orderNo,
  }) = _PayRechargeOrderReq;
  factory PayRechargeOrderReq.fromJson(Map<String, dynamic> json) => _$PayRechargeOrderReqFromJson(json);
}
@freezed
class ListWalletLogReq with _$ListWalletLogReq {
  const factory ListWalletLogReq({
    int? memberId,
    int? changeType,
    String? startTime,
    String? endTime,
    int? page,
    int? pageSize,
  }) = _ListWalletLogReq;
  factory ListWalletLogReq.fromJson(Map<String, dynamic> json) => _$ListWalletLogReqFromJson(json);
}
@freezed
class ListRechargeOrderReq with _$ListRechargeOrderReq {
  const factory ListRechargeOrderReq({
    int? memberId,
    int? status,
    int? page,
    int? pageSize,
  }) = _ListRechargeOrderReq;
  factory ListRechargeOrderReq.fromJson(Map<String, dynamic> json) => _$ListRechargeOrderReqFromJson(json);
}
@freezed
class MemberListResp with _$MemberListResp {
  const factory MemberListResp({
    required List<Member> list,
    @JsonKey(name: 'total') int? total,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'page_size') int? pageSize,
  }) = _MemberListResp;
  factory MemberListResp.fromJson(Map<String, dynamic> json) => _$MemberListRespFromJson(json);
}
@freezed
class WalletLogListResp with _$WalletLogListResp {
  const factory WalletLogListResp({
    required List<WalletLog> list,
    @JsonKey(name: 'total') int? total,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'page_size') int? pageSize,
  }) = _WalletLogListResp;
  factory WalletLogListResp.fromJson(Map<String, dynamic> json) => _$WalletLogListRespFromJson(json);
}
@freezed
class RechargeOrderListResp with _$RechargeOrderListResp {
  const factory RechargeOrderListResp({
    required List<RechargeOrder> list,
    @JsonKey(name: 'total') int? total,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'page_size') int? pageSize,
  }) = _RechargeOrderListResp;
  factory RechargeOrderListResp.fromJson(Map<String, dynamic> json) => _$RechargeOrderListRespFromJson(json);
}
enum ChangeTypeEnum {
  recharge(1, '充值'),
  consume(2, '消费'),
  refund(3, '退款'),
  adjustAdd(4, '调增'),
  adjustLess(5, '调减');
  final int value;
  final String label;
  const ChangeTypeEnum(this.value, this.label);
  static ChangeTypeEnum? fromValue(int? value) {
    if (value == null) return null;
    return ChangeTypeEnum.values.where((e) => e.value == value).firstOrNull;
  }
}
enum PayStatusEnum {
  pending(0, '待支付'),
  paid(1, '已支付'),
  cancelled(2, '已取消'),
  refunded(3, '已退款');
  final int value;
  final String label;
  const PayStatusEnum(this.value, this.label);
  static PayStatusEnum? fromValue(int? value) {
    if (value == null) return null;
    return PayStatusEnum.values.where((e) => e.value == value).firstOrNull;
  }
}
enum PayTypeEnum {
  cash(0, '现金'),
  wechat(1, '微信'),
  alipay(2, '支付宝'),
  card(3, '银行卡'),
  other(4, '其他');
  final int value;
  final String label;
  const PayTypeEnum(this.value, this.label);
  static PayTypeEnum? fromValue(int? value) {
    if (value == null) return null;
    return PayTypeEnum.values.where((e) => e.value == value).firstOrNull;
  }
}