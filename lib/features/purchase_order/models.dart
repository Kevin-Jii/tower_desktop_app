import 'package:freezed_annotation/freezed_annotation.dart';
import '../supplier/models.dart';
import '../store/models.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class PurchaseOrder with _$PurchaseOrder {
  const factory PurchaseOrder({
    required int id,
    @JsonKey(name: 'order_no') required String orderNo,
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'total_amount') required double totalAmount,
    required int status, // 0=待确认, 1=已确认, 2=已完成, 3=已取消
    @JsonKey(name: 'report_date') required String reportDate,
    @JsonKey(name: 'created_by') int? createdBy,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    // 关联数据
    @JsonKey(name: 'store') Store? store,
    @JsonKey(name: 'items') List<PurchaseOrderItem>? items,
  }) = _PurchaseOrder;

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => _$PurchaseOrderFromJson(json);
}

@freezed
class PurchaseOrderItem with _$PurchaseOrderItem {
  const factory PurchaseOrderItem({
    required int id,
    @JsonKey(name: 'purchase_order_id') required int purchaseOrderId,
    @JsonKey(name: 'supplier_id') required int supplierId,
    @JsonKey(name: 'supplier_product_id') required int supplierProductId,
    required double quantity,
    required double price,
    required double amount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    // 关联数据
    @JsonKey(name: 'supplier') Supplier? supplier,
    @JsonKey(name: 'supplier_product') SupplierProduct? supplierProduct,
  }) = _PurchaseOrderItem;

  factory PurchaseOrderItem.fromJson(Map<String, dynamic> json) => _$PurchaseOrderItemFromJson(json);
}

@freezed
class CreatePurchaseOrderRequest with _$CreatePurchaseOrderRequest {
  const factory CreatePurchaseOrderRequest({
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'report_date') required String reportDate,
    required List<CreatePurchaseOrderItemRequest> items,
  }) = _CreatePurchaseOrderRequest;

  factory CreatePurchaseOrderRequest.fromJson(Map<String, dynamic> json) => _$CreatePurchaseOrderRequestFromJson(json);
}

@freezed
class CreatePurchaseOrderItemRequest with _$CreatePurchaseOrderItemRequest {
  const factory CreatePurchaseOrderItemRequest({
    @JsonKey(name: 'supplier_product_id') required int supplierProductId,
    required double quantity,
  }) = _CreatePurchaseOrderItemRequest;

  factory CreatePurchaseOrderItemRequest.fromJson(Map<String, dynamic> json) => _$CreatePurchaseOrderItemRequestFromJson(json);
}
