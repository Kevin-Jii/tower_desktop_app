part of 'models.dart';
_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      levelId: (json['level_id'] as num?)?.toInt(),
      levelName: json['level_name'] as String?,
      balance: json['balance'] as String?,
      points: (json['points'] as num?)?.toInt(),
      version: (json['version'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'phone': instance.phone,
      'level_id': instance.levelId,
      'level_name': instance.levelName,
      'balance': instance.balance,
      'points': instance.points,
      'version': instance.version,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
_$WalletLogImpl _$$WalletLogImplFromJson(Map<String, dynamic> json) =>
    _$WalletLogImpl(
      id: (json['id'] as num).toInt(),
      memberId: (json['member_id'] as num?)?.toInt(),
      changeType: (json['change_type'] as num?)?.toInt(),
      changeAmount: json['change_amount'] as String?,
      balanceBefore: json['balance_before'] as String?,
      balanceAfter: json['balance_after'] as String?,
      remark: json['remark'] as String?,
      orderNo: json['order_no'] as String?,
      createdAt: json['created_at'] as String?,
    );
Map<String, dynamic> _$$WalletLogImplToJson(_$WalletLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'change_type': instance.changeType,
      'change_amount': instance.changeAmount,
      'balance_before': instance.balanceBefore,
      'balance_after': instance.balanceAfter,
      'remark': instance.remark,
      'order_no': instance.orderNo,
      'created_at': instance.createdAt,
    };
_$RechargeOrderImpl _$$RechargeOrderImplFromJson(Map<String, dynamic> json) =>
    _$RechargeOrderImpl(
      id: (json['id'] as num).toInt(),
      orderNo: json['order_no'] as String?,
      memberId: (json['member_id'] as num?)?.toInt(),
      memberName: json['member_name'] as String?,
      payAmount: json['pay_amount'] as String?,
      giftAmount: json['gift_amount'] as String?,
      payType: (json['pay_type'] as num?)?.toInt(),
      payStatus: (json['pay_status'] as num?)?.toInt(),
      payTime: json['pay_time'] as String?,
      remark: json['remark'] as String?,
      createdAt: json['created_at'] as String?,
    );
Map<String, dynamic> _$$RechargeOrderImplToJson(_$RechargeOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_no': instance.orderNo,
      'member_id': instance.memberId,
      'member_name': instance.memberName,
      'pay_amount': instance.payAmount,
      'gift_amount': instance.giftAmount,
      'pay_type': instance.payType,
      'pay_status': instance.payStatus,
      'pay_time': instance.payTime,
      'remark': instance.remark,
      'created_at': instance.createdAt,
    };
_$CreateMemberReqImpl _$$CreateMemberReqImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateMemberReqImpl(
      uid: json['uid'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String,
      levelId: (json['levelId'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$CreateMemberReqImplToJson(
        _$CreateMemberReqImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phone': instance.phone,
      'levelId': instance.levelId,
    };
_$UpdateMemberReqImpl _$$UpdateMemberReqImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateMemberReqImpl(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      points: (json['points'] as num?)?.toInt(),
      level: (json['level'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$UpdateMemberReqImplToJson(
        _$UpdateMemberReqImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'points': instance.points,
      'level': instance.level,
    };
_$AdjustBalanceReqImpl _$$AdjustBalanceReqImplFromJson(
        Map<String, dynamic> json) =>
    _$AdjustBalanceReqImpl(
      amount: json['amount'] as String,
      type: (json['type'] as num).toInt(),
      remark: json['remark'] as String?,
      version: (json['version'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$AdjustBalanceReqImplToJson(
        _$AdjustBalanceReqImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'type': instance.type,
      'remark': instance.remark,
      'version': instance.version,
    };
_$CreateRechargeOrderReqImpl _$$CreateRechargeOrderReqImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateRechargeOrderReqImpl(
      memberId: (json['memberId'] as num).toInt(),
      payAmount: json['payAmount'] as String,
      giftAmount: json['giftAmount'] as String?,
      payType: (json['payType'] as num).toInt(),
      remark: json['remark'] as String?,
    );
Map<String, dynamic> _$$CreateRechargeOrderReqImplToJson(
        _$CreateRechargeOrderReqImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'payAmount': instance.payAmount,
      'giftAmount': instance.giftAmount,
      'payType': instance.payType,
      'remark': instance.remark,
    };
_$PayRechargeOrderReqImpl _$$PayRechargeOrderReqImplFromJson(
        Map<String, dynamic> json) =>
    _$PayRechargeOrderReqImpl(
      orderNo: json['orderNo'] as String,
    );
Map<String, dynamic> _$$PayRechargeOrderReqImplToJson(
        _$PayRechargeOrderReqImpl instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
    };
_$ListWalletLogReqImpl _$$ListWalletLogReqImplFromJson(
        Map<String, dynamic> json) =>
    _$ListWalletLogReqImpl(
      memberId: (json['memberId'] as num?)?.toInt(),
      changeType: (json['changeType'] as num?)?.toInt(),
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$ListWalletLogReqImplToJson(
        _$ListWalletLogReqImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'changeType': instance.changeType,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
_$ListRechargeOrderReqImpl _$$ListRechargeOrderReqImplFromJson(
        Map<String, dynamic> json) =>
    _$ListRechargeOrderReqImpl(
      memberId: (json['memberId'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$ListRechargeOrderReqImplToJson(
        _$ListRechargeOrderReqImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'status': instance.status,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
_$MemberListRespImpl _$$MemberListRespImplFromJson(Map<String, dynamic> json) =>
    _$MemberListRespImpl(
      list: (json['list'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['page_size'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$MemberListRespImplToJson(
        _$MemberListRespImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'page': instance.page,
      'page_size': instance.pageSize,
    };
_$WalletLogListRespImpl _$$WalletLogListRespImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletLogListRespImpl(
      list: (json['list'] as List<dynamic>)
          .map((e) => WalletLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['page_size'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$WalletLogListRespImplToJson(
        _$WalletLogListRespImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'page': instance.page,
      'page_size': instance.pageSize,
    };
_$RechargeOrderListRespImpl _$$RechargeOrderListRespImplFromJson(
        Map<String, dynamic> json) =>
    _$RechargeOrderListRespImpl(
      list: (json['list'] as List<dynamic>)
          .map((e) => RechargeOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['page_size'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$RechargeOrderListRespImplToJson(
        _$RechargeOrderListRespImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'page': instance.page,
      'page_size': instance.pageSize,
    };
