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
      throw _privateConstructorUsedError; // 1=待确认, 2=已确认, 3=已完成, 4=已取消
  @JsonKey(name: 'order_date')
  String? get orderDate => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  int? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError; // 关联数据
  Store? get store => throw _privateConstructorUsedError;
  User? get creator => throw _privateConstructorUsedError;
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
      @JsonKey(name: 'order_date') String? orderDate,
      String? remark,
      @JsonKey(name: 'created_by') int? createdBy,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      Store? store,
      User? creator,
      List<PurchaseOrderItem>? items});

  $StoreCopyWith<$Res>? get store;
  $UserCopyWith<$Res>? get creator;
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
    Object? orderDate = freezed,
    Object? remark = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? store = freezed,
    Object? creator = freezed,
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
      orderDate: freezed == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
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
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User?,
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

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get creator {
    if (_value.creator == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.creator!, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
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
      @JsonKey(name: 'order_date') String? orderDate,
      String? remark,
      @JsonKey(name: 'created_by') int? createdBy,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      Store? store,
      User? creator,
      List<PurchaseOrderItem>? items});

  @override
  $StoreCopyWith<$Res>? get store;
  @override
  $UserCopyWith<$Res>? get creator;
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
    Object? orderDate = freezed,
    Object? remark = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? store = freezed,
    Object? creator = freezed,
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
      orderDate: freezed == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
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
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User?,
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
      @JsonKey(name: 'total_amount') this.totalAmount = 0.0,
      this.status = 1,
      @JsonKey(name: 'order_date') this.orderDate,
      this.remark,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.store,
      this.creator,
      final List<PurchaseOrderItem>? items})
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
  @JsonKey()
  final int status;
// 1=待确认, 2=已确认, 3=已完成, 4=已取消
  @override
  @JsonKey(name: 'order_date')
  final String? orderDate;
  @override
  final String? remark;
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
  final Store? store;
  @override
  final User? creator;
  final List<PurchaseOrderItem>? _items;
  @override
  List<PurchaseOrderItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PurchaseOrder(id: $id, orderNo: $orderNo, storeId: $storeId, totalAmount: $totalAmount, status: $status, orderDate: $orderDate, remark: $remark, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, store: $store, creator: $creator, items: $items)';
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
            (identical(other.orderDate, orderDate) ||
                other.orderDate == orderDate) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.store, store) || other.store == store) &&
            (identical(other.creator, creator) || other.creator == creator) &&
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
      orderDate,
      remark,
      createdBy,
      createdAt,
      updatedAt,
      store,
      creator,
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
      @JsonKey(name: 'total_amount') final double totalAmount,
      final int status,
      @JsonKey(name: 'order_date') final String? orderDate,
      final String? remark,
      @JsonKey(name: 'created_by') final int? createdBy,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final Store? store,
      final User? creator,
      final List<PurchaseOrderItem>? items}) = _$PurchaseOrderImpl;

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
  int get status; // 1=待确认, 2=已确认, 3=已完成, 4=已取消
  @override
  @JsonKey(name: 'order_date')
  String? get orderDate;
  @override
  String? get remark;
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
  Store? get store;
  @override
  User? get creator;
  @override
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
  @JsonKey(name: 'order_id')
  int get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_id')
  int? get supplierId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  double get unitPrice => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError; // 关联数据
  Supplier? get supplier => throw _privateConstructorUsedError;
  SupplierProduct? get product => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'order_id') int orderId,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'supplier_id') int? supplierId,
      double quantity,
      @JsonKey(name: 'unit_price') double unitPrice,
      double amount,
      String? remark,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      Supplier? supplier,
      SupplierProduct? product});

  $SupplierCopyWith<$Res>? get supplier;
  $SupplierProductCopyWith<$Res>? get product;
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
    Object? orderId = null,
    Object? productId = null,
    Object? supplierId = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? amount = null,
    Object? remark = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? supplier = freezed,
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
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
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
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
  $SupplierProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $SupplierProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
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
      @JsonKey(name: 'order_id') int orderId,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'supplier_id') int? supplierId,
      double quantity,
      @JsonKey(name: 'unit_price') double unitPrice,
      double amount,
      String? remark,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      Supplier? supplier,
      SupplierProduct? product});

  @override
  $SupplierCopyWith<$Res>? get supplier;
  @override
  $SupplierProductCopyWith<$Res>? get product;
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
    Object? orderId = null,
    Object? productId = null,
    Object? supplierId = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? amount = null,
    Object? remark = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? supplier = freezed,
    Object? product = freezed,
  }) {
    return _then(_$PurchaseOrderItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
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
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as SupplierProduct?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseOrderItemImpl implements _PurchaseOrderItem {
  const _$PurchaseOrderItemImpl(
      {required this.id,
      @JsonKey(name: 'order_id') required this.orderId,
      @JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'supplier_id') this.supplierId,
      required this.quantity,
      @JsonKey(name: 'unit_price') this.unitPrice = 0.0,
      this.amount = 0.0,
      this.remark,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.supplier,
      this.product});

  factory _$PurchaseOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseOrderItemImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'order_id')
  final int orderId;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'supplier_id')
  final int? supplierId;
  @override
  final double quantity;
  @override
  @JsonKey(name: 'unit_price')
  final double unitPrice;
  @override
  @JsonKey()
  final double amount;
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
  final Supplier? supplier;
  @override
  final SupplierProduct? product;

  @override
  String toString() {
    return 'PurchaseOrderItem(id: $id, orderId: $orderId, productId: $productId, supplierId: $supplierId, quantity: $quantity, unitPrice: $unitPrice, amount: $amount, remark: $remark, createdAt: $createdAt, updatedAt: $updatedAt, supplier: $supplier, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseOrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderId,
      productId,
      supplierId,
      quantity,
      unitPrice,
      amount,
      remark,
      createdAt,
      updatedAt,
      supplier,
      product);

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
      @JsonKey(name: 'order_id') required final int orderId,
      @JsonKey(name: 'product_id') required final int productId,
      @JsonKey(name: 'supplier_id') final int? supplierId,
      required final double quantity,
      @JsonKey(name: 'unit_price') final double unitPrice,
      final double amount,
      final String? remark,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final Supplier? supplier,
      final SupplierProduct? product}) = _$PurchaseOrderItemImpl;

  factory _PurchaseOrderItem.fromJson(Map<String, dynamic> json) =
      _$PurchaseOrderItemImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'order_id')
  int get orderId;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'supplier_id')
  int? get supplierId;
  @override
  double get quantity;
  @override
  @JsonKey(name: 'unit_price')
  double get unitPrice;
  @override
  double get amount;
  @override
  String? get remark;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt; // 关联数据
  @override
  Supplier? get supplier;
  @override
  SupplierProduct? get product;

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
  @JsonKey(name: 'order_date')
  String get orderDate => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
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
      {@JsonKey(name: 'order_date') String orderDate,
      String? remark,
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
    Object? orderDate = null,
    Object? remark = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as String,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {@JsonKey(name: 'order_date') String orderDate,
      String? remark,
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
    Object? orderDate = null,
    Object? remark = freezed,
    Object? items = null,
  }) {
    return _then(_$CreatePurchaseOrderRequestImpl(
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as String,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {@JsonKey(name: 'order_date') required this.orderDate,
      this.remark,
      required final List<CreatePurchaseOrderItemRequest> items})
      : _items = items;

  factory _$CreatePurchaseOrderRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreatePurchaseOrderRequestImplFromJson(json);

  @override
  @JsonKey(name: 'order_date')
  final String orderDate;
  @override
  final String? remark;
  final List<CreatePurchaseOrderItemRequest> _items;
  @override
  List<CreatePurchaseOrderItemRequest> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'CreatePurchaseOrderRequest(orderDate: $orderDate, remark: $remark, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePurchaseOrderRequestImpl &&
            (identical(other.orderDate, orderDate) ||
                other.orderDate == orderDate) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, orderDate, remark,
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
          {@JsonKey(name: 'order_date') required final String orderDate,
          final String? remark,
          required final List<CreatePurchaseOrderItemRequest> items}) =
      _$CreatePurchaseOrderRequestImpl;

  factory _CreatePurchaseOrderRequest.fromJson(Map<String, dynamic> json) =
      _$CreatePurchaseOrderRequestImpl.fromJson;

  @override
  @JsonKey(name: 'order_date')
  String get orderDate;
  @override
  String? get remark;
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
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'product_id') int productId,
      double quantity,
      String? remark});
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
    Object? productId = null,
    Object? quantity = null,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {@JsonKey(name: 'product_id') int productId,
      double quantity,
      String? remark});
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
    Object? productId = null,
    Object? quantity = null,
    Object? remark = freezed,
  }) {
    return _then(_$CreatePurchaseOrderItemRequestImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePurchaseOrderItemRequestImpl
    implements _CreatePurchaseOrderItemRequest {
  const _$CreatePurchaseOrderItemRequestImpl(
      {@JsonKey(name: 'product_id') required this.productId,
      required this.quantity,
      this.remark});

  factory _$CreatePurchaseOrderItemRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreatePurchaseOrderItemRequestImplFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  final double quantity;
  @override
  final String? remark;

  @override
  String toString() {
    return 'CreatePurchaseOrderItemRequest(productId: $productId, quantity: $quantity, remark: $remark)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePurchaseOrderItemRequestImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, productId, quantity, remark);

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
      {@JsonKey(name: 'product_id') required final int productId,
      required final double quantity,
      final String? remark}) = _$CreatePurchaseOrderItemRequestImpl;

  factory _CreatePurchaseOrderItemRequest.fromJson(Map<String, dynamic> json) =
      _$CreatePurchaseOrderItemRequestImpl.fromJson;

  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  double get quantity;
  @override
  String? get remark;

  /// Create a copy of CreatePurchaseOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePurchaseOrderItemRequestImplCopyWith<
          _$CreatePurchaseOrderItemRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdatePurchaseOrderRequest _$UpdatePurchaseOrderRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdatePurchaseOrderRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdatePurchaseOrderRequest {
  int? get status => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;

  /// Serializes this UpdatePurchaseOrderRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePurchaseOrderRequestCopyWith<UpdatePurchaseOrderRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePurchaseOrderRequestCopyWith<$Res> {
  factory $UpdatePurchaseOrderRequestCopyWith(UpdatePurchaseOrderRequest value,
          $Res Function(UpdatePurchaseOrderRequest) then) =
      _$UpdatePurchaseOrderRequestCopyWithImpl<$Res,
          UpdatePurchaseOrderRequest>;
  @useResult
  $Res call({int? status, String? remark});
}

/// @nodoc
class _$UpdatePurchaseOrderRequestCopyWithImpl<$Res,
        $Val extends UpdatePurchaseOrderRequest>
    implements $UpdatePurchaseOrderRequestCopyWith<$Res> {
  _$UpdatePurchaseOrderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePurchaseOrderRequestImplCopyWith<$Res>
    implements $UpdatePurchaseOrderRequestCopyWith<$Res> {
  factory _$$UpdatePurchaseOrderRequestImplCopyWith(
          _$UpdatePurchaseOrderRequestImpl value,
          $Res Function(_$UpdatePurchaseOrderRequestImpl) then) =
      __$$UpdatePurchaseOrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? status, String? remark});
}

/// @nodoc
class __$$UpdatePurchaseOrderRequestImplCopyWithImpl<$Res>
    extends _$UpdatePurchaseOrderRequestCopyWithImpl<$Res,
        _$UpdatePurchaseOrderRequestImpl>
    implements _$$UpdatePurchaseOrderRequestImplCopyWith<$Res> {
  __$$UpdatePurchaseOrderRequestImplCopyWithImpl(
      _$UpdatePurchaseOrderRequestImpl _value,
      $Res Function(_$UpdatePurchaseOrderRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? remark = freezed,
  }) {
    return _then(_$UpdatePurchaseOrderRequestImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePurchaseOrderRequestImpl implements _UpdatePurchaseOrderRequest {
  const _$UpdatePurchaseOrderRequestImpl({this.status, this.remark});

  factory _$UpdatePurchaseOrderRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdatePurchaseOrderRequestImplFromJson(json);

  @override
  final int? status;
  @override
  final String? remark;

  @override
  String toString() {
    return 'UpdatePurchaseOrderRequest(status: $status, remark: $remark)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePurchaseOrderRequestImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, remark);

  /// Create a copy of UpdatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePurchaseOrderRequestImplCopyWith<_$UpdatePurchaseOrderRequestImpl>
      get copyWith => __$$UpdatePurchaseOrderRequestImplCopyWithImpl<
          _$UpdatePurchaseOrderRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePurchaseOrderRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdatePurchaseOrderRequest
    implements UpdatePurchaseOrderRequest {
  const factory _UpdatePurchaseOrderRequest(
      {final int? status,
      final String? remark}) = _$UpdatePurchaseOrderRequestImpl;

  factory _UpdatePurchaseOrderRequest.fromJson(Map<String, dynamic> json) =
      _$UpdatePurchaseOrderRequestImpl.fromJson;

  @override
  int? get status;
  @override
  String? get remark;

  /// Create a copy of UpdatePurchaseOrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePurchaseOrderRequestImplCopyWith<_$UpdatePurchaseOrderRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
