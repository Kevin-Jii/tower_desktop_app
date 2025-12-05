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

DictType _$DictTypeFromJson(Map<String, dynamic> json) {
  return _DictType.fromJson(json);
}

/// @nodoc
mixin _$DictType {
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DictType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DictType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DictTypeCopyWith<DictType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DictTypeCopyWith<$Res> {
  factory $DictTypeCopyWith(DictType value, $Res Function(DictType) then) =
      _$DictTypeCopyWithImpl<$Res, DictType>;
  @useResult
  $Res call(
      {int id,
      String code,
      String name,
      String? remark,
      int status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$DictTypeCopyWithImpl<$Res, $Val extends DictType>
    implements $DictTypeCopyWith<$Res> {
  _$DictTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DictType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
    Object? remark = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$DictTypeImplCopyWith<$Res>
    implements $DictTypeCopyWith<$Res> {
  factory _$$DictTypeImplCopyWith(
          _$DictTypeImpl value, $Res Function(_$DictTypeImpl) then) =
      __$$DictTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String code,
      String name,
      String? remark,
      int status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$DictTypeImplCopyWithImpl<$Res>
    extends _$DictTypeCopyWithImpl<$Res, _$DictTypeImpl>
    implements _$$DictTypeImplCopyWith<$Res> {
  __$$DictTypeImplCopyWithImpl(
      _$DictTypeImpl _value, $Res Function(_$DictTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of DictType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
    Object? remark = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DictTypeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$DictTypeImpl implements _DictType {
  const _$DictTypeImpl(
      {required this.id,
      required this.code,
      required this.name,
      this.remark,
      this.status = 1,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$DictTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DictTypeImplFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final String name;
  @override
  final String? remark;
  @override
  @JsonKey()
  final int status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'DictType(id: $id, code: $code, name: $name, remark: $remark, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, code, name, remark, status, createdAt, updatedAt);

  /// Create a copy of DictType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DictTypeImplCopyWith<_$DictTypeImpl> get copyWith =>
      __$$DictTypeImplCopyWithImpl<_$DictTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DictTypeImplToJson(
      this,
    );
  }
}

abstract class _DictType implements DictType {
  const factory _DictType(
      {required final int id,
      required final String code,
      required final String name,
      final String? remark,
      final int status,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$DictTypeImpl;

  factory _DictType.fromJson(Map<String, dynamic> json) =
      _$DictTypeImpl.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  String get name;
  @override
  String? get remark;
  @override
  int get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of DictType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DictTypeImplCopyWith<_$DictTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DictData _$DictDataFromJson(Map<String, dynamic> json) {
  return _DictData.fromJson(json);
}

/// @nodoc
mixin _$DictData {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_id')
  int get typeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_code')
  String get typeCode => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  int get sort => throw _privateConstructorUsedError;
  @JsonKey(name: 'css_class')
  String? get cssClass => throw _privateConstructorUsedError;
  @JsonKey(name: 'list_class')
  String? get listClass => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DictData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DictData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DictDataCopyWith<DictData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DictDataCopyWith<$Res> {
  factory $DictDataCopyWith(DictData value, $Res Function(DictData) then) =
      _$DictDataCopyWithImpl<$Res, DictData>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'type_id') int typeId,
      @JsonKey(name: 'type_code') String typeCode,
      String label,
      String value,
      int sort,
      @JsonKey(name: 'css_class') String? cssClass,
      @JsonKey(name: 'list_class') String? listClass,
      @JsonKey(name: 'is_default') bool isDefault,
      String? remark,
      int status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$DictDataCopyWithImpl<$Res, $Val extends DictData>
    implements $DictDataCopyWith<$Res> {
  _$DictDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DictData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? typeId = null,
    Object? typeCode = null,
    Object? label = null,
    Object? value = null,
    Object? sort = null,
    Object? cssClass = freezed,
    Object? listClass = freezed,
    Object? isDefault = null,
    Object? remark = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int,
      typeCode: null == typeCode
          ? _value.typeCode
          : typeCode // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as int,
      cssClass: freezed == cssClass
          ? _value.cssClass
          : cssClass // ignore: cast_nullable_to_non_nullable
              as String?,
      listClass: freezed == listClass
          ? _value.listClass
          : listClass // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$DictDataImplCopyWith<$Res>
    implements $DictDataCopyWith<$Res> {
  factory _$$DictDataImplCopyWith(
          _$DictDataImpl value, $Res Function(_$DictDataImpl) then) =
      __$$DictDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'type_id') int typeId,
      @JsonKey(name: 'type_code') String typeCode,
      String label,
      String value,
      int sort,
      @JsonKey(name: 'css_class') String? cssClass,
      @JsonKey(name: 'list_class') String? listClass,
      @JsonKey(name: 'is_default') bool isDefault,
      String? remark,
      int status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$DictDataImplCopyWithImpl<$Res>
    extends _$DictDataCopyWithImpl<$Res, _$DictDataImpl>
    implements _$$DictDataImplCopyWith<$Res> {
  __$$DictDataImplCopyWithImpl(
      _$DictDataImpl _value, $Res Function(_$DictDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DictData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? typeId = null,
    Object? typeCode = null,
    Object? label = null,
    Object? value = null,
    Object? sort = null,
    Object? cssClass = freezed,
    Object? listClass = freezed,
    Object? isDefault = null,
    Object? remark = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DictDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int,
      typeCode: null == typeCode
          ? _value.typeCode
          : typeCode // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as int,
      cssClass: freezed == cssClass
          ? _value.cssClass
          : cssClass // ignore: cast_nullable_to_non_nullable
              as String?,
      listClass: freezed == listClass
          ? _value.listClass
          : listClass // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$DictDataImpl implements _DictData {
  const _$DictDataImpl(
      {required this.id,
      @JsonKey(name: 'type_id') required this.typeId,
      @JsonKey(name: 'type_code') required this.typeCode,
      required this.label,
      required this.value,
      this.sort = 0,
      @JsonKey(name: 'css_class') this.cssClass,
      @JsonKey(name: 'list_class') this.listClass,
      @JsonKey(name: 'is_default') this.isDefault = false,
      this.remark,
      this.status = 1,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$DictDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DictDataImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'type_id')
  final int typeId;
  @override
  @JsonKey(name: 'type_code')
  final String typeCode;
  @override
  final String label;
  @override
  final String value;
  @override
  @JsonKey()
  final int sort;
  @override
  @JsonKey(name: 'css_class')
  final String? cssClass;
  @override
  @JsonKey(name: 'list_class')
  final String? listClass;
  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;
  @override
  final String? remark;
  @override
  @JsonKey()
  final int status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'DictData(id: $id, typeId: $typeId, typeCode: $typeCode, label: $label, value: $value, sort: $sort, cssClass: $cssClass, listClass: $listClass, isDefault: $isDefault, remark: $remark, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.typeCode, typeCode) ||
                other.typeCode == typeCode) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.cssClass, cssClass) ||
                other.cssClass == cssClass) &&
            (identical(other.listClass, listClass) ||
                other.listClass == listClass) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      typeId,
      typeCode,
      label,
      value,
      sort,
      cssClass,
      listClass,
      isDefault,
      remark,
      status,
      createdAt,
      updatedAt);

  /// Create a copy of DictData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DictDataImplCopyWith<_$DictDataImpl> get copyWith =>
      __$$DictDataImplCopyWithImpl<_$DictDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DictDataImplToJson(
      this,
    );
  }
}

abstract class _DictData implements DictData {
  const factory _DictData(
      {required final int id,
      @JsonKey(name: 'type_id') required final int typeId,
      @JsonKey(name: 'type_code') required final String typeCode,
      required final String label,
      required final String value,
      final int sort,
      @JsonKey(name: 'css_class') final String? cssClass,
      @JsonKey(name: 'list_class') final String? listClass,
      @JsonKey(name: 'is_default') final bool isDefault,
      final String? remark,
      final int status,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$DictDataImpl;

  factory _DictData.fromJson(Map<String, dynamic> json) =
      _$DictDataImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'type_id')
  int get typeId;
  @override
  @JsonKey(name: 'type_code')
  String get typeCode;
  @override
  String get label;
  @override
  String get value;
  @override
  int get sort;
  @override
  @JsonKey(name: 'css_class')
  String? get cssClass;
  @override
  @JsonKey(name: 'list_class')
  String? get listClass;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault;
  @override
  String? get remark;
  @override
  int get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of DictData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DictDataImplCopyWith<_$DictDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
