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
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: (json['status'] as num).toInt(),
      reportDate: json['report_date'] as String,
      createdBy: (json['created_by'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      store: json['store'] == null
          ? null
          : Store.fromJson(json['store'] as Map<String, dynamic>),
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
      'report_date': instance.reportDate,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'store': instance.store,
      'items': instance.items,
    };

_$PurchaseOrderItemImpl _$$PurchaseOrderItemImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseOrderItemImpl(
      id: (json['id'] as num).toInt(),
      purchaseOrderId: (json['purchase_order_id'] as num).toInt(),
      supplierId: (json['supplier_id'] as num).toInt(),
      supplierProductId: (json['supplier_product_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      supplier: json['supplier'] == null
          ? null
          : Supplier.fromJson(json['supplier'] as Map<String, dynamic>),
      supplierProduct: json['supplier_product'] == null
          ? null
          : SupplierProduct.fromJson(
              json['supplier_product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PurchaseOrderItemImplToJson(
        _$PurchaseOrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purchase_order_id': instance.purchaseOrderId,
      'supplier_id': instance.supplierId,
      'supplier_product_id': instance.supplierProductId,
      'quantity': instance.quantity,
      'price': instance.price,
      'amount': instance.amount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'supplier': instance.supplier,
      'supplier_product': instance.supplierProduct,
    };

_$CreatePurchaseOrderRequestImpl _$$CreatePurchaseOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePurchaseOrderRequestImpl(
      storeId: (json['store_id'] as num).toInt(),
      reportDate: json['report_date'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CreatePurchaseOrderItemRequest.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CreatePurchaseOrderRequestImplToJson(
        _$CreatePurchaseOrderRequestImpl instance) =>
    <String, dynamic>{
      'store_id': instance.storeId,
      'report_date': instance.reportDate,
      'items': instance.items,
    };

_$CreatePurchaseOrderItemRequestImpl
    _$$CreatePurchaseOrderItemRequestImplFromJson(Map<String, dynamic> json) =>
        _$CreatePurchaseOrderItemRequestImpl(
          supplierProductId: (json['supplier_product_id'] as num).toInt(),
          quantity: (json['quantity'] as num).toDouble(),
        );

Map<String, dynamic> _$$CreatePurchaseOrderItemRequestImplToJson(
        _$CreatePurchaseOrderItemRequestImpl instance) =>
    <String, dynamic>{
      'supplier_product_id': instance.supplierProductId,
      'quantity': instance.quantity,
    };
