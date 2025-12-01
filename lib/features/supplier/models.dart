import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class Supplier with _$Supplier {
  const factory Supplier({
    required int id,
    @JsonKey(name: 'supplier_name') required String name,
    @JsonKey(name: 'contact_person') String? contactPerson,
    @JsonKey(name: 'contact_phone') String? phone,
    @JsonKey(name: 'supplier_address') String? address,
    int? status, // 0=禁用 1=启用
    String? remark,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);
}

@freezed
class SupplierCategory with _$SupplierCategory {
  const factory SupplierCategory({
    required int id,
    @JsonKey(name: 'supplier_id') required int supplierId,
    required String name,
    int? sort,
    int? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _SupplierCategory;

  factory SupplierCategory.fromJson(Map<String, dynamic> json) => _$SupplierCategoryFromJson(json);
}

@freezed
class SupplierProduct with _$SupplierProduct {
  const factory SupplierProduct({
    required int id,
    @JsonKey(name: 'supplier_id') required int supplierId,
    @JsonKey(name: 'category_id') required int categoryId,
    required String name,
    String? unit,
    double? price,
    int? status,
    String? remark,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    // 关联数据
    @JsonKey(name: 'supplier') Supplier? supplier,
    @JsonKey(name: 'category') SupplierCategory? category,
  }) = _SupplierProduct;

  factory SupplierProduct.fromJson(Map<String, dynamic> json) => _$SupplierProductFromJson(json);
}

@freezed
class StoreSupplierProduct with _$StoreSupplierProduct {
  const factory StoreSupplierProduct({
    required int id,
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'supplier_product_id') required int supplierProductId,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    // 关联数据
    @JsonKey(name: 'supplier_product') SupplierProduct? supplierProduct,
  }) = _StoreSupplierProduct;

  factory StoreSupplierProduct.fromJson(Map<String, dynamic> json) => _$StoreSupplierProductFromJson(json);
}

@freezed
class BindSupplierProductRequest with _$BindSupplierProductRequest {
  const factory BindSupplierProductRequest({
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'supplier_product_id') required int supplierProductId,
    @JsonKey(name: 'is_default') bool? isDefault,
  }) = _BindSupplierProductRequest;

  factory BindSupplierProductRequest.fromJson(Map<String, dynamic> json) => _$BindSupplierProductRequestFromJson(json);
}
