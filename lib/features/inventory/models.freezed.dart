part of 'models.dart';
T _$identity<T>(T value) => value;
final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https:
Inventory _$InventoryFromJson(Map<String, dynamic> json) {
  return _Inventory.fromJson(json);
}
mixin _$Inventory {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  int get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_name')
  String? get storeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryCopyWith<Inventory> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $InventoryCopyWith<$Res> {
  factory $InventoryCopyWith(Inventory value, $Res Function(Inventory) then) =
      _$InventoryCopyWithImpl<$Res, Inventory>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'store_name') String? storeName,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'product_name') String? productName,
      double quantity,
      String? unit});
}
class _$InventoryCopyWithImpl<$Res, $Val extends Inventory>
    implements $InventoryCopyWith<$Res> {
  _$InventoryCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? storeName = freezed,
    Object? productId = null,
    Object? productName = freezed,
    Object? quantity = null,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId 
              as int,
      storeName: freezed == storeName
          ? _value.storeName
          : storeName 
              as String?,
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      productName: freezed == productName
          ? _value.productName
          : productName 
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
    ) as $Val);
  }
}
abstract class _$$InventoryImplCopyWith<$Res>
    implements $InventoryCopyWith<$Res> {
  factory _$$InventoryImplCopyWith(
          _$InventoryImpl value, $Res Function(_$InventoryImpl) then) =
      __$$InventoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'store_name') String? storeName,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'product_name') String? productName,
      double quantity,
      String? unit});
}
class __$$InventoryImplCopyWithImpl<$Res>
    extends _$InventoryCopyWithImpl<$Res, _$InventoryImpl>
    implements _$$InventoryImplCopyWith<$Res> {
  __$$InventoryImplCopyWithImpl(
      _$InventoryImpl _value, $Res Function(_$InventoryImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? storeName = freezed,
    Object? productId = null,
    Object? productName = freezed,
    Object? quantity = null,
    Object? unit = freezed,
  }) {
    return _then(_$InventoryImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId 
              as int,
      storeName: freezed == storeName
          ? _value.storeName
          : storeName 
              as String?,
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      productName: freezed == productName
          ? _value.productName
          : productName 
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$InventoryImpl implements _Inventory {
  const _$InventoryImpl(
      {required this.id,
      @JsonKey(name: 'store_id') required this.storeId,
      @JsonKey(name: 'store_name') this.storeName,
      @JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'product_name') this.productName,
      this.quantity = 0.0,
      this.unit});
  factory _$InventoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'store_id')
  final int storeId;
  @override
  @JsonKey(name: 'store_name')
  final String? storeName;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  @JsonKey()
  final double quantity;
  @override
  final String? unit;
  @override
  String toString() {
    return 'Inventory(id: $id, storeId: $storeId, storeName: $storeName, productId: $productId, productName: $productName, quantity: $quantity, unit: $unit)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, storeId, storeName,
      productId, productName, quantity, unit);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      __$$InventoryImplCopyWithImpl<_$InventoryImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryImplToJson(
      this,
    );
  }
}
abstract class _Inventory implements Inventory {
  const factory _Inventory(
      {required final int id,
      @JsonKey(name: 'store_id') required final int storeId,
      @JsonKey(name: 'store_name') final String? storeName,
      @JsonKey(name: 'product_id') required final int productId,
      @JsonKey(name: 'product_name') final String? productName,
      final double quantity,
      final String? unit}) = _$InventoryImpl;
  factory _Inventory.fromJson(Map<String, dynamic> json) =
      _$InventoryImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'store_id')
  int get storeId;
  @override
  @JsonKey(name: 'store_name')
  String? get storeName;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  double get quantity;
  @override
  String? get unit;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
InventoryRecord _$InventoryRecordFromJson(Map<String, dynamic> json) {
  return _InventoryRecord.fromJson(json);
}
mixin _$InventoryRecord {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'record_no')
  String? get recordNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  int get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError; 
  double get quantity => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'operator_id')
  int? get operatorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError; 
  InventoryStore? get store => throw _privateConstructorUsedError;
  InventoryProduct? get product => throw _privateConstructorUsedError;
  InventoryOperator? get operator => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryRecordCopyWith<InventoryRecord> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $InventoryRecordCopyWith<$Res> {
  factory $InventoryRecordCopyWith(
          InventoryRecord value, $Res Function(InventoryRecord) then) =
      _$InventoryRecordCopyWithImpl<$Res, InventoryRecord>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'record_no') String? recordNo,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'product_id') int productId,
      int type,
      double quantity,
      String? unit,
      String? reason,
      String? remark,
      @JsonKey(name: 'operator_id') int? operatorId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      InventoryStore? store,
      InventoryProduct? product,
      InventoryOperator? operator});
  $InventoryStoreCopyWith<$Res>? get store;
  $InventoryProductCopyWith<$Res>? get product;
  $InventoryOperatorCopyWith<$Res>? get operator;
}
class _$InventoryRecordCopyWithImpl<$Res, $Val extends InventoryRecord>
    implements $InventoryRecordCopyWith<$Res> {
  _$InventoryRecordCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recordNo = freezed,
    Object? storeId = null,
    Object? productId = null,
    Object? type = null,
    Object? quantity = null,
    Object? unit = freezed,
    Object? reason = freezed,
    Object? remark = freezed,
    Object? operatorId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? store = freezed,
    Object? product = freezed,
    Object? operator = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      recordNo: freezed == recordNo
          ? _value.recordNo
          : recordNo 
              as String?,
      storeId: null == storeId
          ? _value.storeId
          : storeId 
              as int,
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      type: null == type
          ? _value.type
          : type 
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId 
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt 
              as String?,
      store: freezed == store
          ? _value.store
          : store 
              as InventoryStore?,
      product: freezed == product
          ? _value.product
          : product 
              as InventoryProduct?,
      operator: freezed == operator
          ? _value.operator
          : operator 
              as InventoryOperator?,
    ) as $Val);
  }
  @override
  @pragma('vm:prefer-inline')
  $InventoryStoreCopyWith<$Res>? get store {
    if (_value.store == null) {
      return null;
    }
    return $InventoryStoreCopyWith<$Res>(_value.store!, (value) {
      return _then(_value.copyWith(store: value) as $Val);
    });
  }
  @override
  @pragma('vm:prefer-inline')
  $InventoryProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }
    return $InventoryProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
  @override
  @pragma('vm:prefer-inline')
  $InventoryOperatorCopyWith<$Res>? get operator {
    if (_value.operator == null) {
      return null;
    }
    return $InventoryOperatorCopyWith<$Res>(_value.operator!, (value) {
      return _then(_value.copyWith(operator: value) as $Val);
    });
  }
}
abstract class _$$InventoryRecordImplCopyWith<$Res>
    implements $InventoryRecordCopyWith<$Res> {
  factory _$$InventoryRecordImplCopyWith(_$InventoryRecordImpl value,
          $Res Function(_$InventoryRecordImpl) then) =
      __$$InventoryRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'record_no') String? recordNo,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'product_id') int productId,
      int type,
      double quantity,
      String? unit,
      String? reason,
      String? remark,
      @JsonKey(name: 'operator_id') int? operatorId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      InventoryStore? store,
      InventoryProduct? product,
      InventoryOperator? operator});
  @override
  $InventoryStoreCopyWith<$Res>? get store;
  @override
  $InventoryProductCopyWith<$Res>? get product;
  @override
  $InventoryOperatorCopyWith<$Res>? get operator;
}
class __$$InventoryRecordImplCopyWithImpl<$Res>
    extends _$InventoryRecordCopyWithImpl<$Res, _$InventoryRecordImpl>
    implements _$$InventoryRecordImplCopyWith<$Res> {
  __$$InventoryRecordImplCopyWithImpl(
      _$InventoryRecordImpl _value, $Res Function(_$InventoryRecordImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recordNo = freezed,
    Object? storeId = null,
    Object? productId = null,
    Object? type = null,
    Object? quantity = null,
    Object? unit = freezed,
    Object? reason = freezed,
    Object? remark = freezed,
    Object? operatorId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? store = freezed,
    Object? product = freezed,
    Object? operator = freezed,
  }) {
    return _then(_$InventoryRecordImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      recordNo: freezed == recordNo
          ? _value.recordNo
          : recordNo 
              as String?,
      storeId: null == storeId
          ? _value.storeId
          : storeId 
              as int,
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      type: null == type
          ? _value.type
          : type 
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId 
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt 
              as String?,
      store: freezed == store
          ? _value.store
          : store 
              as InventoryStore?,
      product: freezed == product
          ? _value.product
          : product 
              as InventoryProduct?,
      operator: freezed == operator
          ? _value.operator
          : operator 
              as InventoryOperator?,
    ));
  }
}
@JsonSerializable()
class _$InventoryRecordImpl implements _InventoryRecord {
  const _$InventoryRecordImpl(
      {required this.id,
      @JsonKey(name: 'record_no') this.recordNo,
      @JsonKey(name: 'store_id') required this.storeId,
      @JsonKey(name: 'product_id') required this.productId,
      required this.type,
      required this.quantity,
      this.unit,
      this.reason,
      this.remark,
      @JsonKey(name: 'operator_id') this.operatorId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.store,
      this.product,
      this.operator});
  factory _$InventoryRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryRecordImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'record_no')
  final String? recordNo;
  @override
  @JsonKey(name: 'store_id')
  final int storeId;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  final int type;
  @override
  final double quantity;
  @override
  final String? unit;
  @override
  final String? reason;
  @override
  final String? remark;
  @override
  @JsonKey(name: 'operator_id')
  final int? operatorId;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final InventoryStore? store;
  @override
  final InventoryProduct? product;
  @override
  final InventoryOperator? operator;
  @override
  String toString() {
    return 'InventoryRecord(id: $id, recordNo: $recordNo, storeId: $storeId, productId: $productId, type: $type, quantity: $quantity, unit: $unit, reason: $reason, remark: $remark, operatorId: $operatorId, createdAt: $createdAt, updatedAt: $updatedAt, store: $store, product: $product, operator: $operator)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recordNo, recordNo) ||
                other.recordNo == recordNo) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.operatorId, operatorId) ||
                other.operatorId == operatorId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.store, store) || other.store == store) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.operator, operator) ||
                other.operator == operator));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      recordNo,
      storeId,
      productId,
      type,
      quantity,
      unit,
      reason,
      remark,
      operatorId,
      createdAt,
      updatedAt,
      store,
      product,
      operator);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryRecordImplCopyWith<_$InventoryRecordImpl> get copyWith =>
      __$$InventoryRecordImplCopyWithImpl<_$InventoryRecordImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryRecordImplToJson(
      this,
    );
  }
}
abstract class _InventoryRecord implements InventoryRecord {
  const factory _InventoryRecord(
      {required final int id,
      @JsonKey(name: 'record_no') final String? recordNo,
      @JsonKey(name: 'store_id') required final int storeId,
      @JsonKey(name: 'product_id') required final int productId,
      required final int type,
      required final double quantity,
      final String? unit,
      final String? reason,
      final String? remark,
      @JsonKey(name: 'operator_id') final int? operatorId,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final InventoryStore? store,
      final InventoryProduct? product,
      final InventoryOperator? operator}) = _$InventoryRecordImpl;
  factory _InventoryRecord.fromJson(Map<String, dynamic> json) =
      _$InventoryRecordImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'record_no')
  String? get recordNo;
  @override
  @JsonKey(name: 'store_id')
  int get storeId;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  int get type; 
  @override
  double get quantity;
  @override
  String? get unit;
  @override
  String? get reason;
  @override
  String? get remark;
  @override
  @JsonKey(name: 'operator_id')
  int? get operatorId;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt; 
  @override
  InventoryStore? get store;
  @override
  InventoryProduct? get product;
  @override
  InventoryOperator? get operator;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryRecordImplCopyWith<_$InventoryRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
InventoryStore _$InventoryStoreFromJson(Map<String, dynamic> json) {
  return _InventoryStore.fromJson(json);
}
mixin _$InventoryStore {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryStoreCopyWith<InventoryStore> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $InventoryStoreCopyWith<$Res> {
  factory $InventoryStoreCopyWith(
          InventoryStore value, $Res Function(InventoryStore) then) =
      _$InventoryStoreCopyWithImpl<$Res, InventoryStore>;
  @useResult
  $Res call({int id, String name});
}
class _$InventoryStoreCopyWithImpl<$Res, $Val extends InventoryStore>
    implements $InventoryStoreCopyWith<$Res> {
  _$InventoryStoreCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      name: null == name
          ? _value.name
          : name 
              as String,
    ) as $Val);
  }
}
abstract class _$$InventoryStoreImplCopyWith<$Res>
    implements $InventoryStoreCopyWith<$Res> {
  factory _$$InventoryStoreImplCopyWith(_$InventoryStoreImpl value,
          $Res Function(_$InventoryStoreImpl) then) =
      __$$InventoryStoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}
class __$$InventoryStoreImplCopyWithImpl<$Res>
    extends _$InventoryStoreCopyWithImpl<$Res, _$InventoryStoreImpl>
    implements _$$InventoryStoreImplCopyWith<$Res> {
  __$$InventoryStoreImplCopyWithImpl(
      _$InventoryStoreImpl _value, $Res Function(_$InventoryStoreImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$InventoryStoreImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      name: null == name
          ? _value.name
          : name 
              as String,
    ));
  }
}
@JsonSerializable()
class _$InventoryStoreImpl implements _InventoryStore {
  const _$InventoryStoreImpl({required this.id, required this.name});
  factory _$InventoryStoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryStoreImplFromJson(json);
  @override
  final int id;
  @override
  final String name;
  @override
  String toString() {
    return 'InventoryStore(id: $id, name: $name)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryStoreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryStoreImplCopyWith<_$InventoryStoreImpl> get copyWith =>
      __$$InventoryStoreImplCopyWithImpl<_$InventoryStoreImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryStoreImplToJson(
      this,
    );
  }
}
abstract class _InventoryStore implements InventoryStore {
  const factory _InventoryStore(
      {required final int id,
      required final String name}) = _$InventoryStoreImpl;
  factory _InventoryStore.fromJson(Map<String, dynamic> json) =
      _$InventoryStoreImpl.fromJson;
  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryStoreImplCopyWith<_$InventoryStoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
InventoryProduct _$InventoryProductFromJson(Map<String, dynamic> json) {
  return _InventoryProduct.fromJson(json);
}
mixin _$InventoryProduct {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryProductCopyWith<InventoryProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $InventoryProductCopyWith<$Res> {
  factory $InventoryProductCopyWith(
          InventoryProduct value, $Res Function(InventoryProduct) then) =
      _$InventoryProductCopyWithImpl<$Res, InventoryProduct>;
  @useResult
  $Res call({int id, String name});
}
class _$InventoryProductCopyWithImpl<$Res, $Val extends InventoryProduct>
    implements $InventoryProductCopyWith<$Res> {
  _$InventoryProductCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      name: null == name
          ? _value.name
          : name 
              as String,
    ) as $Val);
  }
}
abstract class _$$InventoryProductImplCopyWith<$Res>
    implements $InventoryProductCopyWith<$Res> {
  factory _$$InventoryProductImplCopyWith(_$InventoryProductImpl value,
          $Res Function(_$InventoryProductImpl) then) =
      __$$InventoryProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}
class __$$InventoryProductImplCopyWithImpl<$Res>
    extends _$InventoryProductCopyWithImpl<$Res, _$InventoryProductImpl>
    implements _$$InventoryProductImplCopyWith<$Res> {
  __$$InventoryProductImplCopyWithImpl(_$InventoryProductImpl _value,
      $Res Function(_$InventoryProductImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$InventoryProductImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      name: null == name
          ? _value.name
          : name 
              as String,
    ));
  }
}
@JsonSerializable()
class _$InventoryProductImpl implements _InventoryProduct {
  const _$InventoryProductImpl({required this.id, required this.name});
  factory _$InventoryProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryProductImplFromJson(json);
  @override
  final int id;
  @override
  final String name;
  @override
  String toString() {
    return 'InventoryProduct(id: $id, name: $name)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryProductImplCopyWith<_$InventoryProductImpl> get copyWith =>
      __$$InventoryProductImplCopyWithImpl<_$InventoryProductImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryProductImplToJson(
      this,
    );
  }
}
abstract class _InventoryProduct implements InventoryProduct {
  const factory _InventoryProduct(
      {required final int id,
      required final String name}) = _$InventoryProductImpl;
  factory _InventoryProduct.fromJson(Map<String, dynamic> json) =
      _$InventoryProductImpl.fromJson;
  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryProductImplCopyWith<_$InventoryProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
InventoryOperator _$InventoryOperatorFromJson(Map<String, dynamic> json) {
  return _InventoryOperator.fromJson(json);
}
mixin _$InventoryOperator {
  int get id => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryOperatorCopyWith<InventoryOperator> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $InventoryOperatorCopyWith<$Res> {
  factory $InventoryOperatorCopyWith(
          InventoryOperator value, $Res Function(InventoryOperator) then) =
      _$InventoryOperatorCopyWithImpl<$Res, InventoryOperator>;
  @useResult
  $Res call({int id, String? nickname});
}
class _$InventoryOperatorCopyWithImpl<$Res, $Val extends InventoryOperator>
    implements $InventoryOperatorCopyWith<$Res> {
  _$InventoryOperatorCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname 
              as String?,
    ) as $Val);
  }
}
abstract class _$$InventoryOperatorImplCopyWith<$Res>
    implements $InventoryOperatorCopyWith<$Res> {
  factory _$$InventoryOperatorImplCopyWith(_$InventoryOperatorImpl value,
          $Res Function(_$InventoryOperatorImpl) then) =
      __$$InventoryOperatorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? nickname});
}
class __$$InventoryOperatorImplCopyWithImpl<$Res>
    extends _$InventoryOperatorCopyWithImpl<$Res, _$InventoryOperatorImpl>
    implements _$$InventoryOperatorImplCopyWith<$Res> {
  __$$InventoryOperatorImplCopyWithImpl(_$InventoryOperatorImpl _value,
      $Res Function(_$InventoryOperatorImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = freezed,
  }) {
    return _then(_$InventoryOperatorImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$InventoryOperatorImpl implements _InventoryOperator {
  const _$InventoryOperatorImpl({required this.id, this.nickname});
  factory _$InventoryOperatorImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryOperatorImplFromJson(json);
  @override
  final int id;
  @override
  final String? nickname;
  @override
  String toString() {
    return 'InventoryOperator(id: $id, nickname: $nickname)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryOperatorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nickname);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryOperatorImplCopyWith<_$InventoryOperatorImpl> get copyWith =>
      __$$InventoryOperatorImplCopyWithImpl<_$InventoryOperatorImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryOperatorImplToJson(
      this,
    );
  }
}
abstract class _InventoryOperator implements InventoryOperator {
  const factory _InventoryOperator(
      {required final int id,
      final String? nickname}) = _$InventoryOperatorImpl;
  factory _InventoryOperator.fromJson(Map<String, dynamic> json) =
      _$InventoryOperatorImpl.fromJson;
  @override
  int get id;
  @override
  String? get nickname;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryOperatorImplCopyWith<_$InventoryOperatorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
InventoryOrder _$InventoryOrderFromJson(Map<String, dynamic> json) {
  return _InventoryOrder.fromJson(json);
}
mixin _$InventoryOrder {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_no')
  String? get orderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  int? get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_name')
  String? get storeName => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError; 
  String? get reason => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_quantity')
  double? get totalQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_count')
  int? get itemCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'operator_id')
  int? get operatorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'operator_name')
  String? get operatorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'operator_phone')
  String? get operatorPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError; 
  InventoryStore? get store => throw _privateConstructorUsedError;
  InventoryOperator? get operator => throw _privateConstructorUsedError;
  List<InventoryOrderItem> get items => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryOrderCopyWith<InventoryOrder> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $InventoryOrderCopyWith<$Res> {
  factory $InventoryOrderCopyWith(
          InventoryOrder value, $Res Function(InventoryOrder) then) =
      _$InventoryOrderCopyWithImpl<$Res, InventoryOrder>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'store_id') int? storeId,
      @JsonKey(name: 'store_name') String? storeName,
      int type,
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
      List<InventoryOrderItem> items});
  $InventoryStoreCopyWith<$Res>? get store;
  $InventoryOperatorCopyWith<$Res>? get operator;
}
class _$InventoryOrderCopyWithImpl<$Res, $Val extends InventoryOrder>
    implements $InventoryOrderCopyWith<$Res> {
  _$InventoryOrderCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNo = freezed,
    Object? storeId = freezed,
    Object? storeName = freezed,
    Object? type = null,
    Object? reason = freezed,
    Object? remark = freezed,
    Object? totalQuantity = freezed,
    Object? itemCount = freezed,
    Object? operatorId = freezed,
    Object? operatorName = freezed,
    Object? operatorPhone = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? store = freezed,
    Object? operator = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId 
              as int?,
      storeName: freezed == storeName
          ? _value.storeName
          : storeName 
              as String?,
      type: null == type
          ? _value.type
          : type 
              as int,
      reason: freezed == reason
          ? _value.reason
          : reason 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      totalQuantity: freezed == totalQuantity
          ? _value.totalQuantity
          : totalQuantity 
              as double?,
      itemCount: freezed == itemCount
          ? _value.itemCount
          : itemCount 
              as int?,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId 
              as int?,
      operatorName: freezed == operatorName
          ? _value.operatorName
          : operatorName 
              as String?,
      operatorPhone: freezed == operatorPhone
          ? _value.operatorPhone
          : operatorPhone 
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt 
              as String?,
      store: freezed == store
          ? _value.store
          : store 
              as InventoryStore?,
      operator: freezed == operator
          ? _value.operator
          : operator 
              as InventoryOperator?,
      items: null == items
          ? _value.items
          : items 
              as List<InventoryOrderItem>,
    ) as $Val);
  }
  @override
  @pragma('vm:prefer-inline')
  $InventoryStoreCopyWith<$Res>? get store {
    if (_value.store == null) {
      return null;
    }
    return $InventoryStoreCopyWith<$Res>(_value.store!, (value) {
      return _then(_value.copyWith(store: value) as $Val);
    });
  }
  @override
  @pragma('vm:prefer-inline')
  $InventoryOperatorCopyWith<$Res>? get operator {
    if (_value.operator == null) {
      return null;
    }
    return $InventoryOperatorCopyWith<$Res>(_value.operator!, (value) {
      return _then(_value.copyWith(operator: value) as $Val);
    });
  }
}
abstract class _$$InventoryOrderImplCopyWith<$Res>
    implements $InventoryOrderCopyWith<$Res> {
  factory _$$InventoryOrderImplCopyWith(_$InventoryOrderImpl value,
          $Res Function(_$InventoryOrderImpl) then) =
      __$$InventoryOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'store_id') int? storeId,
      @JsonKey(name: 'store_name') String? storeName,
      int type,
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
      List<InventoryOrderItem> items});
  @override
  $InventoryStoreCopyWith<$Res>? get store;
  @override
  $InventoryOperatorCopyWith<$Res>? get operator;
}
class __$$InventoryOrderImplCopyWithImpl<$Res>
    extends _$InventoryOrderCopyWithImpl<$Res, _$InventoryOrderImpl>
    implements _$$InventoryOrderImplCopyWith<$Res> {
  __$$InventoryOrderImplCopyWithImpl(
      _$InventoryOrderImpl _value, $Res Function(_$InventoryOrderImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNo = freezed,
    Object? storeId = freezed,
    Object? storeName = freezed,
    Object? type = null,
    Object? reason = freezed,
    Object? remark = freezed,
    Object? totalQuantity = freezed,
    Object? itemCount = freezed,
    Object? operatorId = freezed,
    Object? operatorName = freezed,
    Object? operatorPhone = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? store = freezed,
    Object? operator = freezed,
    Object? items = null,
  }) {
    return _then(_$InventoryOrderImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId 
              as int?,
      storeName: freezed == storeName
          ? _value.storeName
          : storeName 
              as String?,
      type: null == type
          ? _value.type
          : type 
              as int,
      reason: freezed == reason
          ? _value.reason
          : reason 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      totalQuantity: freezed == totalQuantity
          ? _value.totalQuantity
          : totalQuantity 
              as double?,
      itemCount: freezed == itemCount
          ? _value.itemCount
          : itemCount 
              as int?,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId 
              as int?,
      operatorName: freezed == operatorName
          ? _value.operatorName
          : operatorName 
              as String?,
      operatorPhone: freezed == operatorPhone
          ? _value.operatorPhone
          : operatorPhone 
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt 
              as String?,
      store: freezed == store
          ? _value.store
          : store 
              as InventoryStore?,
      operator: freezed == operator
          ? _value.operator
          : operator 
              as InventoryOperator?,
      items: null == items
          ? _value._items
          : items 
              as List<InventoryOrderItem>,
    ));
  }
}
@JsonSerializable()
class _$InventoryOrderImpl implements _InventoryOrder {
  const _$InventoryOrderImpl(
      {required this.id,
      @JsonKey(name: 'order_no') this.orderNo,
      @JsonKey(name: 'store_id') this.storeId,
      @JsonKey(name: 'store_name') this.storeName,
      required this.type,
      this.reason,
      this.remark,
      @JsonKey(name: 'total_quantity') this.totalQuantity,
      @JsonKey(name: 'item_count') this.itemCount,
      @JsonKey(name: 'operator_id') this.operatorId,
      @JsonKey(name: 'operator_name') this.operatorName,
      @JsonKey(name: 'operator_phone') this.operatorPhone,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.store,
      this.operator,
      final List<InventoryOrderItem> items = const []})
      : _items = items;
  factory _$InventoryOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryOrderImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'order_no')
  final String? orderNo;
  @override
  @JsonKey(name: 'store_id')
  final int? storeId;
  @override
  @JsonKey(name: 'store_name')
  final String? storeName;
  @override
  final int type;
  @override
  final String? reason;
  @override
  final String? remark;
  @override
  @JsonKey(name: 'total_quantity')
  final double? totalQuantity;
  @override
  @JsonKey(name: 'item_count')
  final int? itemCount;
  @override
  @JsonKey(name: 'operator_id')
  final int? operatorId;
  @override
  @JsonKey(name: 'operator_name')
  final String? operatorName;
  @override
  @JsonKey(name: 'operator_phone')
  final String? operatorPhone;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final InventoryStore? store;
  @override
  final InventoryOperator? operator;
  final List<InventoryOrderItem> _items;
  @override
  @JsonKey()
  List<InventoryOrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    return EqualUnmodifiableListView(_items);
  }
  @override
  String toString() {
    return 'InventoryOrder(id: $id, orderNo: $orderNo, storeId: $storeId, storeName: $storeName, type: $type, reason: $reason, remark: $remark, totalQuantity: $totalQuantity, itemCount: $itemCount, operatorId: $operatorId, operatorName: $operatorName, operatorPhone: $operatorPhone, createdAt: $createdAt, updatedAt: $updatedAt, store: $store, operator: $operator, items: $items)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.operatorId, operatorId) ||
                other.operatorId == operatorId) &&
            (identical(other.operatorName, operatorName) ||
                other.operatorName == operatorName) &&
            (identical(other.operatorPhone, operatorPhone) ||
                other.operatorPhone == operatorPhone) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.store, store) || other.store == store) &&
            (identical(other.operator, operator) ||
                other.operator == operator) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderNo,
      storeId,
      storeName,
      type,
      reason,
      remark,
      totalQuantity,
      itemCount,
      operatorId,
      operatorName,
      operatorPhone,
      createdAt,
      updatedAt,
      store,
      operator,
      const DeepCollectionEquality().hash(_items));
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryOrderImplCopyWith<_$InventoryOrderImpl> get copyWith =>
      __$$InventoryOrderImplCopyWithImpl<_$InventoryOrderImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryOrderImplToJson(
      this,
    );
  }
}
abstract class _InventoryOrder implements InventoryOrder {
  const factory _InventoryOrder(
      {required final int id,
      @JsonKey(name: 'order_no') final String? orderNo,
      @JsonKey(name: 'store_id') final int? storeId,
      @JsonKey(name: 'store_name') final String? storeName,
      required final int type,
      final String? reason,
      final String? remark,
      @JsonKey(name: 'total_quantity') final double? totalQuantity,
      @JsonKey(name: 'item_count') final int? itemCount,
      @JsonKey(name: 'operator_id') final int? operatorId,
      @JsonKey(name: 'operator_name') final String? operatorName,
      @JsonKey(name: 'operator_phone') final String? operatorPhone,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final InventoryStore? store,
      final InventoryOperator? operator,
      final List<InventoryOrderItem> items}) = _$InventoryOrderImpl;
  factory _InventoryOrder.fromJson(Map<String, dynamic> json) =
      _$InventoryOrderImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'order_no')
  String? get orderNo;
  @override
  @JsonKey(name: 'store_id')
  int? get storeId;
  @override
  @JsonKey(name: 'store_name')
  String? get storeName;
  @override
  int get type; 
  @override
  String? get reason;
  @override
  String? get remark;
  @override
  @JsonKey(name: 'total_quantity')
  double? get totalQuantity;
  @override
  @JsonKey(name: 'item_count')
  int? get itemCount;
  @override
  @JsonKey(name: 'operator_id')
  int? get operatorId;
  @override
  @JsonKey(name: 'operator_name')
  String? get operatorName;
  @override
  @JsonKey(name: 'operator_phone')
  String? get operatorPhone;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt; 
  @override
  InventoryStore? get store;
  @override
  InventoryOperator? get operator;
  @override
  List<InventoryOrderItem> get items;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryOrderImplCopyWith<_$InventoryOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
InventoryOrderItem _$InventoryOrderItemFromJson(Map<String, dynamic> json) {
  return _InventoryOrderItem.fromJson(json);
}
mixin _$InventoryOrderItem {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_id')
  int? get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'production_date')
  String? get productionDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry_date')
  String? get expiryDate => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError; 
  InventoryProduct? get product => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryOrderItemCopyWith<InventoryOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $InventoryOrderItemCopyWith<$Res> {
  factory $InventoryOrderItemCopyWith(
          InventoryOrderItem value, $Res Function(InventoryOrderItem) then) =
      _$InventoryOrderItemCopyWithImpl<$Res, InventoryOrderItem>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'order_id') int? orderId,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'product_name') String? productName,
      double quantity,
      String? unit,
      @JsonKey(name: 'production_date') String? productionDate,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      String? remark,
      InventoryProduct? product});
  $InventoryProductCopyWith<$Res>? get product;
}
class _$InventoryOrderItemCopyWithImpl<$Res, $Val extends InventoryOrderItem>
    implements $InventoryOrderItemCopyWith<$Res> {
  _$InventoryOrderItemCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = freezed,
    Object? productId = null,
    Object? productName = freezed,
    Object? quantity = null,
    Object? unit = freezed,
    Object? productionDate = freezed,
    Object? expiryDate = freezed,
    Object? remark = freezed,
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId 
              as int?,
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      productName: freezed == productName
          ? _value.productName
          : productName 
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate 
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      product: freezed == product
          ? _value.product
          : product 
              as InventoryProduct?,
    ) as $Val);
  }
  @override
  @pragma('vm:prefer-inline')
  $InventoryProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }
    return $InventoryProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}
abstract class _$$InventoryOrderItemImplCopyWith<$Res>
    implements $InventoryOrderItemCopyWith<$Res> {
  factory _$$InventoryOrderItemImplCopyWith(_$InventoryOrderItemImpl value,
          $Res Function(_$InventoryOrderItemImpl) then) =
      __$$InventoryOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'order_id') int? orderId,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'product_name') String? productName,
      double quantity,
      String? unit,
      @JsonKey(name: 'production_date') String? productionDate,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      String? remark,
      InventoryProduct? product});
  @override
  $InventoryProductCopyWith<$Res>? get product;
}
class __$$InventoryOrderItemImplCopyWithImpl<$Res>
    extends _$InventoryOrderItemCopyWithImpl<$Res, _$InventoryOrderItemImpl>
    implements _$$InventoryOrderItemImplCopyWith<$Res> {
  __$$InventoryOrderItemImplCopyWithImpl(_$InventoryOrderItemImpl _value,
      $Res Function(_$InventoryOrderItemImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = freezed,
    Object? productId = null,
    Object? productName = freezed,
    Object? quantity = null,
    Object? unit = freezed,
    Object? productionDate = freezed,
    Object? expiryDate = freezed,
    Object? remark = freezed,
    Object? product = freezed,
  }) {
    return _then(_$InventoryOrderItemImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId 
              as int?,
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      productName: freezed == productName
          ? _value.productName
          : productName 
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate 
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      product: freezed == product
          ? _value.product
          : product 
              as InventoryProduct?,
    ));
  }
}
@JsonSerializable()
class _$InventoryOrderItemImpl implements _InventoryOrderItem {
  const _$InventoryOrderItemImpl(
      {required this.id,
      @JsonKey(name: 'order_id') this.orderId,
      @JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'product_name') this.productName,
      required this.quantity,
      this.unit,
      @JsonKey(name: 'production_date') this.productionDate,
      @JsonKey(name: 'expiry_date') this.expiryDate,
      this.remark,
      this.product});
  factory _$InventoryOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryOrderItemImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'order_id')
  final int? orderId;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  final double quantity;
  @override
  final String? unit;
  @override
  @JsonKey(name: 'production_date')
  final String? productionDate;
  @override
  @JsonKey(name: 'expiry_date')
  final String? expiryDate;
  @override
  final String? remark;
  @override
  final InventoryProduct? product;
  @override
  String toString() {
    return 'InventoryOrderItem(id: $id, orderId: $orderId, productId: $productId, productName: $productName, quantity: $quantity, unit: $unit, productionDate: $productionDate, expiryDate: $expiryDate, remark: $remark, product: $product)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryOrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.product, product) || other.product == product));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, orderId, productId,
      productName, quantity, unit, productionDate, expiryDate, remark, product);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryOrderItemImplCopyWith<_$InventoryOrderItemImpl> get copyWith =>
      __$$InventoryOrderItemImplCopyWithImpl<_$InventoryOrderItemImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryOrderItemImplToJson(
      this,
    );
  }
}
abstract class _InventoryOrderItem implements InventoryOrderItem {
  const factory _InventoryOrderItem(
      {required final int id,
      @JsonKey(name: 'order_id') final int? orderId,
      @JsonKey(name: 'product_id') required final int productId,
      @JsonKey(name: 'product_name') final String? productName,
      required final double quantity,
      final String? unit,
      @JsonKey(name: 'production_date') final String? productionDate,
      @JsonKey(name: 'expiry_date') final String? expiryDate,
      final String? remark,
      final InventoryProduct? product}) = _$InventoryOrderItemImpl;
  factory _InventoryOrderItem.fromJson(Map<String, dynamic> json) =
      _$InventoryOrderItemImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'order_id')
  int? get orderId;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  double get quantity;
  @override
  String? get unit;
  @override
  @JsonKey(name: 'production_date')
  String? get productionDate;
  @override
  @JsonKey(name: 'expiry_date')
  String? get expiryDate;
  @override
  String? get remark; 
  @override
  InventoryProduct? get product;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryOrderItemImplCopyWith<_$InventoryOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
CreateInventoryOrderRequest _$CreateInventoryOrderRequestFromJson(
    Map<String, dynamic> json) {
  return _CreateInventoryOrderRequest.fromJson(json);
}
mixin _$CreateInventoryOrderRequest {
  int get type => throw _privateConstructorUsedError; 
  String get reason => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  List<CreateInventoryOrderItem> get items =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateInventoryOrderRequestCopyWith<CreateInventoryOrderRequest>
      get copyWith => throw _privateConstructorUsedError;
}
abstract class $CreateInventoryOrderRequestCopyWith<$Res> {
  factory $CreateInventoryOrderRequestCopyWith(
          CreateInventoryOrderRequest value,
          $Res Function(CreateInventoryOrderRequest) then) =
      _$CreateInventoryOrderRequestCopyWithImpl<$Res,
          CreateInventoryOrderRequest>;
  @useResult
  $Res call(
      {int type,
      String reason,
      String? remark,
      List<CreateInventoryOrderItem> items});
}
class _$CreateInventoryOrderRequestCopyWithImpl<$Res,
        $Val extends CreateInventoryOrderRequest>
    implements $CreateInventoryOrderRequestCopyWith<$Res> {
  _$CreateInventoryOrderRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? reason = null,
    Object? remark = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type 
              as int,
      reason: null == reason
          ? _value.reason
          : reason 
              as String,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      items: null == items
          ? _value.items
          : items 
              as List<CreateInventoryOrderItem>,
    ) as $Val);
  }
}
abstract class _$$CreateInventoryOrderRequestImplCopyWith<$Res>
    implements $CreateInventoryOrderRequestCopyWith<$Res> {
  factory _$$CreateInventoryOrderRequestImplCopyWith(
          _$CreateInventoryOrderRequestImpl value,
          $Res Function(_$CreateInventoryOrderRequestImpl) then) =
      __$$CreateInventoryOrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int type,
      String reason,
      String? remark,
      List<CreateInventoryOrderItem> items});
}
class __$$CreateInventoryOrderRequestImplCopyWithImpl<$Res>
    extends _$CreateInventoryOrderRequestCopyWithImpl<$Res,
        _$CreateInventoryOrderRequestImpl>
    implements _$$CreateInventoryOrderRequestImplCopyWith<$Res> {
  __$$CreateInventoryOrderRequestImplCopyWithImpl(
      _$CreateInventoryOrderRequestImpl _value,
      $Res Function(_$CreateInventoryOrderRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? reason = null,
    Object? remark = freezed,
    Object? items = null,
  }) {
    return _then(_$CreateInventoryOrderRequestImpl(
      type: null == type
          ? _value.type
          : type 
              as int,
      reason: null == reason
          ? _value.reason
          : reason 
              as String,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      items: null == items
          ? _value._items
          : items 
              as List<CreateInventoryOrderItem>,
    ));
  }
}
@JsonSerializable()
class _$CreateInventoryOrderRequestImpl
    implements _CreateInventoryOrderRequest {
  const _$CreateInventoryOrderRequestImpl(
      {required this.type,
      required this.reason,
      this.remark,
      required final List<CreateInventoryOrderItem> items})
      : _items = items;
  factory _$CreateInventoryOrderRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateInventoryOrderRequestImplFromJson(json);
  @override
  final int type;
  @override
  final String reason;
  @override
  final String? remark;
  final List<CreateInventoryOrderItem> _items;
  @override
  List<CreateInventoryOrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    return EqualUnmodifiableListView(_items);
  }
  @override
  String toString() {
    return 'CreateInventoryOrderRequest(type: $type, reason: $reason, remark: $remark, items: $items)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateInventoryOrderRequestImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, reason, remark,
      const DeepCollectionEquality().hash(_items));
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateInventoryOrderRequestImplCopyWith<_$CreateInventoryOrderRequestImpl>
      get copyWith => __$$CreateInventoryOrderRequestImplCopyWithImpl<
          _$CreateInventoryOrderRequestImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$CreateInventoryOrderRequestImplToJson(
      this,
    );
  }
}
abstract class _CreateInventoryOrderRequest
    implements CreateInventoryOrderRequest {
  const factory _CreateInventoryOrderRequest(
          {required final int type,
          required final String reason,
          final String? remark,
          required final List<CreateInventoryOrderItem> items}) =
      _$CreateInventoryOrderRequestImpl;
  factory _CreateInventoryOrderRequest.fromJson(Map<String, dynamic> json) =
      _$CreateInventoryOrderRequestImpl.fromJson;
  @override
  int get type; 
  @override
  String get reason;
  @override
  String? get remark;
  @override
  List<CreateInventoryOrderItem> get items;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateInventoryOrderRequestImplCopyWith<_$CreateInventoryOrderRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
CreateInventoryOrderItem _$CreateInventoryOrderItemFromJson(
    Map<String, dynamic> json) {
  return _CreateInventoryOrderItem.fromJson(json);
}
mixin _$CreateInventoryOrderItem {
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'production_date')
  String? get productionDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry_date')
  String? get expiryDate => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateInventoryOrderItemCopyWith<CreateInventoryOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $CreateInventoryOrderItemCopyWith<$Res> {
  factory $CreateInventoryOrderItemCopyWith(CreateInventoryOrderItem value,
          $Res Function(CreateInventoryOrderItem) then) =
      _$CreateInventoryOrderItemCopyWithImpl<$Res, CreateInventoryOrderItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int productId,
      double quantity,
      @JsonKey(name: 'production_date') String? productionDate,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      String? remark});
}
class _$CreateInventoryOrderItemCopyWithImpl<$Res,
        $Val extends CreateInventoryOrderItem>
    implements $CreateInventoryOrderItemCopyWith<$Res> {
  _$CreateInventoryOrderItemCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? productionDate = freezed,
    Object? expiryDate = freezed,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate 
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ) as $Val);
  }
}
abstract class _$$CreateInventoryOrderItemImplCopyWith<$Res>
    implements $CreateInventoryOrderItemCopyWith<$Res> {
  factory _$$CreateInventoryOrderItemImplCopyWith(
          _$CreateInventoryOrderItemImpl value,
          $Res Function(_$CreateInventoryOrderItemImpl) then) =
      __$$CreateInventoryOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int productId,
      double quantity,
      @JsonKey(name: 'production_date') String? productionDate,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      String? remark});
}
class __$$CreateInventoryOrderItemImplCopyWithImpl<$Res>
    extends _$CreateInventoryOrderItemCopyWithImpl<$Res,
        _$CreateInventoryOrderItemImpl>
    implements _$$CreateInventoryOrderItemImplCopyWith<$Res> {
  __$$CreateInventoryOrderItemImplCopyWithImpl(
      _$CreateInventoryOrderItemImpl _value,
      $Res Function(_$CreateInventoryOrderItemImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? productionDate = freezed,
    Object? expiryDate = freezed,
    Object? remark = freezed,
  }) {
    return _then(_$CreateInventoryOrderItemImpl(
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate 
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$CreateInventoryOrderItemImpl implements _CreateInventoryOrderItem {
  const _$CreateInventoryOrderItemImpl(
      {@JsonKey(name: 'product_id') required this.productId,
      required this.quantity,
      @JsonKey(name: 'production_date') this.productionDate,
      @JsonKey(name: 'expiry_date') this.expiryDate,
      this.remark});
  factory _$CreateInventoryOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateInventoryOrderItemImplFromJson(json);
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  final double quantity;
  @override
  @JsonKey(name: 'production_date')
  final String? productionDate;
  @override
  @JsonKey(name: 'expiry_date')
  final String? expiryDate;
  @override
  final String? remark;
  @override
  String toString() {
    return 'CreateInventoryOrderItem(productId: $productId, quantity: $quantity, productionDate: $productionDate, expiryDate: $expiryDate, remark: $remark)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateInventoryOrderItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.remark, remark) || other.remark == remark));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, productId, quantity, productionDate, expiryDate, remark);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateInventoryOrderItemImplCopyWith<_$CreateInventoryOrderItemImpl>
      get copyWith => __$$CreateInventoryOrderItemImplCopyWithImpl<
          _$CreateInventoryOrderItemImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$CreateInventoryOrderItemImplToJson(
      this,
    );
  }
}
abstract class _CreateInventoryOrderItem implements CreateInventoryOrderItem {
  const factory _CreateInventoryOrderItem(
      {@JsonKey(name: 'product_id') required final int productId,
      required final double quantity,
      @JsonKey(name: 'production_date') final String? productionDate,
      @JsonKey(name: 'expiry_date') final String? expiryDate,
      final String? remark}) = _$CreateInventoryOrderItemImpl;
  factory _CreateInventoryOrderItem.fromJson(Map<String, dynamic> json) =
      _$CreateInventoryOrderItemImpl.fromJson;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  double get quantity;
  @override
  @JsonKey(name: 'production_date')
  String? get productionDate;
  @override
  @JsonKey(name: 'expiry_date')
  String? get expiryDate;
  @override
  String? get remark;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateInventoryOrderItemImplCopyWith<_$CreateInventoryOrderItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
CreateInventoryRecordRequest _$CreateInventoryRecordRequestFromJson(
    Map<String, dynamic> json) {
  return _CreateInventoryRecordRequest.fromJson(json);
}
mixin _$CreateInventoryRecordRequest {
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError; 
  double get quantity => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'production_date')
  String? get productionDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry_date')
  String? get expiryDate => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateInventoryRecordRequestCopyWith<CreateInventoryRecordRequest>
      get copyWith => throw _privateConstructorUsedError;
}
abstract class $CreateInventoryRecordRequestCopyWith<$Res> {
  factory $CreateInventoryRecordRequestCopyWith(
          CreateInventoryRecordRequest value,
          $Res Function(CreateInventoryRecordRequest) then) =
      _$CreateInventoryRecordRequestCopyWithImpl<$Res,
          CreateInventoryRecordRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int productId,
      int type,
      double quantity,
      String reason,
      String? remark,
      @JsonKey(name: 'production_date') String? productionDate,
      @JsonKey(name: 'expiry_date') String? expiryDate});
}
class _$CreateInventoryRecordRequestCopyWithImpl<$Res,
        $Val extends CreateInventoryRecordRequest>
    implements $CreateInventoryRecordRequestCopyWith<$Res> {
  _$CreateInventoryRecordRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? type = null,
    Object? quantity = null,
    Object? reason = null,
    Object? remark = freezed,
    Object? productionDate = freezed,
    Object? expiryDate = freezed,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      type: null == type
          ? _value.type
          : type 
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      reason: null == reason
          ? _value.reason
          : reason 
              as String,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate 
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate 
              as String?,
    ) as $Val);
  }
}
abstract class _$$CreateInventoryRecordRequestImplCopyWith<$Res>
    implements $CreateInventoryRecordRequestCopyWith<$Res> {
  factory _$$CreateInventoryRecordRequestImplCopyWith(
          _$CreateInventoryRecordRequestImpl value,
          $Res Function(_$CreateInventoryRecordRequestImpl) then) =
      __$$CreateInventoryRecordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int productId,
      int type,
      double quantity,
      String reason,
      String? remark,
      @JsonKey(name: 'production_date') String? productionDate,
      @JsonKey(name: 'expiry_date') String? expiryDate});
}
class __$$CreateInventoryRecordRequestImplCopyWithImpl<$Res>
    extends _$CreateInventoryRecordRequestCopyWithImpl<$Res,
        _$CreateInventoryRecordRequestImpl>
    implements _$$CreateInventoryRecordRequestImplCopyWith<$Res> {
  __$$CreateInventoryRecordRequestImplCopyWithImpl(
      _$CreateInventoryRecordRequestImpl _value,
      $Res Function(_$CreateInventoryRecordRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? type = null,
    Object? quantity = null,
    Object? reason = null,
    Object? remark = freezed,
    Object? productionDate = freezed,
    Object? expiryDate = freezed,
  }) {
    return _then(_$CreateInventoryRecordRequestImpl(
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      type: null == type
          ? _value.type
          : type 
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      reason: null == reason
          ? _value.reason
          : reason 
              as String,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate 
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$CreateInventoryRecordRequestImpl
    implements _CreateInventoryRecordRequest {
  const _$CreateInventoryRecordRequestImpl(
      {@JsonKey(name: 'product_id') required this.productId,
      required this.type,
      required this.quantity,
      required this.reason,
      this.remark,
      @JsonKey(name: 'production_date') this.productionDate,
      @JsonKey(name: 'expiry_date') this.expiryDate});
  factory _$CreateInventoryRecordRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateInventoryRecordRequestImplFromJson(json);
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  final int type;
  @override
  final double quantity;
  @override
  final String reason;
  @override
  final String? remark;
  @override
  @JsonKey(name: 'production_date')
  final String? productionDate;
  @override
  @JsonKey(name: 'expiry_date')
  final String? expiryDate;
  @override
  String toString() {
    return 'CreateInventoryRecordRequest(productId: $productId, type: $type, quantity: $quantity, reason: $reason, remark: $remark, productionDate: $productionDate, expiryDate: $expiryDate)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateInventoryRecordRequestImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, productId, type, quantity,
      reason, remark, productionDate, expiryDate);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateInventoryRecordRequestImplCopyWith<
          _$CreateInventoryRecordRequestImpl>
      get copyWith => __$$CreateInventoryRecordRequestImplCopyWithImpl<
          _$CreateInventoryRecordRequestImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$CreateInventoryRecordRequestImplToJson(
      this,
    );
  }
}
abstract class _CreateInventoryRecordRequest
    implements CreateInventoryRecordRequest {
  const factory _CreateInventoryRecordRequest(
          {@JsonKey(name: 'product_id') required final int productId,
          required final int type,
          required final double quantity,
          required final String reason,
          final String? remark,
          @JsonKey(name: 'production_date') final String? productionDate,
          @JsonKey(name: 'expiry_date') final String? expiryDate}) =
      _$CreateInventoryRecordRequestImpl;
  factory _CreateInventoryRecordRequest.fromJson(Map<String, dynamic> json) =
      _$CreateInventoryRecordRequestImpl.fromJson;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  int get type; 
  @override
  double get quantity;
  @override
  String get reason;
  @override
  String? get remark;
  @override
  @JsonKey(name: 'production_date')
  String? get productionDate;
  @override
  @JsonKey(name: 'expiry_date')
  String? get expiryDate;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateInventoryRecordRequestImplCopyWith<
          _$CreateInventoryRecordRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
