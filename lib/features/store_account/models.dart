import 'package:freezed_annotation/freezed_annotation.dart';
part 'models.freezed.dart';
part 'models.g.dart';
@freezed
class StoreAccount with _$StoreAccount {
  const StoreAccount._();
  const factory StoreAccount({
    required int id,
    @JsonKey(name: 'account_no') String? accountNo,
    @JsonKey(name: 'store_id') int? storeId,
    String? channel,
    @JsonKey(name: 'order_no') String? orderNo,
    @JsonKey(name: 'total_amount') @Default(0.0) double totalAmount,
    @JsonKey(name: 'item_count') @Default(0) int itemCount,
    @JsonKey(name: 'tag_code') String? tagCode,
    @JsonKey(name: 'tag_name') String? tagName,
    String? remark,
    @JsonKey(name: 'operator_id') int? operatorId,
    @JsonKey(name: 'account_date') String? accountDate,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @Default([]) List<StoreAccountItem> items,
    StoreAccountStore? store,
    @JsonKey(name: 'operator') StoreAccountOperator? accountOperator,
  }) = _StoreAccount;
  factory StoreAccount.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountFromJson(json);
  String? get storeName => store?.name;
  String? get operatorName => accountOperator?.nickname ?? accountOperator?.username;
}
@freezed
class StoreAccountItem with _$StoreAccountItem {
  const factory StoreAccountItem({
    required int id,
    @JsonKey(name: 'account_id') int? accountId,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'product_name') String? productName,
    String? spec,
    @Default(1.0) double quantity,
    String? unit,
    @Default(0.0) double price,
    @Default(0.0) double amount,
    String? remark,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _StoreAccountItem;
  factory StoreAccountItem.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountItemFromJson(json);
}
@freezed
class StoreAccountStore with _$StoreAccountStore {
  const factory StoreAccountStore({
    required int id,
    String? name,
  }) = _StoreAccountStore;
  factory StoreAccountStore.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountStoreFromJson(json);
}
@freezed
class StoreAccountOperator with _$StoreAccountOperator {
  const factory StoreAccountOperator({
    required int id,
    String? username,
    String? nickname,
  }) = _StoreAccountOperator;
  factory StoreAccountOperator.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountOperatorFromJson(json);
}
@freezed
class StoreAccountStats with _$StoreAccountStats {
  const factory StoreAccountStats({
    @JsonKey(name: 'total_count') @Default(0) int totalCount,
    @JsonKey(name: 'total_quantity') @Default(0.0) double totalQuantity,
    @JsonKey(name: 'total_amount') @Default(0.0) double totalAmount,
    @JsonKey(name: 'today_count') @Default(0) int todayCount,
    @JsonKey(name: 'today_amount') @Default(0.0) double todayAmount,
    @JsonKey(name: 'month_amount') @Default(0.0) double monthAmount,
  }) = _StoreAccountStats;
  factory StoreAccountStats.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountStatsFromJson(json);
}
@freezed
class CreateStoreAccountRequest with _$CreateStoreAccountRequest {
  const factory CreateStoreAccountRequest({
    required String channel,
    @JsonKey(name: 'order_no') String? orderNo,
    @JsonKey(name: 'account_date') required String accountDate,
    required List<CreateStoreAccountItem> items,
  }) = _CreateStoreAccountRequest;
  factory CreateStoreAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateStoreAccountRequestFromJson(json);
}
@freezed
class CreateStoreAccountItem with _$CreateStoreAccountItem {
  const factory CreateStoreAccountItem({
    @JsonKey(name: 'product_id') required int productId,
    String? spec,
    required double quantity,
    String? unit,
    @Default(0.0) double price,
    @Default(0.0) double amount,
  }) = _CreateStoreAccountItem;
  factory CreateStoreAccountItem.fromJson(Map<String, dynamic> json) =>
      _$CreateStoreAccountItemFromJson(json);
}
@freezed
class UpdateStoreAccountRequest with _$UpdateStoreAccountRequest {
  const factory UpdateStoreAccountRequest({
    String? channel,
    @JsonKey(name: 'order_no') String? orderNo,
    String? remark,
    @JsonKey(name: 'account_date') String? accountDate,
  }) = _UpdateStoreAccountRequest;
  factory UpdateStoreAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateStoreAccountRequestFromJson(json);
}
