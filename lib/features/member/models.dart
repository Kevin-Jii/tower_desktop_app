import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'models.freezed.dart';
part 'models.g.dart';
dynamic _convertToDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) {
    final parsed = double.tryParse(value);
    return parsed ?? 0.0;
  }
  return 0.0;
}
dynamic _convertToInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed != null) return parsed;
    final doubleParsed = double.tryParse(value);
    return doubleParsed?.toInt() ?? 0;
  }
  return 0;
}
@freezed
class Member with _$Member {
  const factory Member({
    required int id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'level_id') int? levelId,
    @JsonKey(name: 'level_name') String? levelName,
    @JsonKey(name: 'balance') double? balance,
    @JsonKey(name: 'total_recharge') double? totalRecharge,
    @JsonKey(name: 'total_consume') double? totalConsume,
    @JsonKey(name: 'points') int? points,
    @JsonKey(name: 'remark') String? remark,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Member;
  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: _convertToInt(json['id']) as int,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        levelId: _convertToInt(json['level_id']) as int?,
        levelName: json['level_name'] as String?,
        balance: _convertToDouble(json['balance']) as double?,
        totalRecharge: _convertToDouble(json['total_recharge']) as double?,
        totalConsume: _convertToDouble(json['total_consume']) as double?,
        points: _convertToInt(json['points']) as int?,
        remark: json['remark'] as String?,
        status: _convertToInt(json['status']) as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );
}
@freezed
class CreateMemberRequest with _$CreateMemberRequest {
  const factory CreateMemberRequest({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'phone') required String phone,
    @JsonKey(name: 'level_id') int? levelId,
    @JsonKey(name: 'remark') String? remark,
  }) = _CreateMemberRequest;
  factory CreateMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMemberRequestFromJson(json);
}
@freezed
class UpdateMemberRequest with _$UpdateMemberRequest {
  const factory UpdateMemberRequest({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'level_id') int? levelId,
    @JsonKey(name: 'remark') String? remark,
    @JsonKey(name: 'status') int? status,
  }) = _UpdateMemberRequest;
  factory UpdateMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateMemberRequestFromJson(json);
}
@freezed
class AdjustBalanceRequest with _$AdjustBalanceRequest {
  const factory AdjustBalanceRequest({
    @JsonKey(name: 'amount') required double amount,
    @JsonKey(name: 'type') required int type, 
    @JsonKey(name: 'remark') String? remark,
  }) = _AdjustBalanceRequest;
  factory AdjustBalanceRequest.fromJson(Map<String, dynamic> json) =>
      _$AdjustBalanceRequestFromJson(json);
}
@freezed
class WalletLog with _$WalletLog {
  const factory WalletLog({
    required int id,
    @JsonKey(name: 'member_id') int? memberId,
    @JsonKey(name: 'member_name') String? memberName,
    @JsonKey(name: 'member_phone') String? memberPhone,
    @JsonKey(name: 'type') int? type, 
    @JsonKey(name: 'type_name') String? typeName,
    @JsonKey(name: 'amount') double? amount,
    @JsonKey(name: 'balance_before') double? balanceBefore,
    @JsonKey(name: 'balance_after') double? balanceAfter,
    @JsonKey(name: 'remark') String? remark,
    @JsonKey(name: 'order_no') String? orderNo,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _WalletLog;
  factory WalletLog.fromJson(Map<String, dynamic> json) => WalletLog(
        id: _convertToInt(json['id']) as int,
        memberId: _convertToInt(json['member_id']) as int?,
        memberName: json['member_name'] as String?,
        memberPhone: json['member_phone'] as String?,
        type: _convertToInt(json['type']) as int?,
        typeName: json['type_name'] as String?,
        amount: _convertToDouble(json['amount']) as double?,
        balanceBefore: _convertToDouble(json['balance_before']) as double?,
        balanceAfter: _convertToDouble(json['balance_after']) as double?,
        remark: json['remark'] as String?,
        orderNo: json['order_no'] as String?,
        createdAt: json['created_at'] as String?,
      );
}
@freezed
class RechargeOrder with _$RechargeOrder {
  const factory RechargeOrder({
    required int id,
    @JsonKey(name: 'order_no') String? orderNo,
    @JsonKey(name: 'member_id') int? memberId,
    @JsonKey(name: 'member_name') String? memberName,
    @JsonKey(name: 'member_phone') String? memberPhone,
    @JsonKey(name: 'total_amount') double? totalAmount,
    @JsonKey(name: 'amount') double? amount,
    @JsonKey(name: 'pay_amount') double? payAmount,
    @JsonKey(name: 'gift_amount') double? giftAmount,
    @JsonKey(name: 'pay_type') int? payType,
    @JsonKey(name: 'pay_type_name') String? payTypeName,
    @JsonKey(name: 'pay_status') int? payStatus,
    @JsonKey(name: 'status_name') String? statusName,
    @JsonKey(name: 'remark') String? remark,
    @JsonKey(name: 'pay_time') String? payTime,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _RechargeOrder;
  factory RechargeOrder.fromJson(Map<String, dynamic> json) => RechargeOrder(
        id: _convertToInt(json['id']) as int,
        orderNo: json['order_no'] as String?,
        memberId: _convertToInt(json['member_id']) as int?,
        memberName: json['member_name'] as String?,
        memberPhone: json['member_phone'] as String?,
        totalAmount: _convertToDouble(json['total_amount']) as double?,
        amount: _convertToDouble(json['amount']) as double?,
        payAmount: _convertToDouble(json['pay_amount']) as double?,
        giftAmount: _convertToDouble(json['gift_amount']) as double?,
        payType: _convertToInt(json['pay_type']) as int?,
        payTypeName: json['pay_type_name'] as String?,
        payStatus: _convertToInt(json['pay_status']) as int?,
        statusName: json['status_name'] as String?,
        remark: json['remark'] as String?,
        payTime: json['pay_time'] as String?,
        createdAt: json['created_at'] as String?,
      );
}
@freezed
class CreateRechargeOrderRequest with _$CreateRechargeOrderRequest {
  const factory CreateRechargeOrderRequest({
    @JsonKey(name: 'member_id') required int memberId,
    @JsonKey(name: 'pay_amount') required double payAmount,
    @JsonKey(name: 'gift_amount') double? giftAmount,
    @JsonKey(name: 'pay_type') required int payType,
    @JsonKey(name: 'remark') String? remark,
  }) = _CreateRechargeOrderRequest;
  factory CreateRechargeOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRechargeOrderRequestFromJson(json);
}
@freezed
class PayRechargeOrderRequest with _$PayRechargeOrderRequest {
  const factory PayRechargeOrderRequest({
    @JsonKey(name: 'pay_type') required int payType,
    @JsonKey(name: 'transaction_no') String? transactionNo,
  }) = _PayRechargeOrderRequest;
  factory PayRechargeOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$PayRechargeOrderRequestFromJson(json);
}
@freezed
class MemberLevel with _$MemberLevel {
  const factory MemberLevel({
    required int id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'discount') int? discount,
    @JsonKey(name: 'min_amount') double? minAmount,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _MemberLevel;
  factory MemberLevel.fromJson(Map<String, dynamic> json) => MemberLevel(
        id: _convertToInt(json['id']) as int,
        name: json['name'] as String?,
        discount: _convertToInt(json['discount']) as int?,
        minAmount: _convertToDouble(json['min_amount']) as double?,
        status: _convertToInt(json['status']) as int?,
        createdAt: json['created_at'] as String?,
      );
}
@freezed
class MemberPageResponse with _$MemberPageResponse {
  const factory MemberPageResponse({
    required List<Member> list,
    required int total,
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'page_size') required int pageSize,
  }) = _MemberPageResponse;
  factory MemberPageResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['list'] as List)
        .map((item) => Member.fromJson(item as Map<String, dynamic>))
        .toList();
    return MemberPageResponse(
      list: list,
      total: _convertToInt(json['total']) as int,
      page: _convertToInt(json['page']) as int,
      pageSize: _convertToInt(json['page_size']) as int,
    );
  }
}
@freezed
class WalletLogPageResponse with _$WalletLogPageResponse {
  const factory WalletLogPageResponse({
    required List<WalletLog> list,
    required int total,
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'page_size') required int pageSize,
  }) = _WalletLogPageResponse;
  factory WalletLogPageResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['list'] as List)
        .map((item) => WalletLog.fromJson(item as Map<String, dynamic>))
        .toList();
    return WalletLogPageResponse(
      list: list,
      total: _convertToInt(json['total']) as int,
      page: _convertToInt(json['page']) as int,
      pageSize: _convertToInt(json['page_size']) as int,
    );
  }
}
@freezed
class RechargeOrderPageResponse with _$RechargeOrderPageResponse {
  const factory RechargeOrderPageResponse({
    required List<RechargeOrder> list,
    required int total,
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'page_size') required int pageSize,
  }) = _RechargeOrderPageResponse;
  factory RechargeOrderPageResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['list'] as List)
        .map((item) => RechargeOrder.fromJson(item as Map<String, dynamic>))
        .toList();
    return RechargeOrderPageResponse(
      list: list,
      total: _convertToInt(json['total']) as int,
      page: _convertToInt(json['page']) as int,
      pageSize: _convertToInt(json['page_size']) as int,
    );
  }
}
