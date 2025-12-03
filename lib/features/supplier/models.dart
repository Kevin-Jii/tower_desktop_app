import 'package:freezed_annotation/freezed_annotation.dart';
import '../store/models.dart';

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
    @JsonKey(name: 'supplier_id') @Default(0) int supplierId,
    @JsonKey(name: 'category_id') @Default(0) int categoryId,
    @Default('') String name,
    String? unit,
    double? price,
    String? spec,
    int? status,
    String? remark,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    // 关联数据
    Supplier? supplier,
    SupplierCategory? category,
  }) = _SupplierProduct;

  factory SupplierProduct.fromJson(Map<String, dynamic> json) => _$SupplierProductFromJson(json);
}

@freezed
class StoreSupplierProduct with _$StoreSupplierProduct {
  const factory StoreSupplierProduct({
    required int id,
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'supplier_product_id') int? supplierProductId,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    // 关联数据
    SupplierProduct? product,
    @JsonKey(name: 'supplier_product') SupplierProduct? supplierProduct,
    Store? store,
  }) = _StoreSupplierProduct;

  factory StoreSupplierProduct.fromJson(Map<String, dynamic> json) => _$StoreSupplierProductFromJson(json);
}

/// 门店绑定的供应商
@freezed
class StoreSupplier with _$StoreSupplier {
  const factory StoreSupplier({
    required int id,
    @JsonKey(name: 'store_id') required int storeId,
    @JsonKey(name: 'supplier_id') required int supplierId,
    Supplier? supplier,
    int? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _StoreSupplier;

  factory StoreSupplier.fromJson(Map<String, dynamic> json) => _$StoreSupplierFromJson(json);
}

/// 绑定供应商商品请求
class BindSupplierProductRequest {
  final int storeId;
  final int supplierProductId;
  final bool isDefault;

  BindSupplierProductRequest({
    required this.storeId,
    required this.supplierProductId,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() => {
    'store_id': storeId,
    'product_ids': [supplierProductId],
  };
}
