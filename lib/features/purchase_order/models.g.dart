// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseOrderImpl _$$PurchaseOrderImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseOrderImpl(
      id: (json['id'] as num).toInt(),
      orderNo: json['order_no'] as String,
      storeId: (json['store_id'] as num).toInt(),
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      status: (json['status'] as num?)?.toInt() ?? 1,
      orderDate: json['order_date'] as String?,
      remark: json['remark'] as String?,
      createdBy: (json['created_by'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      store: json['store'] == null
          ? null
          : Store.fromJson(json['store'] as Map<String, dynamic>),
      creator: json['creator'] == null
          ? null
          : User.fromJson(json['creator'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => PurchaseOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PurchaseOrderImplToJson(_$PurchaseOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_no': instance.orderNo,
      'store_id': instance.storeId,
      'total_amount': instance.totalAmount,
      'status': instance.status,
      'order_date': instance.orderDate,
      'remark': instance.remark,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'store': instance.store,
      'creator': instance.creator,
      'items': instance.items,
    };

_$PurchaseOrderItemImpl _$$PurchaseOrderItemImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseOrderItemImpl(
      id: (json['id'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      supplierId: (json['supplier_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unit_price'] as num?)?.toDouble() ?? 0.0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      remark: json['remark'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      supplier: json['supplier'] == null
          ? null
          : Supplier.fromJson(json['supplier'] as Map<String, dynamic>),
      product: json['product'] == null
          ? null
          : SupplierProduct.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PurchaseOrderItemImplToJson(
        _$PurchaseOrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'product_id': instance.productId,
      'supplier_id': instance.supplierId,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'amount': instance.amount,
      'remark': instance.remark,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'supplier': instance.supplier,
      'product': instance.product,
    };

_$CreatePurchaseOrderRequestImpl _$$CreatePurchaseOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePurchaseOrderRequestImpl(
      orderDate: json['order_date'] as String,
      remark: json['remark'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => CreatePurchaseOrderItemRequest.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CreatePurchaseOrderRequestImplToJson(
        _$CreatePurchaseOrderRequestImpl instance) =>
    <String, dynamic>{
      'order_date': instance.orderDate,
      'remark': instance.remark,
      'items': instance.items,
    };

_$CreatePurchaseOrderItemRequestImpl
    _$$CreatePurchaseOrderItemRequestImplFromJson(Map<String, dynamic> json) =>
        _$CreatePurchaseOrderItemRequestImpl(
          productId: (json['product_id'] as num).toInt(),
          quantity: (json['quantity'] as num).toDouble(),
          remark: json['remark'] as String?,
        );

Map<String, dynamic> _$$CreatePurchaseOrderItemRequestImplToJson(
        _$CreatePurchaseOrderItemRequestImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'remark': instance.remark,
    };

_$UpdatePurchaseOrderRequestImpl _$$UpdatePurchaseOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePurchaseOrderRequestImpl(
      status: (json['status'] as num?)?.toInt(),
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$$UpdatePurchaseOrderRequestImplToJson(
        _$UpdatePurchaseOrderRequestImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'remark': instance.remark,
    };
