// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SupplierImpl _$$SupplierImplFromJson(Map<String, dynamic> json) =>
    _$SupplierImpl(
      id: (json['id'] as num).toInt(),
      name: json['supplier_name'] as String,
      contactPerson: json['contact_person'] as String?,
      phone: json['contact_phone'] as String?,
      address: json['supplier_address'] as String?,
      status: (json['status'] as num?)?.toInt(),
      remark: json['remark'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$SupplierImplToJson(_$SupplierImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'supplier_name': instance.name,
      'contact_person': instance.contactPerson,
      'contact_phone': instance.phone,
      'supplier_address': instance.address,
      'status': instance.status,
      'remark': instance.remark,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$SupplierCategoryImpl _$$SupplierCategoryImplFromJson(
        Map<String, dynamic> json) =>
    _$SupplierCategoryImpl(
      id: (json['id'] as num).toInt(),
      supplierId: (json['supplier_id'] as num).toInt(),
      name: json['name'] as String,
      sort: (json['sort'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$SupplierCategoryImplToJson(
        _$SupplierCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'supplier_id': instance.supplierId,
      'name': instance.name,
      'sort': instance.sort,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$SupplierProductImpl _$$SupplierProductImplFromJson(
        Map<String, dynamic> json) =>
    _$SupplierProductImpl(
      id: (json['id'] as num).toInt(),
      supplierId: (json['supplier_id'] as num).toInt(),
      categoryId: (json['category_id'] as num).toInt(),
      name: json['name'] as String,
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toInt(),
      remark: json['remark'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      supplier: json['supplier'] == null
          ? null
          : Supplier.fromJson(json['supplier'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : SupplierCategory.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SupplierProductImplToJson(
        _$SupplierProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'supplier_id': instance.supplierId,
      'category_id': instance.categoryId,
      'name': instance.name,
      'unit': instance.unit,
      'price': instance.price,
      'status': instance.status,
      'remark': instance.remark,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'supplier': instance.supplier,
      'category': instance.category,
    };

_$StoreSupplierProductImpl _$$StoreSupplierProductImplFromJson(
        Map<String, dynamic> json) =>
    _$StoreSupplierProductImpl(
      id: (json['id'] as num).toInt(),
      storeId: (json['store_id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      isDefault: json['is_default'] as bool? ?? false,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      product: json['product'] == null
          ? null
          : SupplierProduct.fromJson(json['product'] as Map<String, dynamic>),
      store: json['store'] == null
          ? null
          : Store.fromJson(json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StoreSupplierProductImplToJson(
        _$StoreSupplierProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'product_id': instance.productId,
      'is_default': instance.isDefault,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'product': instance.product,
      'store': instance.store,
    };
