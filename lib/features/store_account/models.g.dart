part of 'models.dart';
_$StoreAccountImpl _$$StoreAccountImplFromJson(Map<String, dynamic> json) =>
    _$StoreAccountImpl(
      id: (json['id'] as num).toInt(),
      accountNo: json['account_no'] as String?,
      storeId: (json['store_id'] as num?)?.toInt(),
      channel: json['channel'] as String?,
      orderNo: json['order_no'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      itemCount: (json['item_count'] as num?)?.toInt() ?? 0,
      tagCode: json['tag_code'] as String?,
      tagName: json['tag_name'] as String?,
      remark: json['remark'] as String?,
      operatorId: (json['operator_id'] as num?)?.toInt(),
      accountDate: json['account_date'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => StoreAccountItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      store: json['store'] == null
          ? null
          : StoreAccountStore.fromJson(json['store'] as Map<String, dynamic>),
      operator: json['operator'] == null
          ? null
          : StoreAccountOperator.fromJson(
              json['operator'] as Map<String, dynamic>),
    );
Map<String, dynamic> _$$StoreAccountImplToJson(_$StoreAccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_no': instance.accountNo,
      'store_id': instance.storeId,
      'channel': instance.channel,
      'order_no': instance.orderNo,
      'total_amount': instance.totalAmount,
      'item_count': instance.itemCount,
      'tag_code': instance.tagCode,
      'tag_name': instance.tagName,
      'remark': instance.remark,
      'operator_id': instance.operatorId,
      'account_date': instance.accountDate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'items': instance.items,
      'store': instance.store,
      'operator': instance.operator,
    };
_$StoreAccountItemImpl _$$StoreAccountItemImplFromJson(
        Map<String, dynamic> json) =>
    _$StoreAccountItemImpl(
      id: (json['id'] as num).toInt(),
      accountId: (json['account_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num).toInt(),
      productName: json['product_name'] as String?,
      spec: json['spec'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 1.0,
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      remark: json['remark'] as String?,
      createdAt: json['created_at'] as String?,
    );
Map<String, dynamic> _$$StoreAccountItemImplToJson(
        _$StoreAccountItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'spec': instance.spec,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'price': instance.price,
      'amount': instance.amount,
      'remark': instance.remark,
      'created_at': instance.createdAt,
    };
_$StoreAccountStoreImpl _$$StoreAccountStoreImplFromJson(
        Map<String, dynamic> json) =>
    _$StoreAccountStoreImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
    );
Map<String, dynamic> _$$StoreAccountStoreImplToJson(
        _$StoreAccountStoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
_$StoreAccountOperatorImpl _$$StoreAccountOperatorImplFromJson(
        Map<String, dynamic> json) =>
    _$StoreAccountOperatorImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String?,
      nickname: json['nickname'] as String?,
    );
Map<String, dynamic> _$$StoreAccountOperatorImplToJson(
        _$StoreAccountOperatorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
    };
_$StoreAccountStatsImpl _$$StoreAccountStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$StoreAccountStatsImpl(
      totalCount: (json['total_count'] as num?)?.toInt() ?? 0,
      totalQuantity: (json['total_quantity'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      todayCount: (json['today_count'] as num?)?.toInt() ?? 0,
      todayAmount: (json['today_amount'] as num?)?.toDouble() ?? 0.0,
      monthAmount: (json['month_amount'] as num?)?.toDouble() ?? 0.0,
    );
Map<String, dynamic> _$$StoreAccountStatsImplToJson(
        _$StoreAccountStatsImpl instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'total_quantity': instance.totalQuantity,
      'total_amount': instance.totalAmount,
      'today_count': instance.todayCount,
      'today_amount': instance.todayAmount,
      'month_amount': instance.monthAmount,
    };
_$CreateStoreAccountRequestImpl _$$CreateStoreAccountRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateStoreAccountRequestImpl(
      channel: json['channel'] as String,
      orderNo: json['order_no'] as String?,
      accountDate: json['account_date'] as String,
      items: (json['items'] as List<dynamic>)
          .map(
              (e) => CreateStoreAccountItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
Map<String, dynamic> _$$CreateStoreAccountRequestImplToJson(
        _$CreateStoreAccountRequestImpl instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'order_no': instance.orderNo,
      'account_date': instance.accountDate,
      'items': instance.items,
    };
_$CreateStoreAccountItemImpl _$$CreateStoreAccountItemImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateStoreAccountItemImpl(
      productId: (json['product_id'] as num).toInt(),
      spec: json['spec'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
Map<String, dynamic> _$$CreateStoreAccountItemImplToJson(
        _$CreateStoreAccountItemImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'spec': instance.spec,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'price': instance.price,
      'amount': instance.amount,
    };
_$UpdateStoreAccountRequestImpl _$$UpdateStoreAccountRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateStoreAccountRequestImpl(
      channel: json['channel'] as String?,
      orderNo: json['order_no'] as String?,
      remark: json['remark'] as String?,
      accountDate: json['account_date'] as String?,
    );
Map<String, dynamic> _$$UpdateStoreAccountRequestImplToJson(
        _$UpdateStoreAccountRequestImpl instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'order_no': instance.orderNo,
      'remark': instance.remark,
      'account_date': instance.accountDate,
    };
