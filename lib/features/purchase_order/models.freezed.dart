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

PurchaseOrder _$PurchaseOrderFromJson(Map<String, dynamic> json) {
  return _PurchaseOrder.fromJson(json);
}

/// @nodoc
mixin _$PurchaseOrder {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_no')
  String get orderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  int get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  int get status =>
      throw _privateConstructorUsedError; // 0=待确认, 1=已确认, 2=已完成, 3=已取消
  @JsonKey(name: 'report_date')
  String get reportDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  int? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError; // 关联数据
  @JsonKey(name: 'store')
  Store? get store => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<PurchaseOrderItem>? get items => throw _privateConstructorUsedError;

  /// Serializes this PurchaseOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseOrderCopyWith<PurchaseOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseOrderCopyWith<$Res> {
  factory $PurchaseOrderCopyWith(
          PurchaseOrder value, $Res Function(PurchaseOrder) then) =
      _$PurchaseOrderCopyWithImpl<$Res, PurchaseOrder>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'order_no') String orderNo,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'total_amount') double totalAmount,
      int status,
      @JsonKey(name: 'report_date') String reportDate,
      @JsonKey(name: 'created_by') int? createdBy,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'store') Store? store,
      @JsonKey(name: 'items') List<PurchaseOrderItem>? items});

  $StoreCopyWith<$Res>? get store;
}

/// @nodoc
class _$PurchaseOrderCopyWithImpl<$Res, $Val extends PurchaseOrder>
    implements $PurchaseOrderCopyWith<$Res> {
  _$PurchaseOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNo = null,
    Object? storeId = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? reportDate = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? store = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      reportDate: null == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as Store?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseOrderItem>?,
    ) as $Val);
  }

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoreCopyWith<$Res>? get store {
    if (_value.store == null) {
      return null;
    }

    return $StoreCopyWith<$Res>(_value.store!, (value) {
      return _then(_value.copyWith(store: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PurchaseOrderImplCopyWith<$Res>
    implements $PurchaseOrderCopyWith<$Res> {
  factory _$$PurchaseOrderImplCopyWith(
          _$PurchaseOrderImpl value, $Res Function(_$PurchaseOrderImpl) then) =
      __$$PurchaseOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'order_no') String orderNo,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'total_amount') double totalAmount,
      int status,
      @JsonKey(name: 'report_date') String reportDate,
      @JsonKey(name: 'created_by') int? createdBy,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'store') Store? store,
      @JsonKey(name: 'items') List<PurchaseOrderItem>? items});

  @override
  $StoreCopyWith<$Res>? get store;
}

/// @nodoc
class __$$PurchaseOrderImplCopyWithImpl<$Res>
    extends _$PurchaseOrderCopyWithImpl<$Res, _$PurchaseOrderImpl>
    implements _$$PurchaseOrderImplCopyWith<$Res> {
  __$$PurchaseOrderImplCopyWithImpl(
      _$PurchaseOrderImpl _value, $Res Function(_$PurchaseOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNo = null,
    Object? storeId = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? reportDate = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? store = freezed,
    Object? items = freezed,
  }) {
    return _then(_$PurchaseOrderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      reportDate: null == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as Store?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseOrderItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseOrderImpl implements _PurchaseOrder {
  const _$PurchaseOrderImpl(
      {required this.id,
      @JsonKey(name: 'order_no') required this.orderNo,
      @JsonKey(name: 'store_id') required this.storeId,
      @JsonKey(name: 'total_amount') required this.totalAmount,
      required this.status,
      @JsonKey(name: 'report_date') required this.reportDate,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'store') this.store,
      @JsonKey(name: 'items') final List<PurchaseOrderItem>? items})
      : _items = items;

  factory _$PurchaseOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseOrderImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'order_no')
  final String orderNo;
  @override
  @JsonKey(name: 'store_id')
  final int storeId;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  final int status;
// 0=待确认, 1=已确认, 2=已完成, 3=已取消
  @override
  @JsonKey(name: 'report_date')
  final String reportDate;
  @override
  @JsonKey(name: 'created_by')
  final int? createdBy;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
// 关联数据
  @override
  @JsonKey(name: 'store')
  final Store? store;
  final List<PurchaseOrderItem>? _items;
  @override
  @JsonKey(name: 'items')
  List<PurchaseOrderItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PurchaseOrder(id: $id, orderNo: $orderNo, storeId: $storeId, totalAmount: $totalAmount, status: $status, reportDate: $reportDate, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, store: $store, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reportDate, reportDate) ||
                other.reportDate == reportDate) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.store, store) || other.store == store) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderNo,
      storeId,
      totalAmount,
      status,
      reportDate,
      createdBy,
      createdAt,
      updatedAt,
      store,
      const DeepCollectionEquality().hash(_items));

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseOrderImplCopyWith<_$PurchaseOrderImpl> get copyWith =>
      __$$PurchaseOrderImplCopyWithImpl<_$PurchaseOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseOrderImplToJson(
      this,
    );
  }
}

abstract class _PurchaseOrder implements PurchaseOrder {
  const factory _PurchaseOrder(
          {required final int id,
          @JsonKey(name: 'order_no') required final String orderNo,
          @JsonKey(name: 'store_id') required final int storeId,
          @JsonKey(name: 'total_amount') required final double totalAmount,
          required final int status,
          @JsonKey(name: 'report_date') required final String reportDate,
          @JsonKey(name: 'created_by') final int? createdBy,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt,
          @JsonKey(name: 'store') final Store? store,
          @JsonKey(name: 'items') final List<PurchaseOrderItem>? items}) =
      _$PurchaseOrderImpl;

  factory _PurchaseOrder.fromJson(Map<String, dynamic> json) =
      _$PurchaseOrderImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'order_no')
  String get orderNo;
  @override
  @JsonKey(name: 'store_id')
  int get storeId;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  int get status; // 0=待确认, 1=已确认, 2=已完成, 3=已取消
  @override
  @JsonKey(name: 'report_date')
  String get reportDate;
  @override
  @JsonKey(name: 'created_by')
  int? get createdBy;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt; // 关联数据
  @override
  @JsonKey(name: 'store')
  Store? get store;
  @override
  @JsonKey(name: 'items')
  List<PurchaseOrderItem>? get items;

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseOrderImplCopyWith<_$PurchaseOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseOrderItem _$PurchaseOrderItemFromJson(Map<String, dynamic> json) {
  return _PurchaseOrderItem.fromJson(json);
}

/// @nodoc
mixin _$PurchaseOrderItem {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_order_id')
  int get purchaseOrderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_id')
  int get supplierId => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_product_id')
  int get supplierProductId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError; // 关联数据
  @JsonKey(name: 'supplier')
  Supplier? get supplier => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_product')
  SupplierProduct? get supplierProduct => throw _privateConstructorUsedError;

  /// Serializes this PurchaseOrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseOrderItemCopyWith<PurchaseOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseOrderItemCopyWith<$Res> {
  factory $PurchaseOrderItemCopyWith(
          PurchaseOrderItem value, $Res Function(PurchaseOrderItem) then) =
      _$PurchaseOrderItemCopyWithImpl<$Res, PurchaseOrderItem>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'purchase_order_id') int purchaseOrderId,
      @JsonKey(name: 'supplier_id') int supplierId,
      @JsonKey(name: 'supplier_product_id') int supplierProductId,
      double quantity,
      double price,
      double amount,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'supplier') Supplier? supplier,
      @JsonKey(name: 'supplier_product') SupplierProduct? supplierProduct});

  $SupplierCopyWith<$Res>? get supplier;
  $SupplierProductCopyWith<$Res>? get supplierProduct;
}

/// @nodoc
class _$PurchaseOrderItemCopyWithImpl<$Res, $Val extends PurchaseOrderItem>
    implements $PurchaseOrderItemCopyWith<$Res> {
  _$PurchaseOrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? purchaseOrderId = null,
    Object? supplierId = null,
    Object? supplierProductId = null,
    Object? quantity = null,
    Object? price = null,
    Object? amount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? supplier = freezed,
    Object? supplierProduct = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      purchaseOrderId: null == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierProductId: null == supplierProductId
          ? _value.supplierProductId
          : supplierProductId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
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
      supplierProduct: freezed == supplierProduct
          ? _value.supplierProduct
          : supplierProduct // ignore: cast_nullable_to_non_nullable
              as SupplierProduct?,
    ) as $Val);
  }

  /// Create a copy of PurchaseOrderItem
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

  /// Create a copy of PurchaseOrderItem
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
abstract class _$$PurchaseOrderItemImplCopyWith<$Res>
    implements $PurchaseOrderItemCopyWith<$Res> {
  factory _$$PurchaseOrderItemImplCopyWith(_$PurchaseOrderItemImpl value,
          $Res Function(_$PurchaseOrderItemImpl) then) =
      __$$PurchaseOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'purchase_order_id') int purchaseOrderId,
      @JsonKey(name: 'supplier_id') int supplierId,
      @JsonKey(name: 'supplier_product_id') int supplierProductId,
      double quantity,
      double price,
      double amount,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'supplier') Supplier? supplier,
      @JsonKey(name: 'supplier_product') SupplierProduct? supplierProduct});

  @override
  $SupplierCopyWith<$Res>? get supplier;
  @override
  $SupplierProductCopyWith<$Res>? get supplierProduct;
}

/// @nodoc
class __$$PurchaseOrderItemImplCopyWithImpl<$Res>
    extends _$PurchaseOrderItemCopyWithImpl<$Res, _$PurchaseOrderItemImpl>
    implements _$$PurchaseOrderItemImplCopyWith<$Res> {
  __$$PurchaseOrderItemImplCopyWithImpl(_$PurchaseOrderItemImpl _value,
      $Res Function(_$PurchaseOrderItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? purchaseOrderId = null,
    Object? supplierId = null,
    Object? supplierProductId = null,
    Object? quantity = null,
    Object? price = null,
    Object? amount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? supplier = freezed,
    Object? supplierProduct = freezed,
  }) {
    return _then(_$PurchaseOrderItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      purchaseOrderId: null == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierProductId: null == supplierProductId
          ? _value.supplierProductId
          : supplierProductId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
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
      supplierProduct: freezed == supplierProduct
          ? _value.supplierProduct
          : supplierProduct // ignore: cast_nullable_to_non_nullable
              as SupplierProduct?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseOrderItemImpl implements _PurchaseOrderItem {
  const _$PurchaseOrderItemImpl(
      {required this.id,
      @JsonKey(name: 'purchase_order_id') required this.purchaseOrderId,
      @JsonKey(name: 'supplier_id') required this.supplierId,
      @JsonKey(name: 'supplier_product_id') required this.supplierProductId,
      required this.quantity,
      required this.price,
      required this.amount,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'supplier') this.supplier,
      @JsonKey(name: 'supplier_product') this.supplierProduct});

  factory _$PurchaseOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseOrderItemImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'purchase_order_id')
  final int purchaseOrderId;
  @override
  @JsonKey(name: 'supplier_id')
  final int supplierId;
  @override
  @JsonKey(name: 'supplier_product_id')
  final int supplierProductId;
  @override
  final double quantity;
  @override
  final double price;
  @override
  final double amount;
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
  @JsonKey(name: 'supplier_product')
  final SupplierProduct? supplierProduct;

  @override
  String toString() {
    return 'PurchaseOrderItem(id: $id, purchaseOrderId: $purchaseOrderId, supplierId: $supplierId, supplierProductId: $supplierProductId, quantity: $quantity, price: $price, amount: $amount, createdAt: $createdAt, updatedAt: $updatedAt, supplier: $supplier, supplierProduct: $supplierProduct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseOrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.purchaseOrderId, purchaseOrderId) ||
                other.purchaseOrderId == purchaseOrderId) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.supplierProductId, supplierProductId) ||
                other.supplierProductId == supplierProductId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.supplierProduct, supplierProduct) ||
                other.supplierProduct == supplierProduct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      purchaseOrderId,
      supplierId,
      supplierProductId,
      quantity,
      price,
      amount,
      createdAt,
      updatedAt,
      supplier,
      supplierProduct);

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseOrderItemImplCopyWith<_$PurchaseOrderItemImpl> get copyWith =>
      __$$PurchaseOrderItemImplCopyWithImpl<_$PurchaseOrderItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseOrderItemImplToJson(
      this,
    );
  }
}

abstract class _PurchaseOrderItem implements PurchaseOrderItem {
  const factory _PurchaseOrderItem(
      {required final int id,
      @JsonKey(name: 'purchase_order_id') required final int purchaseOrderId,
      @JsonKey(name: 'supplier_id') required final int supplierId,
      @JsonKey(name: 'supplier_product_id')
      required final int supplierProductId,
      required final double quantity,
      required final double price,
      required final double amount,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      @JsonKey(name: 'supplier') final Supplier? supplier,
      @JsonKey(name: 'supplier_product')
      final SupplierProduct? supplierProduct}) = _$PurchaseOrderItemImpl;

  factory _PurchaseOrderItem.fromJson(Map<String, dynamic> json) =
      _$PurchaseOrderItemImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'purchase_order_id')
  int get purchaseOrderId;
  @override
  @JsonKey(name: 'supplier_id')
  int get supplierId;
  @override
  @JsonKey(name: 'supplier_product_id')
  int get supplierProductId;
  @override
  double get quantity;
  @override
  double get price;
  @override
  double get amount;
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
  @JsonKey(name: 'supplier_product')
  SupplierProduct? get supplierProduct;

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseOrderItemImplCopyWith<_$PurchaseOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatePurchaseOrderRequest _$CreatePurchaseOrderRequestFromJson(
    Map<String, dynamic> json) {
  return _CreatePurchaseOrderRequest.fromJson(json);
}

/// @nodoc
mixin _$CreatePurchaseOrderRequest {
  @JsonKey(name: 'store_id')
  int get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'report_date')
  String get reportDate => throw _privateConstructorUsedError;
  List<CreatePurchaseOrderItemRequest> get items =>
      throw _privateConstructorUsedError;

  /// Serializes this CreatePurchaseOrderRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePurchaseOrderRequestCopyWith<CreatePurchaseOrderRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePurchaseOrderRequestCopyWith<$Res> {
  factory $CreatePurchaseOrderRequestCopyWith(CreatePurchaseOrderRequest value,
          $Res Function(CreatePurchaseOrderRequest) then) =
      _$CreatePurchaseOrderRequestCopyWithImpl<$Res,
          CreatePurchaseOrderRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'report_date') String reportDate,
      List<CreatePurchaseOrderItemRequest> items});
}

/// @nodoc
class _$CreatePurchaseOrderRequestCopyWithImpl<$Res,
        $Val extends CreatePurchaseOrderRequest>
    implements $CreatePurchaseOrderRequestCopyWith<$Res> {
  _$CreatePurchaseOrderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? reportDate = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      reportDate: null == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CreatePurchaseOrderItemRequest>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatePurchaseOrderRequestImplCopyWith<$Res>
    implements $CreatePurchaseOrderRequestCopyWith<$Res> {
  factory _$$CreatePurchaseOrderRequestImplCopyWith(
          _$CreatePurchaseOrderRequestImpl value,
          $Res Function(_$CreatePurchaseOrderRequestImpl) then) =
      __$$CreatePurchaseOrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'report_date') String reportDate,
      List<CreatePurchaseOrderItemRequest> items});
}

/// @nodoc
class __$$CreatePurchaseOrderRequestImplCopyWithImpl<$Res>
    extends _$CreatePurchaseOrderRequestCopyWithImpl<$Res,
        _$CreatePurchaseOrderRequestImpl>
    implements _$$CreatePurchaseOrderRequestImplCopyWith<$Res> {
  __$$CreatePurchaseOrderRequestImplCopyWithImpl(
      _$CreatePurchaseOrderRequestImpl _value,
      $Res Function(_$CreatePurchaseOrderRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? reportDate = null,
    Object? items = null,
  }) {
    return _then(_$CreatePurchaseOrderRequestImpl(
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      reportDate: null == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CreatePurchaseOrderItemRequest>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePurchaseOrderRequestImpl implements _CreatePurchaseOrderRequest {
  const _$CreatePurchaseOrderRequestImpl(
      {@JsonKey(name: 'store_id') required this.storeId,
      @JsonKey(name: 'report_date') required this.reportDate,
      required final List<CreatePurchaseOrderItemRequest> items})
      : _items = items;

  factory _$CreatePurchaseOrderRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreatePurchaseOrderRequestImplFromJson(json);

  @override
  @JsonKey(name: 'store_id')
  final int storeId;
  @override
  @JsonKey(name: 'report_date')
  final String reportDate;
  final List<CreatePurchaseOrderItemRequest> _items;
  @override
  List<CreatePurchaseOrderItemRequest> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'CreatePurchaseOrderRequest(storeId: $storeId, reportDate: $reportDate, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePurchaseOrderRequestImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.reportDate, reportDate) ||
                other.reportDate == reportDate) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storeId, reportDate,
      const DeepCollectionEquality().hash(_items));

  /// Create a copy of CreatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePurchaseOrderRequestImplCopyWith<_$CreatePurchaseOrderRequestImpl>
      get copyWith => __$$CreatePurchaseOrderRequestImplCopyWithImpl<
          _$CreatePurchaseOrderRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePurchaseOrderRequestImplToJson(
      this,
    );
  }
}

abstract class _CreatePurchaseOrderRequest
    implements CreatePurchaseOrderRequest {
  const factory _CreatePurchaseOrderRequest(
          {@JsonKey(name: 'store_id') required final int storeId,
          @JsonKey(name: 'report_date') required final String reportDate,
          required final List<CreatePurchaseOrderItemRequest> items}) =
      _$CreatePurchaseOrderRequestImpl;

  factory _CreatePurchaseOrderRequest.fromJson(Map<String, dynamic> json) =
      _$CreatePurchaseOrderRequestImpl.fromJson;

  @override
  @JsonKey(name: 'store_id')
  int get storeId;
  @override
  @JsonKey(name: 'report_date')
  String get reportDate;
  @override
  List<CreatePurchaseOrderItemRequest> get items;

  /// Create a copy of CreatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePurchaseOrderRequestImplCopyWith<_$CreatePurchaseOrderRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CreatePurchaseOrderItemRequest _$CreatePurchaseOrderItemRequestFromJson(
    Map<String, dynamic> json) {
  return _CreatePurchaseOrderItemRequest.fromJson(json);
}

/// @nodoc
mixin _$CreatePurchaseOrderItemRequest {
  @JsonKey(name: 'supplier_product_id')
  int get supplierProductId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;

  /// Serializes this CreatePurchaseOrderItemRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePurchaseOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePurchaseOrderItemRequestCopyWith<CreatePurchaseOrderItemRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePurchaseOrderItemRequestCopyWith<$Res> {
  factory $CreatePurchaseOrderItemRequestCopyWith(
          CreatePurchaseOrderItemRequest value,
          $Res Function(CreatePurchaseOrderItemRequest) then) =
      _$CreatePurchaseOrderItemRequestCopyWithImpl<$Res,
          CreatePurchaseOrderItemRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'supplier_product_id') int supplierProductId,
      double quantity});
}

/// @nodoc
class _$CreatePurchaseOrderItemRequestCopyWithImpl<$Res,
        $Val extends CreatePurchaseOrderItemRequest>
    implements $CreatePurchaseOrderItemRequestCopyWith<$Res> {
  _$CreatePurchaseOrderItemRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePurchaseOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supplierProductId = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      supplierProductId: null == supplierProductId
          ? _value.supplierProductId
          : supplierProductId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatePurchaseOrderItemRequestImplCopyWith<$Res>
    implements $CreatePurchaseOrderItemRequestCopyWith<$Res> {
  factory _$$CreatePurchaseOrderItemRequestImplCopyWith(
          _$CreatePurchaseOrderItemRequestImpl value,
          $Res Function(_$CreatePurchaseOrderItemRequestImpl) then) =
      __$$CreatePurchaseOrderItemRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'supplier_product_id') int supplierProductId,
      double quantity});
}

/// @nodoc
class __$$CreatePurchaseOrderItemRequestImplCopyWithImpl<$Res>
    extends _$CreatePurchaseOrderItemRequestCopyWithImpl<$Res,
        _$CreatePurchaseOrderItemRequestImpl>
    implements _$$CreatePurchaseOrderItemRequestImplCopyWith<$Res> {
  __$$CreatePurchaseOrderItemRequestImplCopyWithImpl(
      _$CreatePurchaseOrderItemRequestImpl _value,
      $Res Function(_$CreatePurchaseOrderItemRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePurchaseOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supplierProductId = null,
    Object? quantity = null,
  }) {
    return _then(_$CreatePurchaseOrderItemRequestImpl(
      supplierProductId: null == supplierProductId
          ? _value.supplierProductId
          : supplierProductId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePurchaseOrderItemRequestImpl
    implements _CreatePurchaseOrderItemRequest {
  const _$CreatePurchaseOrderItemRequestImpl(
      {@JsonKey(name: 'supplier_product_id') required this.supplierProductId,
      required this.quantity});

  factory _$CreatePurchaseOrderItemRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreatePurchaseOrderItemRequestImplFromJson(json);

  @override
  @JsonKey(name: 'supplier_product_id')
  final int supplierProductId;
  @override
  final double quantity;

  @override
  String toString() {
    return 'CreatePurchaseOrderItemRequest(supplierProductId: $supplierProductId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePurchaseOrderItemRequestImpl &&
            (identical(other.supplierProductId, supplierProductId) ||
                other.supplierProductId == supplierProductId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, supplierProductId, quantity);

  /// Create a copy of CreatePurchaseOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePurchaseOrderItemRequestImplCopyWith<
          _$CreatePurchaseOrderItemRequestImpl>
      get copyWith => __$$CreatePurchaseOrderItemRequestImplCopyWithImpl<
          _$CreatePurchaseOrderItemRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePurchaseOrderItemRequestImplToJson(
      this,
    );
  }
}

abstract class _CreatePurchaseOrderItemRequest
    implements CreatePurchaseOrderItemRequest {
  const factory _CreatePurchaseOrderItemRequest(
      {@JsonKey(name: 'supplier_product_id')
      required final int supplierProductId,
      required final double quantity}) = _$CreatePurchaseOrderItemRequestImpl;

  factory _CreatePurchaseOrderItemRequest.fromJson(Map<String, dynamic> json) =
      _$CreatePurchaseOrderItemRequestImpl.fromJson;

  @override
  @JsonKey(name: 'supplier_product_id')
  int get supplierProductId;
  @override
  double get quantity;

  /// Create a copy of CreatePurchaseOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePurchaseOrderItemRequestImplCopyWith<
          _$CreatePurchaseOrderItemRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
