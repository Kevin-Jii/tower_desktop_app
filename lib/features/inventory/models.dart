import 'package:freezed_annotation/freezed_annotation.dart';
part 'models.freezed.dart';
part 'models.g.dart';
class InventoryRecordType {
  static const int stockIn = 1;   
  static const int stockOut = 2;  
  static String getLabel(int type) {
    switch (type) {
      case stockIn: return '入库';
      case stockOut: return '出库';
      default: return '未知';
    }
  }
}
@freezed
class Inventory with _$Inventory {
  const factory Inventory({
    required int id,
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'store_name') String? storeName,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'product_name') String? productName,
    @Default(0.0) double quantity,
    String? unit,
  }) = _Inventory;
  factory Inventory.fromJson(Map<String, dynamic> json) => _$InventoryFromJson(json);
}
@freezed
class InventoryRecord with _$InventoryRecord {
  const factory InventoryRecord({
    required int id,
    @JsonKey(name: 'record_no') String? recordNo,
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'product_id') required int productId,
    required int type, 
    required double quantity,
    String? unit,
    String? reason,
    String? remark,
    @JsonKey(name: 'operator_id') int? operatorId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    InventoryStore? store,
    InventoryProduct? product,
    InventoryOperator? operator,
  }) = _InventoryRecord;
  factory InventoryRecord.fromJson(Map<String, dynamic> json) => _$InventoryRecordFromJson(json);
}
@freezed
class InventoryStore with _$InventoryStore {
  const factory InventoryStore({
    required int id,
    required String name,
  }) = _InventoryStore;
  factory InventoryStore.fromJson(Map<String, dynamic> json) => _$InventoryStoreFromJson(json);
}
@freezed
class InventoryProduct with _$InventoryProduct {
  const factory InventoryProduct({
    required int id,
    required String name,
  }) = _InventoryProduct;
  factory InventoryProduct.fromJson(Map<String, dynamic> json) => _$InventoryProductFromJson(json);
}
@freezed
class InventoryOperator with _$InventoryOperator {
  const factory InventoryOperator({
    required int id,
    String? nickname,
  }) = _InventoryOperator;
  factory InventoryOperator.fromJson(Map<String, dynamic> json) => _$InventoryOperatorFromJson(json);
}
@freezed
class InventoryOrder with _$InventoryOrder {
  const factory InventoryOrder({
    required int id,
    @JsonKey(name: 'order_no') String? orderNo,
    @JsonKey(name: 'store_id') int? storeId,
    @JsonKey(name: 'store_name') String? storeName,
    required int type, 
    String? reason,
    String? remark,
    @JsonKey(name: 'total_quantity') double? totalQuantity,
    @JsonKey(name: 'item_count') int? itemCount,
    @JsonKey(name: 'operator_id') int? operatorId,
    @JsonKey(name: 'operator_name') String? operatorName,
    @JsonKey(name: 'operator_phone') String? operatorPhone,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    InventoryStore? store,
    InventoryOperator? operator,
    @Default([]) List<InventoryOrderItem> items,
  }) = _InventoryOrder;
  factory InventoryOrder.fromJson(Map<String, dynamic> json) => _$InventoryOrderFromJson(json);
}
@freezed
class InventoryOrderItem with _$InventoryOrderItem {
  const factory InventoryOrderItem({
    required int id,
    @JsonKey(name: 'order_id') int? orderId,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'product_name') String? productName,
    required double quantity,
    String? unit,
    @JsonKey(name: 'production_date') String? productionDate,
    @JsonKey(name: 'expiry_date') String? expiryDate,
    String? remark,
    InventoryProduct? product,
  }) = _InventoryOrderItem;
  factory InventoryOrderItem.fromJson(Map<String, dynamic> json) => _$InventoryOrderItemFromJson(json);
}
@freezed
class CreateInventoryOrderRequest with _$CreateInventoryOrderRequest {
  const factory CreateInventoryOrderRequest({
    required int type, 
    required String reason,
    String? remark,
    required List<CreateInventoryOrderItem> items,
  }) = _CreateInventoryOrderRequest;
  factory CreateInventoryOrderRequest.fromJson(Map<String, dynamic> json) => _$CreateInventoryOrderRequestFromJson(json);
}
@freezed
class CreateInventoryOrderItem with _$CreateInventoryOrderItem {
  const factory CreateInventoryOrderItem({
    @JsonKey(name: 'product_id') required int productId,
    required double quantity,
    @JsonKey(name: 'production_date') String? productionDate,
    @JsonKey(name: 'expiry_date') String? expiryDate,
    String? remark,
  }) = _CreateInventoryOrderItem;
  factory CreateInventoryOrderItem.fromJson(Map<String, dynamic> json) => _$CreateInventoryOrderItemFromJson(json);
}
@freezed
class CreateInventoryRecordRequest with _$CreateInventoryRecordRequest {
  const factory CreateInventoryRecordRequest({
    @JsonKey(name: 'product_id') required int productId,
    required int type, 
    required double quantity,
    required String reason,
    String? remark,
    @JsonKey(name: 'production_date') String? productionDate,
    @JsonKey(name: 'expiry_date') String? expiryDate,
  }) = _CreateInventoryRecordRequest;
  factory CreateInventoryRecordRequest.fromJson(Map<String, dynamic> json) => _$CreateInventoryRecordRequestFromJson(json);
}
