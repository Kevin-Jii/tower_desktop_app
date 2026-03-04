part of 'models.dart';
_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      levelId: (json['level_id'] as num?)?.toInt(),
      levelName: json['level_name'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      totalRecharge: (json['total_recharge'] as num?)?.toDouble(),
      totalConsume: (json['total_consume'] as num?)?.toDouble(),
      points: (json['points'] as num?)?.toInt(),
      remark: json['remark'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'level_id': instance.levelId,
      'level_name': instance.levelName,
      'balance': instance.balance,
      'total_recharge': instance.totalRecharge,
      'total_consume': instance.totalConsume,
      'points': instance.points,
      'remark': instance.remark,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
_$CreateMemberRequestImpl _$$CreateMemberRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateMemberRequestImpl(
      name: json['name'] as String,
      phone: json['phone'] as String,
      levelId: (json['level_id'] as num?)?.toInt(),
      remark: json['remark'] as String?,
    );
Map<String, dynamic> _$$CreateMemberRequestImplToJson(
        _$CreateMemberRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'level_id': instance.levelId,
      'remark': instance.remark,
    };
_$UpdateMemberRequestImpl _$$UpdateMemberRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateMemberRequestImpl(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      levelId: (json['level_id'] as num?)?.toInt(),
      remark: json['remark'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$UpdateMemberRequestImplToJson(
        _$UpdateMemberRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'level_id': instance.levelId,
      'remark': instance.remark,
      'status': instance.status,
    };
_$AdjustBalanceRequestImpl _$$AdjustBalanceRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AdjustBalanceRequestImpl(
      amount: (json['amount'] as num).toDouble(),
      type: (json['type'] as num).toInt(),
      remark: json['remark'] as String?,
    );
Map<String, dynamic> _$$AdjustBalanceRequestImplToJson(
        _$AdjustBalanceRequestImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'type': instance.type,
      'remark': instance.remark,
    };
_$WalletLogImpl _$$WalletLogImplFromJson(Map<String, dynamic> json) =>
    _$WalletLogImpl(
      id: (json['id'] as num).toInt(),
      memberId: (json['member_id'] as num?)?.toInt(),
      memberName: json['member_name'] as String?,
      memberPhone: json['member_phone'] as String?,
      type: (json['type'] as num?)?.toInt(),
      typeName: json['type_name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      balanceBefore: (json['balance_before'] as num?)?.toDouble(),
      balanceAfter: (json['balance_after'] as num?)?.toDouble(),
      remark: json['remark'] as String?,
      orderNo: json['order_no'] as String?,
      createdAt: json['created_at'] as String?,
    );
Map<String, dynamic> _$$WalletLogImplToJson(_$WalletLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'member_name': instance.memberName,
      'member_phone': instance.memberPhone,
      'type': instance.type,
      'type_name': instance.typeName,
      'amount': instance.amount,
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
      memberPhone: json['member_phone'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      payAmount: (json['pay_amount'] as num?)?.toDouble(),
      giftAmount: (json['gift_amount'] as num?)?.toDouble(),
      payType: (json['pay_type'] as num?)?.toInt(),
      payTypeName: json['pay_type_name'] as String?,
      payStatus: (json['pay_status'] as num?)?.toInt(),
      statusName: json['status_name'] as String?,
      remark: json['remark'] as String?,
      payTime: json['pay_time'] as String?,
      createdAt: json['created_at'] as String?,
    );
Map<String, dynamic> _$$RechargeOrderImplToJson(_$RechargeOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_no': instance.orderNo,
      'member_id': instance.memberId,
      'member_name': instance.memberName,
      'member_phone': instance.memberPhone,
      'total_amount': instance.totalAmount,
      'amount': instance.amount,
      'pay_amount': instance.payAmount,
      'gift_amount': instance.giftAmount,
      'pay_type': instance.payType,
      'pay_type_name': instance.payTypeName,
      'pay_status': instance.payStatus,
      'status_name': instance.statusName,
      'remark': instance.remark,
      'pay_time': instance.payTime,
      'created_at': instance.createdAt,
    };
_$CreateRechargeOrderRequestImpl _$$CreateRechargeOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateRechargeOrderRequestImpl(
      memberId: (json['member_id'] as num).toInt(),
      payAmount: (json['pay_amount'] as num).toDouble(),
      giftAmount: (json['gift_amount'] as num?)?.toDouble(),
      payType: (json['pay_type'] as num).toInt(),
      remark: json['remark'] as String?,
    );
Map<String, dynamic> _$$CreateRechargeOrderRequestImplToJson(
        _$CreateRechargeOrderRequestImpl instance) =>
    <String, dynamic>{
      'member_id': instance.memberId,
      'pay_amount': instance.payAmount,
      'gift_amount': instance.giftAmount,
      'pay_type': instance.payType,
      'remark': instance.remark,
    };
_$PayRechargeOrderRequestImpl _$$PayRechargeOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PayRechargeOrderRequestImpl(
      payType: (json['pay_type'] as num).toInt(),
      transactionNo: json['transaction_no'] as String?,
    );
Map<String, dynamic> _$$PayRechargeOrderRequestImplToJson(
        _$PayRechargeOrderRequestImpl instance) =>
    <String, dynamic>{
      'pay_type': instance.payType,
      'transaction_no': instance.transactionNo,
    };
_$MemberLevelImpl _$$MemberLevelImplFromJson(Map<String, dynamic> json) =>
    _$MemberLevelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      discount: (json['discount'] as num?)?.toInt(),
      minAmount: (json['min_amount'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
    );
Map<String, dynamic> _$$MemberLevelImplToJson(_$MemberLevelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'discount': instance.discount,
      'min_amount': instance.minAmount,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
