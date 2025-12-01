// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Supplier _$SupplierFromJson(Map<String, dynamic> json) {
  return _Supplier.fromJson(json);
}

/// @nodoc
mixin _$Supplier {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_person')
  String? get contactPerson => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_phone')
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_address')
  String? get address => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError; // 0=禁用 1=启用
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Supplier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierCopyWith<Supplier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierCopyWith<$Res> {
  factory $SupplierCopyWith(Supplier value, $Res Function(Supplier) then) =
      _$SupplierCopyWithImpl<$Res, Supplier>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'supplier_name') String name,
      @JsonKey(name: 'contact_person') String? contactPerson,
      @JsonKey(name: 'contact_phone') String? phone,
      @JsonKey(name: 'supplier_address') String? address,
      int? status,
      String? remark,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$SupplierCopyWithImpl<$Res, $Val extends Supplier>
    implements $SupplierCopyWith<$Res> {
  _$SupplierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contactPerson = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? status = freezed,
    Object? remark = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contactPerson: freezed == contactPerson
          ? _value.contactPerson
          : contactPerson // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupplierImplCopyWith<$Res>
    implements $SupplierCopyWith<$Res> {
  factory _$$SupplierImplCopyWith(
          _$SupplierImpl value, $Res Function(_$SupplierImpl) then) =
      __$$SupplierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'supplier_name') String name,
      @JsonKey(name: 'contact_person') String? contactPerson,
      @JsonKey(name: 'contact_phone') String? phone,
      @JsonKey(name: 'supplier_address') String? address,
      int? status,
      String? remark,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$SupplierImplCopyWithImpl<$Res>
    extends _$SupplierCopyWithImpl<$Res, _$SupplierImpl>
    implements _$$SupplierImplCopyWith<$Res> {
  __$$SupplierImplCopyWithImpl(
      _$SupplierImpl _value, $Res Function(_$SupplierImpl) _then)
      : super(_value, _then);

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contactPerson = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? status = freezed,
    Object? remark = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SupplierImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contactPerson: freezed == contactPerson
          ? _value.contactPerson
          : contactPerson // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierImpl implements _Supplier {
  const _$SupplierImpl(
      {required this.id,
      @JsonKey(name: 'supplier_name') required this.name,
      @JsonKey(name: 'contact_person') this.contactPerson,
      @JsonKey(name: 'contact_phone') this.phone,
      @JsonKey(name: 'supplier_address') this.address,
      this.status,
      this.remark,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$SupplierImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'supplier_name')
  final String name;
  @override
  @JsonKey(name: 'contact_person')
  final String? contactPerson;
  @override
  @JsonKey(name: 'contact_phone')
  final String? phone;
  @override
  @JsonKey(name: 'supplier_address')
  final String? address;
  @override
  final int? status;
// 0=禁用 1=启用
  @override
  final String? remark;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'Supplier(id: $id, name: $name, contactPerson: $contactPerson, phone: $phone, address: $address, status: $status, remark: $remark, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.contactPerson, contactPerson) ||
                other.contactPerson == contactPerson) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, contactPerson, phone,
      address, status, remark, createdAt, updatedAt);

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierImplCopyWith<_$SupplierImpl> get copyWith =>
      __$$SupplierImplCopyWithImpl<_$SupplierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierImplToJson(
      this,
    );
  }
}

abstract class _Supplier implements Supplier {
  const factory _Supplier(
      {required final int id,
      @JsonKey(name: 'supplier_name') required final String name,
      @JsonKey(name: 'contact_person') final String? contactPerson,
      @JsonKey(name: 'contact_phone') final String? phone,
      @JsonKey(name: 'supplier_address') final String? address,
      final int? status,
      final String? remark,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$SupplierImpl;

  factory _Supplier.fromJson(Map<String, dynamic> json) =
      _$SupplierImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'supplier_name')
  String get name;
  @override
  @JsonKey(name: 'contact_person')
  String? get contactPerson;
  @override
  @JsonKey(name: 'contact_phone')
  String? get phone;
  @override
  @JsonKey(name: 'supplier_address')
  String? get address;
  @override
  int? get status; // 0=禁用 1=启用
  @override
  String? get remark;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierImplCopyWith<_$SupplierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SupplierCategory _$SupplierCategoryFromJson(Map<String, dynamic> json) {
  return _SupplierCategory.fromJson(json);
}

/// @nodoc
mixin _$SupplierCategory {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_id')
  int get supplierId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get sort => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SupplierCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SupplierCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierCategoryCopyWith<SupplierCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierCategoryCopyWith<$Res> {
  factory $SupplierCategoryCopyWith(
          SupplierCategory value, $Res Function(SupplierCategory) then) =
      _$SupplierCategoryCopyWithImpl<$Res, SupplierCategory>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'supplier_id') int supplierId,
      String name,
      int? sort,
      int? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$SupplierCategoryCopyWithImpl<$Res, $Val extends SupplierCategory>
    implements $SupplierCategoryCopyWith<$Res> {
  _$SupplierCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupplierCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? supplierId = null,
    Object? name = null,
    Object? sort = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sort: freezed == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupplierCategoryImplCopyWith<$Res>
    implements $SupplierCategoryCopyWith<$Res> {
  factory _$$SupplierCategoryImplCopyWith(_$SupplierCategoryImpl value,
          $Res Function(_$SupplierCategoryImpl) then) =
      __$$SupplierCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'supplier_id') int supplierId,
      String name,
      int? sort,
      int? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$SupplierCategoryImplCopyWithImpl<$Res>
    extends _$SupplierCategoryCopyWithImpl<$Res, _$SupplierCategoryImpl>
    implements _$$SupplierCategoryImplCopyWith<$Res> {
  __$$SupplierCategoryImplCopyWithImpl(_$SupplierCategoryImpl _value,
      $Res Function(_$SupplierCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of SupplierCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? supplierId = null,
    Object? name = null,
    Object? sort = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SupplierCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sort: freezed == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierCategoryImpl implements _SupplierCategory {
  const _$SupplierCategoryImpl(
      {required this.id,
      @JsonKey(name: 'supplier_id') required this.supplierId,
      required this.name,
      this.sort,
      this.status,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$SupplierCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierCategoryImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'supplier_id')
  final int supplierId;
  @override
  final String name;
  @override
  final int? sort;
  @override
  final int? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'SupplierCategory(id: $id, supplierId: $supplierId, name: $name, sort: $sort, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, supplierId, name, sort, status, createdAt, updatedAt);

  /// Create a copy of SupplierCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierCategoryImplCopyWith<_$SupplierCategoryImpl> get copyWith =>
      __$$SupplierCategoryImplCopyWithImpl<_$SupplierCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierCategoryImplToJson(
      this,
    );
  }
}

abstract class _SupplierCategory implements SupplierCategory {
  const factory _SupplierCategory(
          {required final int id,
          @JsonKey(name: 'supplier_id') required final int supplierId,
          required final String name,
          final int? sort,
          final int? status,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt}) =
      _$SupplierCategoryImpl;

  factory _SupplierCategory.fromJson(Map<String, dynamic> json) =
      _$SupplierCategoryImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'supplier_id')
  int get supplierId;
  @override
  String get name;
  @override
  int? get sort;
  @override
  int? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of SupplierCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierCategoryImplCopyWith<_$SupplierCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SupplierProduct _$SupplierProductFromJson(Map<String, dynamic> json) {
  return _SupplierProduct.fromJson(json);
}

/// @nodoc
mixin _$SupplierProduct {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_id')
  int get supplierId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError; // 关联数据
  @JsonKey(name: 'supplier')
  Supplier? get supplier => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  SupplierCategory? get category => throw _privateConstructorUsedError;

  /// Serializes this SupplierProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierProductCopyWith<SupplierProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierProductCopyWith<$Res> {
  factory $SupplierProductCopyWith(
          SupplierProduct value, $Res Function(SupplierProduct) then) =
      _$SupplierProductCopyWithImpl<$Res, SupplierProduct>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'supplier_id') int supplierId,
      @JsonKey(name: 'category_id') int categoryId,
      String name,
      String? unit,
      double? price,
      int? status,
      String? remark,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'supplier') Supplier? supplier,
      @JsonKey(name: 'category') SupplierCategory? category});

  $SupplierCopyWith<$Res>? get supplier;
  $SupplierCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$SupplierProductCopyWithImpl<$Res, $Val extends SupplierProduct>
    implements $SupplierProductCopyWith<$Res> {
  _$SupplierProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? supplierId = null,
    Object? categoryId = null,
    Object? name = null,
    Object? unit = freezed,
    Object? price = freezed,
    Object? status = freezed,
    Object? remark = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? supplier = freezed,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as Supplier?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SupplierCategory?,
    ) as $Val);
  }

  /// Create a copy of SupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SupplierCopyWith<$Res>? get supplier {
    if (_value.supplier == null) {
      return null;
    }

    return $SupplierCopyWith<$Res>(_value.supplier!, (value) {
      return _then(_value.copyWith(supplier: value) as $Val);
    });
  }

  /// Create a copy of SupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SupplierCategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $SupplierCategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SupplierProductImplCopyWith<$Res>
    implements $SupplierProductCopyWith<$Res> {
  factory _$$SupplierProductImplCopyWith(_$SupplierProductImpl value,
          $Res Function(_$SupplierProductImpl) then) =
      __$$SupplierProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'supplier_id') int supplierId,
      @JsonKey(name: 'category_id') int categoryId,
      String name,
      String? unit,
      double? price,
      int? status,
      String? remark,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'supplier') Supplier? supplier,
      @JsonKey(name: 'category') SupplierCategory? category});

  @override
  $SupplierCopyWith<$Res>? get supplier;
  @override
  $SupplierCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$SupplierProductImplCopyWithImpl<$Res>
    extends _$SupplierProductCopyWithImpl<$Res, _$SupplierProductImpl>
    implements _$$SupplierProductImplCopyWith<$Res> {
  __$$SupplierProductImplCopyWithImpl(
      _$SupplierProductImpl _value, $Res Function(_$SupplierProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of SupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? supplierId = null,
    Object? categoryId = null,
    Object? name = null,
    Object? unit = freezed,
    Object? price = freezed,
    Object? status = freezed,
    Object? remark = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? supplier = freezed,
    Object? category = freezed,
  }) {
    return _then(_$SupplierProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as Supplier?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SupplierCategory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierProductImpl implements _SupplierProduct {
  const _$SupplierProductImpl(
      {required this.id,
      @JsonKey(name: 'supplier_id') required this.supplierId,
      @JsonKey(name: 'category_id') required this.categoryId,
      required this.name,
      this.unit,
      this.price,
      this.status,
      this.remark,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'supplier') this.supplier,
      @JsonKey(name: 'category') this.category});

  factory _$SupplierProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierProductImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'supplier_id')
  final int supplierId;
  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  final String name;
  @override
  final String? unit;
  @override
  final double? price;
  @override
  final int? status;
  @override
  final String? remark;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
// 关联数据
  @override
  @JsonKey(name: 'supplier')
  final Supplier? supplier;
  @override
  @JsonKey(name: 'category')
  final SupplierCategory? category;

  @override
  String toString() {
    return 'SupplierProduct(id: $id, supplierId: $supplierId, categoryId: $categoryId, name: $name, unit: $unit, price: $price, status: $status, remark: $remark, createdAt: $createdAt, updatedAt: $updatedAt, supplier: $supplier, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, supplierId, categoryId, name,
      unit, price, status, remark, createdAt, updatedAt, supplier, category);

  /// Create a copy of SupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierProductImplCopyWith<_$SupplierProductImpl> get copyWith =>
      __$$SupplierProductImplCopyWithImpl<_$SupplierProductImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierProductImplToJson(
      this,
    );
  }
}

abstract class _SupplierProduct implements SupplierProduct {
  const factory _SupplierProduct(
          {required final int id,
          @JsonKey(name: 'supplier_id') required final int supplierId,
          @JsonKey(name: 'category_id') required final int categoryId,
          required final String name,
          final String? unit,
          final double? price,
          final int? status,
          final String? remark,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt,
          @JsonKey(name: 'supplier') final Supplier? supplier,
          @JsonKey(name: 'category') final SupplierCategory? category}) =
      _$SupplierProductImpl;

  factory _SupplierProduct.fromJson(Map<String, dynamic> json) =
      _$SupplierProductImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'supplier_id')
  int get supplierId;
  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  String get name;
  @override
  String? get unit;
  @override
  double? get price;
  @override
  int? get status;
  @override
  String? get remark;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt; // 关联数据
  @override
  @JsonKey(name: 'supplier')
  Supplier? get supplier;
  @override
  @JsonKey(name: 'category')
  SupplierCategory? get category;

  /// Create a copy of SupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierProductImplCopyWith<_$SupplierProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoreSupplierProduct _$StoreSupplierProductFromJson(Map<String, dynamic> json) {
  return _StoreSupplierProduct.fromJson(json);
}

/// @nodoc
mixin _$StoreSupplierProduct {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  int get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_product_id')
  int get supplierProductId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError; // 关联数据
  @JsonKey(name: 'supplier_product')
  SupplierProduct? get supplierProduct => throw _privateConstructorUsedError;

  /// Serializes this StoreSupplierProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreSupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreSupplierProductCopyWith<StoreSupplierProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreSupplierProductCopyWith<$Res> {
  factory $StoreSupplierProductCopyWith(StoreSupplierProduct value,
          $Res Function(StoreSupplierProduct) then) =
      _$StoreSupplierProductCopyWithImpl<$Res, StoreSupplierProduct>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'supplier_product_id') int supplierProductId,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'supplier_product') SupplierProduct? supplierProduct});

  $SupplierProductCopyWith<$Res>? get supplierProduct;
}

/// @nodoc
class _$StoreSupplierProductCopyWithImpl<$Res,
        $Val extends StoreSupplierProduct>
    implements $StoreSupplierProductCopyWith<$Res> {
  _$StoreSupplierProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreSupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? supplierProductId = null,
    Object? isDefault = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? supplierProduct = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierProductId: null == supplierProductId
          ? _value.supplierProductId
          : supplierProductId // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierProduct: freezed == supplierProduct
          ? _value.supplierProduct
          : supplierProduct // ignore: cast_nullable_to_non_nullable
              as SupplierProduct?,
    ) as $Val);
  }

  /// Create a copy of StoreSupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SupplierProductCopyWith<$Res>? get supplierProduct {
    if (_value.supplierProduct == null) {
      return null;
    }

    return $SupplierProductCopyWith<$Res>(_value.supplierProduct!, (value) {
      return _then(_value.copyWith(supplierProduct: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoreSupplierProductImplCopyWith<$Res>
    implements $StoreSupplierProductCopyWith<$Res> {
  factory _$$StoreSupplierProductImplCopyWith(_$StoreSupplierProductImpl value,
          $Res Function(_$StoreSupplierProductImpl) then) =
      __$$StoreSupplierProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'supplier_product_id') int supplierProductId,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'supplier_product') SupplierProduct? supplierProduct});

  @override
  $SupplierProductCopyWith<$Res>? get supplierProduct;
}

/// @nodoc
class __$$StoreSupplierProductImplCopyWithImpl<$Res>
    extends _$StoreSupplierProductCopyWithImpl<$Res, _$StoreSupplierProductImpl>
    implements _$$StoreSupplierProductImplCopyWith<$Res> {
  __$$StoreSupplierProductImplCopyWithImpl(_$StoreSupplierProductImpl _value,
      $Res Function(_$StoreSupplierProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoreSupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? supplierProductId = null,
    Object? isDefault = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? supplierProduct = freezed,
  }) {
    return _then(_$StoreSupplierProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierProductId: null == supplierProductId
          ? _value.supplierProductId
          : supplierProductId // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierProduct: freezed == supplierProduct
          ? _value.supplierProduct
          : supplierProduct // ignore: cast_nullable_to_non_nullable
              as SupplierProduct?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreSupplierProductImpl implements _StoreSupplierProduct {
  const _$StoreSupplierProductImpl(
      {required this.id,
      @JsonKey(name: 'store_id') required this.storeId,
      @JsonKey(name: 'supplier_product_id') required this.supplierProductId,
      @JsonKey(name: 'is_default') this.isDefault = false,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'supplier_product') this.supplierProduct});

  factory _$StoreSupplierProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreSupplierProductImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'store_id')
  final int storeId;
  @override
  @JsonKey(name: 'supplier_product_id')
  final int supplierProductId;
  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
// 关联数据
  @override
  @JsonKey(name: 'supplier_product')
  final SupplierProduct? supplierProduct;

  @override
  String toString() {
    return 'StoreSupplierProduct(id: $id, storeId: $storeId, supplierProductId: $supplierProductId, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt, supplierProduct: $supplierProduct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreSupplierProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.supplierProductId, supplierProductId) ||
                other.supplierProductId == supplierProductId) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.supplierProduct, supplierProduct) ||
                other.supplierProduct == supplierProduct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, storeId, supplierProductId,
      isDefault, createdAt, updatedAt, supplierProduct);

  /// Create a copy of StoreSupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreSupplierProductImplCopyWith<_$StoreSupplierProductImpl>
      get copyWith =>
          __$$StoreSupplierProductImplCopyWithImpl<_$StoreSupplierProductImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreSupplierProductImplToJson(
      this,
    );
  }
}

abstract class _StoreSupplierProduct implements StoreSupplierProduct {
  const factory _StoreSupplierProduct(
      {required final int id,
      @JsonKey(name: 'store_id') required final int storeId,
      @JsonKey(name: 'supplier_product_id')
      required final int supplierProductId,
      @JsonKey(name: 'is_default') final bool isDefault,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      @JsonKey(name: 'supplier_product')
      final SupplierProduct? supplierProduct}) = _$StoreSupplierProductImpl;

  factory _StoreSupplierProduct.fromJson(Map<String, dynamic> json) =
      _$StoreSupplierProductImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'store_id')
  int get storeId;
  @override
  @JsonKey(name: 'supplier_product_id')
  int get supplierProductId;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt; // 关联数据
  @override
  @JsonKey(name: 'supplier_product')
  SupplierProduct? get supplierProduct;

  /// Create a copy of StoreSupplierProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreSupplierProductImplCopyWith<_$StoreSupplierProductImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BindSupplierProductRequest _$BindSupplierProductRequestFromJson(
    Map<String, dynamic> json) {
  return _BindSupplierProductRequest.fromJson(json);
}

/// @nodoc
mixin _$BindSupplierProductRequest {
  @JsonKey(name: 'store_id')
  int get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_product_id')
  int get supplierProductId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool? get isDefault => throw _privateConstructorUsedError;

  /// Serializes this BindSupplierProductRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BindSupplierProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BindSupplierProductRequestCopyWith<BindSupplierProductRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BindSupplierProductRequestCopyWith<$Res> {
  factory $BindSupplierProductRequestCopyWith(BindSupplierProductRequest value,
          $Res Function(BindSupplierProductRequest) then) =
      _$BindSupplierProductRequestCopyWithImpl<$Res,
          BindSupplierProductRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'supplier_product_id') int supplierProductId,
      @JsonKey(name: 'is_default') bool? isDefault});
}

/// @nodoc
class _$BindSupplierProductRequestCopyWithImpl<$Res,
        $Val extends BindSupplierProductRequest>
    implements $BindSupplierProductRequestCopyWith<$Res> {
  _$BindSupplierProductRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BindSupplierProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? supplierProductId = null,
    Object? isDefault = freezed,
  }) {
    return _then(_value.copyWith(
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierProductId: null == supplierProductId
          ? _value.supplierProductId
          : supplierProductId // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BindSupplierProductRequestImplCopyWith<$Res>
    implements $BindSupplierProductRequestCopyWith<$Res> {
  factory _$$BindSupplierProductRequestImplCopyWith(
          _$BindSupplierProductRequestImpl value,
          $Res Function(_$BindSupplierProductRequestImpl) then) =
      __$$BindSupplierProductRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'supplier_product_id') int supplierProductId,
      @JsonKey(name: 'is_default') bool? isDefault});
}

/// @nodoc
class __$$BindSupplierProductRequestImplCopyWithImpl<$Res>
    extends _$BindSupplierProductRequestCopyWithImpl<$Res,
        _$BindSupplierProductRequestImpl>
    implements _$$BindSupplierProductRequestImplCopyWith<$Res> {
  __$$BindSupplierProductRequestImplCopyWithImpl(
      _$BindSupplierProductRequestImpl _value,
      $Res Function(_$BindSupplierProductRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of BindSupplierProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? supplierProductId = null,
    Object? isDefault = freezed,
  }) {
    return _then(_$BindSupplierProductRequestImpl(
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierProductId: null == supplierProductId
          ? _value.supplierProductId
          : supplierProductId // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BindSupplierProductRequestImpl implements _BindSupplierProductRequest {
  const _$BindSupplierProductRequestImpl(
      {@JsonKey(name: 'store_id') required this.storeId,
      @JsonKey(name: 'supplier_product_id') required this.supplierProductId,
      @JsonKey(name: 'is_default') this.isDefault});

  factory _$BindSupplierProductRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$BindSupplierProductRequestImplFromJson(json);

  @override
  @JsonKey(name: 'store_id')
  final int storeId;
  @override
  @JsonKey(name: 'supplier_product_id')
  final int supplierProductId;
  @override
  @JsonKey(name: 'is_default')
  final bool? isDefault;

  @override
  String toString() {
    return 'BindSupplierProductRequest(storeId: $storeId, supplierProductId: $supplierProductId, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BindSupplierProductRequestImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.supplierProductId, supplierProductId) ||
                other.supplierProductId == supplierProductId) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, storeId, supplierProductId, isDefault);

  /// Create a copy of BindSupplierProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BindSupplierProductRequestImplCopyWith<_$BindSupplierProductRequestImpl>
      get copyWith => __$$BindSupplierProductRequestImplCopyWithImpl<
          _$BindSupplierProductRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BindSupplierProductRequestImplToJson(
      this,
    );
  }
}

abstract class _BindSupplierProductRequest
    implements BindSupplierProductRequest {
  const factory _BindSupplierProductRequest(
          {@JsonKey(name: 'store_id') required final int storeId,
          @JsonKey(name: 'supplier_product_id')
          required final int supplierProductId,
          @JsonKey(name: 'is_default') final bool? isDefault}) =
      _$BindSupplierProductRequestImpl;

  factory _BindSupplierProductRequest.fromJson(Map<String, dynamic> json) =
      _$BindSupplierProductRequestImpl.fromJson;

  @override
  @JsonKey(name: 'store_id')
  int get storeId;
  @override
  @JsonKey(name: 'supplier_product_id')
  int get supplierProductId;
  @override
  @JsonKey(name: 'is_default')
  bool? get isDefault;

  /// Create a copy of BindSupplierProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BindSupplierProductRequestImplCopyWith<_$BindSupplierProductRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
