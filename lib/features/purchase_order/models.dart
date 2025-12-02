import 'package:freezed_annotation/freezed_annotation.dart';
import '../supplier/models.dart';
import '../store/models.dart';
import '../user/models.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// 采购订单状态枚举
/// 1=待确认, 2=已确认, 3=已完成, 4=已取消
class PurchaseOrderStatus {
  static const int pending = 1;    // 待确认
  static const int confirmed = 2;  // 已确认
  static const int completed = 3;  // 已完成
  static const int cancelled = 4;  // 已取消

  static String getLabel(int status) {
    switch (status) {
      case pending: return '待确认';
      case confirmed: return '已确认';
      case completed: return '已完成';
      case cancelled: return '已取消';
      default: return '未知';
    }
  }
}

@freezed
class PurchaseOrder with _$PurchaseOrder {
  const factory PurchaseOrder({
    required int id,
    @JsonKey(name: 'order_no') required String orderNo,
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'total_amount') @Default(0.0) double totalAmount,
    @Default(1) int status, // 1=待确认, 2=已确认, 3=已完成, 4=已取消
    @JsonKey(name: 'order_date') String? orderDate,
    String? remark,
    @JsonKey(name: 'created_by') int? createdBy,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    // 关联数据
    Store? store,
    User? creator,
    List<PurchaseOrderItem>? items,
  }) = _PurchaseOrder;

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => _$PurchaseOrderFromJson(json);
}

@freezed
class PurchaseOrderItem with _$PurchaseOrderItem {
  const factory PurchaseOrderItem({
    required int id,
    @JsonKey(name: 'order_id') required int orderId,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'supplier_id') int? supplierId,
    required double quantity,
    @JsonKey(name: 'unit_price') @Default(0.0) double unitPrice,
    @Default(0.0) double amount,
    String? remark,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    // 关联数据
    Supplier? supplier,
    SupplierProduct? product,
  }) = _PurchaseOrderItem;

  factory PurchaseOrderItem.fromJson(Map<String, dynamic> json) => _$PurchaseOrderItemFromJson(json);
}

@freezed
class CreatePurchaseOrderRequest with _$CreatePurchaseOrderRequest {
  const factory CreatePurchaseOrderRequest({
    @JsonKey(name: 'order_date') required String orderDate,
    String? remark,
    required List<CreatePurchaseOrderItemRequest> items,
  }) = _CreatePurchaseOrderRequest;

  factory CreatePurchaseOrderRequest.fromJson(Map<String, dynamic> json) => _$CreatePurchaseOrderRequestFromJson(json);
}

@freezed
class CreatePurchaseOrderItemRequest with _$CreatePurchaseOrderItemRequest {
  const factory CreatePurchaseOrderItemRequest({
    @JsonKey(name: 'product_id') required int productId,
    required double quantity,
    String? remark,
  }) = _CreatePurchaseOrderItemRequest;

  factory CreatePurchaseOrderItemRequest.fromJson(Map<String, dynamic> json) => _$CreatePurchaseOrderItemRequestFromJson(json);
}

@freezed
class UpdatePurchaseOrderRequest with _$UpdatePurchaseOrderRequest {
  const factory UpdatePurchaseOrderRequest({
    int? status,
    String? remark,
  }) = _UpdatePurchaseOrderRequest;

  factory UpdatePurchaseOrderRequest.fromJson(Map<String, dynamic> json) => _$UpdatePurchaseOrderRequestFromJson(json);
}
