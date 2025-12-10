part of 'models.dart';
_$InventoryImpl _$$InventoryImplFromJson(Map<String, dynamic> json) =>
    _$InventoryImpl(
      id: (json['id'] as num).toInt(),
      storeId: (json['store_id'] as num).toInt(),
      storeName: json['store_name'] as String?,
      productId: (json['product_id'] as num).toInt(),
      productName: json['product_name'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] as String?,
    );
Map<String, dynamic> _$$InventoryImplToJson(_$InventoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'store_name': instance.storeName,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };
_$InventoryRecordImpl _$$InventoryRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryRecordImpl(
      id: (json['id'] as num).toInt(),
      recordNo: json['record_no'] as String?,
      storeId: (json['store_id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String?,
      reason: json['reason'] as String?,
      remark: json['remark'] as String?,
      operatorId: (json['operator_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      store: json['store'] == null
          ? null
          : InventoryStore.fromJson(json['store'] as Map<String, dynamic>),
      product: json['product'] == null
          ? null
          : InventoryProduct.fromJson(json['product'] as Map<String, dynamic>),
      operator: json['operator'] == null
          ? null
          : InventoryOperator.fromJson(
              json['operator'] as Map<String, dynamic>),
    );
Map<String, dynamic> _$$InventoryRecordImplToJson(
        _$InventoryRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'record_no': instance.recordNo,
      'store_id': instance.storeId,
      'product_id': instance.productId,
      'type': instance.type,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'reason': instance.reason,
      'remark': instance.remark,
      'operator_id': instance.operatorId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'store': instance.store,
      'product': instance.product,
      'operator': instance.operator,
    };
_$InventoryStoreImpl _$$InventoryStoreImplFromJson(Map<String, dynamic> json) =>
    _$InventoryStoreImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );
Map<String, dynamic> _$$InventoryStoreImplToJson(
        _$InventoryStoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
_$InventoryProductImpl _$$InventoryProductImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryProductImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );
Map<String, dynamic> _$$InventoryProductImplToJson(
        _$InventoryProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
_$InventoryOperatorImpl _$$InventoryOperatorImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryOperatorImpl(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String?,
    );
Map<String, dynamic> _$$InventoryOperatorImplToJson(
        _$InventoryOperatorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
    };
_$InventoryOrderImpl _$$InventoryOrderImplFromJson(Map<String, dynamic> json) =>
    _$InventoryOrderImpl(
      id: (json['id'] as num).toInt(),
      orderNo: json['order_no'] as String?,
      storeId: (json['store_id'] as num?)?.toInt(),
      storeName: json['store_name'] as String?,
      type: (json['type'] as num).toInt(),
      reason: json['reason'] as String?,
      remark: json['remark'] as String?,
      totalQuantity: (json['total_quantity'] as num?)?.toDouble(),
      itemCount: (json['item_count'] as num?)?.toInt(),
      operatorId: (json['operator_id'] as num?)?.toInt(),
      operatorName: json['operator_name'] as String?,
      operatorPhone: json['operator_phone'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      store: json['store'] == null
          ? null
          : InventoryStore.fromJson(json['store'] as Map<String, dynamic>),
      operator: json['operator'] == null
          ? null
          : InventoryOperator.fromJson(
              json['operator'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
              ?.map(
                  (e) => InventoryOrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
Map<String, dynamic> _$$InventoryOrderImplToJson(
        _$InventoryOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_no': instance.orderNo,
      'store_id': instance.storeId,
      'store_name': instance.storeName,
      'type': instance.type,
      'reason': instance.reason,
      'remark': instance.remark,
      'total_quantity': instance.totalQuantity,
      'item_count': instance.itemCount,
      'operator_id': instance.operatorId,
      'operator_name': instance.operatorName,
      'operator_phone': instance.operatorPhone,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'store': instance.store,
      'operator': instance.operator,
      'items': instance.items,
    };
_$InventoryOrderItemImpl _$$InventoryOrderItemImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryOrderItemImpl(
      id: (json['id'] as num).toInt(),
      orderId: (json['order_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num).toInt(),
      productName: json['product_name'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String?,
      productionDate: json['production_date'] as String?,
      expiryDate: json['expiry_date'] as String?,
      remark: json['remark'] as String?,
      product: json['product'] == null
          ? null
          : InventoryProduct.fromJson(json['product'] as Map<String, dynamic>),
    );
Map<String, dynamic> _$$InventoryOrderItemImplToJson(
        _$InventoryOrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'production_date': instance.productionDate,
      'expiry_date': instance.expiryDate,
      'remark': instance.remark,
      'product': instance.product,
    };
_$CreateInventoryOrderRequestImpl _$$CreateInventoryOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateInventoryOrderRequestImpl(
      type: (json['type'] as num).toInt(),
      reason: json['reason'] as String,
      remark: json['remark'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              CreateInventoryOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
Map<String, dynamic> _$$CreateInventoryOrderRequestImplToJson(
        _$CreateInventoryOrderRequestImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'reason': instance.reason,
      'remark': instance.remark,
      'items': instance.items,
    };
_$CreateInventoryOrderItemImpl _$$CreateInventoryOrderItemImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateInventoryOrderItemImpl(
      productId: (json['product_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toDouble(),
      productionDate: json['production_date'] as String?,
      expiryDate: json['expiry_date'] as String?,
      remark: json['remark'] as String?,
    );
Map<String, dynamic> _$$CreateInventoryOrderItemImplToJson(
        _$CreateInventoryOrderItemImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'production_date': instance.productionDate,
      'expiry_date': instance.expiryDate,
      'remark': instance.remark,
    };
_$CreateInventoryRecordRequestImpl _$$CreateInventoryRecordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateInventoryRecordRequestImpl(
      productId: (json['product_id'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      quantity: (json['quantity'] as num).toDouble(),
      reason: json['reason'] as String,
      remark: json['remark'] as String?,
      productionDate: json['production_date'] as String?,
      expiryDate: json['expiry_date'] as String?,
    );
Map<String, dynamic> _$$CreateInventoryRecordRequestImplToJson(
        _$CreateInventoryRecordRequestImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'type': instance.type,
      'quantity': instance.quantity,
      'reason': instance.reason,
      'remark': instance.remark,
      'production_date': instance.productionDate,
      'expiry_date': instance.expiryDate,
    };
_$UpdateInventoryRequestImpl _$$UpdateInventoryRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateInventoryRequestImpl(
      quantity: (json['quantity'] as num).toDouble(),
      remark: json['remark'] as String?,
    );
Map<String, dynamic> _$$UpdateInventoryRequestImplToJson(
        _$UpdateInventoryRequestImpl instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'remark': instance.remark,
    };
