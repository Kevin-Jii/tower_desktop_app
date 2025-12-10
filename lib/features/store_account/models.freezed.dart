part of 'models.dart';
T _$identity<T>(T value) => value;
final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https:
StoreAccount _$StoreAccountFromJson(Map<String, dynamic> json) {
  return _StoreAccount.fromJson(json);
}
mixin _$StoreAccount {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_no')
  String? get accountNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  int? get storeId => throw _privateConstructorUsedError;
  String? get channel => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_no')
  String? get orderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_count')
  int get itemCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tag_code')
  String? get tagCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'tag_name')
  String? get tagName => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'operator_id')
  int? get operatorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_date')
  String? get accountDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  List<StoreAccountItem> get items => throw _privateConstructorUsedError;
  StoreAccountStore? get store => throw _privateConstructorUsedError;
  StoreAccountOperator? get operator => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreAccountCopyWith<StoreAccount> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $StoreAccountCopyWith<$Res> {
  factory $StoreAccountCopyWith(
          StoreAccount value, $Res Function(StoreAccount) then) =
      _$StoreAccountCopyWithImpl<$Res, StoreAccount>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'account_no') String? accountNo,
      @JsonKey(name: 'store_id') int? storeId,
      String? channel,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'item_count') int itemCount,
      @JsonKey(name: 'tag_code') String? tagCode,
      @JsonKey(name: 'tag_name') String? tagName,
      String? remark,
      @JsonKey(name: 'operator_id') int? operatorId,
      @JsonKey(name: 'account_date') String? accountDate,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      List<StoreAccountItem> items,
      StoreAccountStore? store,
      StoreAccountOperator? operator});
  $StoreAccountStoreCopyWith<$Res>? get store;
  $StoreAccountOperatorCopyWith<$Res>? get operator;
}
class _$StoreAccountCopyWithImpl<$Res, $Val extends StoreAccount>
    implements $StoreAccountCopyWith<$Res> {
  _$StoreAccountCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNo = freezed,
    Object? storeId = freezed,
    Object? channel = freezed,
    Object? orderNo = freezed,
    Object? totalAmount = null,
    Object? itemCount = null,
    Object? tagCode = freezed,
    Object? tagName = freezed,
    Object? remark = freezed,
    Object? operatorId = freezed,
    Object? accountDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? items = null,
    Object? store = freezed,
    Object? operator = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      accountNo: freezed == accountNo
          ? _value.accountNo
          : accountNo 
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId 
              as int?,
      channel: freezed == channel
          ? _value.channel
          : channel 
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount 
              as double,
      itemCount: null == itemCount
          ? _value.itemCount
          : itemCount 
              as int,
      tagCode: freezed == tagCode
          ? _value.tagCode
          : tagCode 
              as String?,
      tagName: freezed == tagName
          ? _value.tagName
          : tagName 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId 
              as int?,
      accountDate: freezed == accountDate
          ? _value.accountDate
          : accountDate 
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt 
              as String?,
      items: null == items
          ? _value.items
          : items 
              as List<StoreAccountItem>,
      store: freezed == store
          ? _value.store
          : store 
              as StoreAccountStore?,
      operator: freezed == operator
          ? _value.operator
          : operator 
              as StoreAccountOperator?,
    ) as $Val);
  }
  @override
  @pragma('vm:prefer-inline')
  $StoreAccountStoreCopyWith<$Res>? get store {
    if (_value.store == null) {
      return null;
    }
    return $StoreAccountStoreCopyWith<$Res>(_value.store!, (value) {
      return _then(_value.copyWith(store: value) as $Val);
    });
  }
  @override
  @pragma('vm:prefer-inline')
  $StoreAccountOperatorCopyWith<$Res>? get operator {
    if (_value.operator == null) {
      return null;
    }
    return $StoreAccountOperatorCopyWith<$Res>(_value.operator!, (value) {
      return _then(_value.copyWith(operator: value) as $Val);
    });
  }
}
abstract class _$$StoreAccountImplCopyWith<$Res>
    implements $StoreAccountCopyWith<$Res> {
  factory _$$StoreAccountImplCopyWith(
          _$StoreAccountImpl value, $Res Function(_$StoreAccountImpl) then) =
      __$$StoreAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'account_no') String? accountNo,
      @JsonKey(name: 'store_id') int? storeId,
      String? channel,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'item_count') int itemCount,
      @JsonKey(name: 'tag_code') String? tagCode,
      @JsonKey(name: 'tag_name') String? tagName,
      String? remark,
      @JsonKey(name: 'operator_id') int? operatorId,
      @JsonKey(name: 'account_date') String? accountDate,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      List<StoreAccountItem> items,
      StoreAccountStore? store,
      StoreAccountOperator? operator});
  @override
  $StoreAccountStoreCopyWith<$Res>? get store;
  @override
  $StoreAccountOperatorCopyWith<$Res>? get operator;
}
class __$$StoreAccountImplCopyWithImpl<$Res>
    extends _$StoreAccountCopyWithImpl<$Res, _$StoreAccountImpl>
    implements _$$StoreAccountImplCopyWith<$Res> {
  __$$StoreAccountImplCopyWithImpl(
      _$StoreAccountImpl _value, $Res Function(_$StoreAccountImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNo = freezed,
    Object? storeId = freezed,
    Object? channel = freezed,
    Object? orderNo = freezed,
    Object? totalAmount = null,
    Object? itemCount = null,
    Object? tagCode = freezed,
    Object? tagName = freezed,
    Object? remark = freezed,
    Object? operatorId = freezed,
    Object? accountDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? items = null,
    Object? store = freezed,
    Object? operator = freezed,
  }) {
    return _then(_$StoreAccountImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      accountNo: freezed == accountNo
          ? _value.accountNo
          : accountNo 
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId 
              as int?,
      channel: freezed == channel
          ? _value.channel
          : channel 
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount 
              as double,
      itemCount: null == itemCount
          ? _value.itemCount
          : itemCount 
              as int,
      tagCode: freezed == tagCode
          ? _value.tagCode
          : tagCode 
              as String?,
      tagName: freezed == tagName
          ? _value.tagName
          : tagName 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId 
              as int?,
      accountDate: freezed == accountDate
          ? _value.accountDate
          : accountDate 
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt 
              as String?,
      items: null == items
          ? _value._items
          : items 
              as List<StoreAccountItem>,
      store: freezed == store
          ? _value.store
          : store 
              as StoreAccountStore?,
      operator: freezed == operator
          ? _value.operator
          : operator 
              as StoreAccountOperator?,
    ));
  }
}
@JsonSerializable()
class _$StoreAccountImpl extends _StoreAccount {
  const _$StoreAccountImpl(
      {required this.id,
      @JsonKey(name: 'account_no') this.accountNo,
      @JsonKey(name: 'store_id') this.storeId,
      this.channel,
      @JsonKey(name: 'order_no') this.orderNo,
      @JsonKey(name: 'total_amount') this.totalAmount = 0.0,
      @JsonKey(name: 'item_count') this.itemCount = 0,
      @JsonKey(name: 'tag_code') this.tagCode,
      @JsonKey(name: 'tag_name') this.tagName,
      this.remark,
      @JsonKey(name: 'operator_id') this.operatorId,
      @JsonKey(name: 'account_date') this.accountDate,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      final List<StoreAccountItem> items = const [],
      this.store,
      this.operator})
      : _items = items,
        super._();
  factory _$StoreAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreAccountImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'account_no')
  final String? accountNo;
  @override
  @JsonKey(name: 'store_id')
  final int? storeId;
  @override
  final String? channel;
  @override
  @JsonKey(name: 'order_no')
  final String? orderNo;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  @JsonKey(name: 'item_count')
  final int itemCount;
  @override
  @JsonKey(name: 'tag_code')
  final String? tagCode;
  @override
  @JsonKey(name: 'tag_name')
  final String? tagName;
  @override
  final String? remark;
  @override
  @JsonKey(name: 'operator_id')
  final int? operatorId;
  @override
  @JsonKey(name: 'account_date')
  final String? accountDate;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final List<StoreAccountItem> _items;
  @override
  @JsonKey()
  List<StoreAccountItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    return EqualUnmodifiableListView(_items);
  }
  @override
  final StoreAccountStore? store;
  @override
  final StoreAccountOperator? operator;
  @override
  String toString() {
    return 'StoreAccount(id: $id, accountNo: $accountNo, storeId: $storeId, channel: $channel, orderNo: $orderNo, totalAmount: $totalAmount, itemCount: $itemCount, tagCode: $tagCode, tagName: $tagName, remark: $remark, operatorId: $operatorId, accountDate: $accountDate, createdAt: $createdAt, updatedAt: $updatedAt, items: $items, store: $store, operator: $operator)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreAccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountNo, accountNo) ||
                other.accountNo == accountNo) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.tagCode, tagCode) || other.tagCode == tagCode) &&
            (identical(other.tagName, tagName) || other.tagName == tagName) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.operatorId, operatorId) ||
                other.operatorId == operatorId) &&
            (identical(other.accountDate, accountDate) ||
                other.accountDate == accountDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.store, store) || other.store == store) &&
            (identical(other.operator, operator) ||
                other.operator == operator));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      accountNo,
      storeId,
      channel,
      orderNo,
      totalAmount,
      itemCount,
      tagCode,
      tagName,
      remark,
      operatorId,
      accountDate,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_items),
      store,
      operator);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreAccountImplCopyWith<_$StoreAccountImpl> get copyWith =>
      __$$StoreAccountImplCopyWithImpl<_$StoreAccountImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$StoreAccountImplToJson(
      this,
    );
  }
}
abstract class _StoreAccount extends StoreAccount {
  const factory _StoreAccount(
      {required final int id,
      @JsonKey(name: 'account_no') final String? accountNo,
      @JsonKey(name: 'store_id') final int? storeId,
      final String? channel,
      @JsonKey(name: 'order_no') final String? orderNo,
      @JsonKey(name: 'total_amount') final double totalAmount,
      @JsonKey(name: 'item_count') final int itemCount,
      @JsonKey(name: 'tag_code') final String? tagCode,
      @JsonKey(name: 'tag_name') final String? tagName,
      final String? remark,
      @JsonKey(name: 'operator_id') final int? operatorId,
      @JsonKey(name: 'account_date') final String? accountDate,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final List<StoreAccountItem> items,
      final StoreAccountStore? store,
      final StoreAccountOperator? operator}) = _$StoreAccountImpl;
  const _StoreAccount._() : super._();
  factory _StoreAccount.fromJson(Map<String, dynamic> json) =
      _$StoreAccountImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'account_no')
  String? get accountNo;
  @override
  @JsonKey(name: 'store_id')
  int? get storeId;
  @override
  String? get channel;
  @override
  @JsonKey(name: 'order_no')
  String? get orderNo;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  @JsonKey(name: 'item_count')
  int get itemCount;
  @override
  @JsonKey(name: 'tag_code')
  String? get tagCode;
  @override
  @JsonKey(name: 'tag_name')
  String? get tagName;
  @override
  String? get remark;
  @override
  @JsonKey(name: 'operator_id')
  int? get operatorId;
  @override
  @JsonKey(name: 'account_date')
  String? get accountDate;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  List<StoreAccountItem> get items;
  @override
  StoreAccountStore? get store;
  @override
  StoreAccountOperator? get operator;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreAccountImplCopyWith<_$StoreAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
StoreAccountItem _$StoreAccountItemFromJson(Map<String, dynamic> json) {
  return _StoreAccountItem.fromJson(json);
}
mixin _$StoreAccountItem {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_id')
  int? get accountId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  String? get spec => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreAccountItemCopyWith<StoreAccountItem> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $StoreAccountItemCopyWith<$Res> {
  factory $StoreAccountItemCopyWith(
          StoreAccountItem value, $Res Function(StoreAccountItem) then) =
      _$StoreAccountItemCopyWithImpl<$Res, StoreAccountItem>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'account_id') int? accountId,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'product_name') String? productName,
      String? spec,
      double quantity,
      String? unit,
      double price,
      double amount,
      String? remark,
      @JsonKey(name: 'created_at') String? createdAt});
}
class _$StoreAccountItemCopyWithImpl<$Res, $Val extends StoreAccountItem>
    implements $StoreAccountItemCopyWith<$Res> {
  _$StoreAccountItemCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = freezed,
    Object? productId = null,
    Object? productName = freezed,
    Object? spec = freezed,
    Object? quantity = null,
    Object? unit = freezed,
    Object? price = null,
    Object? amount = null,
    Object? remark = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId 
              as int?,
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      productName: freezed == productName
          ? _value.productName
          : productName 
              as String?,
      spec: freezed == spec
          ? _value.spec
          : spec 
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
      price: null == price
          ? _value.price
          : price 
              as double,
      amount: null == amount
          ? _value.amount
          : amount 
              as double,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
    ) as $Val);
  }
}
abstract class _$$StoreAccountItemImplCopyWith<$Res>
    implements $StoreAccountItemCopyWith<$Res> {
  factory _$$StoreAccountItemImplCopyWith(_$StoreAccountItemImpl value,
          $Res Function(_$StoreAccountItemImpl) then) =
      __$$StoreAccountItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'account_id') int? accountId,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'product_name') String? productName,
      String? spec,
      double quantity,
      String? unit,
      double price,
      double amount,
      String? remark,
      @JsonKey(name: 'created_at') String? createdAt});
}
class __$$StoreAccountItemImplCopyWithImpl<$Res>
    extends _$StoreAccountItemCopyWithImpl<$Res, _$StoreAccountItemImpl>
    implements _$$StoreAccountItemImplCopyWith<$Res> {
  __$$StoreAccountItemImplCopyWithImpl(_$StoreAccountItemImpl _value,
      $Res Function(_$StoreAccountItemImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = freezed,
    Object? productId = null,
    Object? productName = freezed,
    Object? spec = freezed,
    Object? quantity = null,
    Object? unit = freezed,
    Object? price = null,
    Object? amount = null,
    Object? remark = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$StoreAccountItemImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId 
              as int?,
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      productName: freezed == productName
          ? _value.productName
          : productName 
              as String?,
      spec: freezed == spec
          ? _value.spec
          : spec 
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
      price: null == price
          ? _value.price
          : price 
              as double,
      amount: null == amount
          ? _value.amount
          : amount 
              as double,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$StoreAccountItemImpl implements _StoreAccountItem {
  const _$StoreAccountItemImpl(
      {required this.id,
      @JsonKey(name: 'account_id') this.accountId,
      @JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'product_name') this.productName,
      this.spec,
      this.quantity = 1.0,
      this.unit,
      this.price = 0.0,
      this.amount = 0.0,
      this.remark,
      @JsonKey(name: 'created_at') this.createdAt});
  factory _$StoreAccountItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreAccountItemImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'account_id')
  final int? accountId;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  final String? spec;
  @override
  @JsonKey()
  final double quantity;
  @override
  final String? unit;
  @override
  @JsonKey()
  final double price;
  @override
  @JsonKey()
  final double amount;
  @override
  final String? remark;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  String toString() {
    return 'StoreAccountItem(id: $id, accountId: $accountId, productId: $productId, productName: $productName, spec: $spec, quantity: $quantity, unit: $unit, price: $price, amount: $amount, remark: $remark, createdAt: $createdAt)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreAccountItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.spec, spec) || other.spec == spec) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, accountId, productId,
      productName, spec, quantity, unit, price, amount, remark, createdAt);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreAccountItemImplCopyWith<_$StoreAccountItemImpl> get copyWith =>
      __$$StoreAccountItemImplCopyWithImpl<_$StoreAccountItemImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$StoreAccountItemImplToJson(
      this,
    );
  }
}
abstract class _StoreAccountItem implements StoreAccountItem {
  const factory _StoreAccountItem(
          {required final int id,
          @JsonKey(name: 'account_id') final int? accountId,
          @JsonKey(name: 'product_id') required final int productId,
          @JsonKey(name: 'product_name') final String? productName,
          final String? spec,
          final double quantity,
          final String? unit,
          final double price,
          final double amount,
          final String? remark,
          @JsonKey(name: 'created_at') final String? createdAt}) =
      _$StoreAccountItemImpl;
  factory _StoreAccountItem.fromJson(Map<String, dynamic> json) =
      _$StoreAccountItemImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'account_id')
  int? get accountId;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  String? get spec;
  @override
  double get quantity;
  @override
  String? get unit;
  @override
  double get price;
  @override
  double get amount;
  @override
  String? get remark;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreAccountItemImplCopyWith<_$StoreAccountItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
StoreAccountStore _$StoreAccountStoreFromJson(Map<String, dynamic> json) {
  return _StoreAccountStore.fromJson(json);
}
mixin _$StoreAccountStore {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreAccountStoreCopyWith<StoreAccountStore> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $StoreAccountStoreCopyWith<$Res> {
  factory $StoreAccountStoreCopyWith(
          StoreAccountStore value, $Res Function(StoreAccountStore) then) =
      _$StoreAccountStoreCopyWithImpl<$Res, StoreAccountStore>;
  @useResult
  $Res call({int id, String? name});
}
class _$StoreAccountStoreCopyWithImpl<$Res, $Val extends StoreAccountStore>
    implements $StoreAccountStoreCopyWith<$Res> {
  _$StoreAccountStoreCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
    ) as $Val);
  }
}
abstract class _$$StoreAccountStoreImplCopyWith<$Res>
    implements $StoreAccountStoreCopyWith<$Res> {
  factory _$$StoreAccountStoreImplCopyWith(_$StoreAccountStoreImpl value,
          $Res Function(_$StoreAccountStoreImpl) then) =
      __$$StoreAccountStoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? name});
}
class __$$StoreAccountStoreImplCopyWithImpl<$Res>
    extends _$StoreAccountStoreCopyWithImpl<$Res, _$StoreAccountStoreImpl>
    implements _$$StoreAccountStoreImplCopyWith<$Res> {
  __$$StoreAccountStoreImplCopyWithImpl(_$StoreAccountStoreImpl _value,
      $Res Function(_$StoreAccountStoreImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
  }) {
    return _then(_$StoreAccountStoreImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$StoreAccountStoreImpl implements _StoreAccountStore {
  const _$StoreAccountStoreImpl({required this.id, this.name});
  factory _$StoreAccountStoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreAccountStoreImplFromJson(json);
  @override
  final int id;
  @override
  final String? name;
  @override
  String toString() {
    return 'StoreAccountStore(id: $id, name: $name)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreAccountStoreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreAccountStoreImplCopyWith<_$StoreAccountStoreImpl> get copyWith =>
      __$$StoreAccountStoreImplCopyWithImpl<_$StoreAccountStoreImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$StoreAccountStoreImplToJson(
      this,
    );
  }
}
abstract class _StoreAccountStore implements StoreAccountStore {
  const factory _StoreAccountStore(
      {required final int id, final String? name}) = _$StoreAccountStoreImpl;
  factory _StoreAccountStore.fromJson(Map<String, dynamic> json) =
      _$StoreAccountStoreImpl.fromJson;
  @override
  int get id;
  @override
  String? get name;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreAccountStoreImplCopyWith<_$StoreAccountStoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
StoreAccountOperator _$StoreAccountOperatorFromJson(Map<String, dynamic> json) {
  return _StoreAccountOperator.fromJson(json);
}
mixin _$StoreAccountOperator {
  int get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreAccountOperatorCopyWith<StoreAccountOperator> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $StoreAccountOperatorCopyWith<$Res> {
  factory $StoreAccountOperatorCopyWith(StoreAccountOperator value,
          $Res Function(StoreAccountOperator) then) =
      _$StoreAccountOperatorCopyWithImpl<$Res, StoreAccountOperator>;
  @useResult
  $Res call({int id, String? username, String? nickname});
}
class _$StoreAccountOperatorCopyWithImpl<$Res,
        $Val extends StoreAccountOperator>
    implements $StoreAccountOperatorCopyWith<$Res> {
  _$StoreAccountOperatorCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      username: freezed == username
          ? _value.username
          : username 
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname 
              as String?,
    ) as $Val);
  }
}
abstract class _$$StoreAccountOperatorImplCopyWith<$Res>
    implements $StoreAccountOperatorCopyWith<$Res> {
  factory _$$StoreAccountOperatorImplCopyWith(_$StoreAccountOperatorImpl value,
          $Res Function(_$StoreAccountOperatorImpl) then) =
      __$$StoreAccountOperatorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? username, String? nickname});
}
class __$$StoreAccountOperatorImplCopyWithImpl<$Res>
    extends _$StoreAccountOperatorCopyWithImpl<$Res, _$StoreAccountOperatorImpl>
    implements _$$StoreAccountOperatorImplCopyWith<$Res> {
  __$$StoreAccountOperatorImplCopyWithImpl(_$StoreAccountOperatorImpl _value,
      $Res Function(_$StoreAccountOperatorImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? nickname = freezed,
  }) {
    return _then(_$StoreAccountOperatorImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      username: freezed == username
          ? _value.username
          : username 
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$StoreAccountOperatorImpl implements _StoreAccountOperator {
  const _$StoreAccountOperatorImpl(
      {required this.id, this.username, this.nickname});
  factory _$StoreAccountOperatorImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreAccountOperatorImplFromJson(json);
  @override
  final int id;
  @override
  final String? username;
  @override
  final String? nickname;
  @override
  String toString() {
    return 'StoreAccountOperator(id: $id, username: $username, nickname: $nickname)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreAccountOperatorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, nickname);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreAccountOperatorImplCopyWith<_$StoreAccountOperatorImpl>
      get copyWith =>
          __$$StoreAccountOperatorImplCopyWithImpl<_$StoreAccountOperatorImpl>(
              this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$StoreAccountOperatorImplToJson(
      this,
    );
  }
}
abstract class _StoreAccountOperator implements StoreAccountOperator {
  const factory _StoreAccountOperator(
      {required final int id,
      final String? username,
      final String? nickname}) = _$StoreAccountOperatorImpl;
  factory _StoreAccountOperator.fromJson(Map<String, dynamic> json) =
      _$StoreAccountOperatorImpl.fromJson;
  @override
  int get id;
  @override
  String? get username;
  @override
  String? get nickname;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreAccountOperatorImplCopyWith<_$StoreAccountOperatorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
StoreAccountStats _$StoreAccountStatsFromJson(Map<String, dynamic> json) {
  return _StoreAccountStats.fromJson(json);
}
mixin _$StoreAccountStats {
  @JsonKey(name: 'total_count')
  int get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_quantity')
  double get totalQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_count')
  int get todayCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_amount')
  double get todayAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'month_amount')
  double get monthAmount => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreAccountStatsCopyWith<StoreAccountStats> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $StoreAccountStatsCopyWith<$Res> {
  factory $StoreAccountStatsCopyWith(
          StoreAccountStats value, $Res Function(StoreAccountStats) then) =
      _$StoreAccountStatsCopyWithImpl<$Res, StoreAccountStats>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      @JsonKey(name: 'total_quantity') double totalQuantity,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'today_count') int todayCount,
      @JsonKey(name: 'today_amount') double todayAmount,
      @JsonKey(name: 'month_amount') double monthAmount});
}
class _$StoreAccountStatsCopyWithImpl<$Res, $Val extends StoreAccountStats>
    implements $StoreAccountStatsCopyWith<$Res> {
  _$StoreAccountStatsCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? totalQuantity = null,
    Object? totalAmount = null,
    Object? todayCount = null,
    Object? todayAmount = null,
    Object? monthAmount = null,
  }) {
    return _then(_value.copyWith(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount 
              as int,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity 
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount 
              as double,
      todayCount: null == todayCount
          ? _value.todayCount
          : todayCount 
              as int,
      todayAmount: null == todayAmount
          ? _value.todayAmount
          : todayAmount 
              as double,
      monthAmount: null == monthAmount
          ? _value.monthAmount
          : monthAmount 
              as double,
    ) as $Val);
  }
}
abstract class _$$StoreAccountStatsImplCopyWith<$Res>
    implements $StoreAccountStatsCopyWith<$Res> {
  factory _$$StoreAccountStatsImplCopyWith(_$StoreAccountStatsImpl value,
          $Res Function(_$StoreAccountStatsImpl) then) =
      __$$StoreAccountStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_count') int totalCount,
      @JsonKey(name: 'total_quantity') double totalQuantity,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'today_count') int todayCount,
      @JsonKey(name: 'today_amount') double todayAmount,
      @JsonKey(name: 'month_amount') double monthAmount});
}
class __$$StoreAccountStatsImplCopyWithImpl<$Res>
    extends _$StoreAccountStatsCopyWithImpl<$Res, _$StoreAccountStatsImpl>
    implements _$$StoreAccountStatsImplCopyWith<$Res> {
  __$$StoreAccountStatsImplCopyWithImpl(_$StoreAccountStatsImpl _value,
      $Res Function(_$StoreAccountStatsImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? totalQuantity = null,
    Object? totalAmount = null,
    Object? todayCount = null,
    Object? todayAmount = null,
    Object? monthAmount = null,
  }) {
    return _then(_$StoreAccountStatsImpl(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount 
              as int,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity 
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount 
              as double,
      todayCount: null == todayCount
          ? _value.todayCount
          : todayCount 
              as int,
      todayAmount: null == todayAmount
          ? _value.todayAmount
          : todayAmount 
              as double,
      monthAmount: null == monthAmount
          ? _value.monthAmount
          : monthAmount 
              as double,
    ));
  }
}
@JsonSerializable()
class _$StoreAccountStatsImpl implements _StoreAccountStats {
  const _$StoreAccountStatsImpl(
      {@JsonKey(name: 'total_count') this.totalCount = 0,
      @JsonKey(name: 'total_quantity') this.totalQuantity = 0.0,
      @JsonKey(name: 'total_amount') this.totalAmount = 0.0,
      @JsonKey(name: 'today_count') this.todayCount = 0,
      @JsonKey(name: 'today_amount') this.todayAmount = 0.0,
      @JsonKey(name: 'month_amount') this.monthAmount = 0.0});
  factory _$StoreAccountStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreAccountStatsImplFromJson(json);
  @override
  @JsonKey(name: 'total_count')
  final int totalCount;
  @override
  @JsonKey(name: 'total_quantity')
  final double totalQuantity;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  @JsonKey(name: 'today_count')
  final int todayCount;
  @override
  @JsonKey(name: 'today_amount')
  final double todayAmount;
  @override
  @JsonKey(name: 'month_amount')
  final double monthAmount;
  @override
  String toString() {
    return 'StoreAccountStats(totalCount: $totalCount, totalQuantity: $totalQuantity, totalAmount: $totalAmount, todayCount: $todayCount, todayAmount: $todayAmount, monthAmount: $monthAmount)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreAccountStatsImpl &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.todayCount, todayCount) ||
                other.todayCount == todayCount) &&
            (identical(other.todayAmount, todayAmount) ||
                other.todayAmount == todayAmount) &&
            (identical(other.monthAmount, monthAmount) ||
                other.monthAmount == monthAmount));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, totalQuantity,
      totalAmount, todayCount, todayAmount, monthAmount);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreAccountStatsImplCopyWith<_$StoreAccountStatsImpl> get copyWith =>
      __$$StoreAccountStatsImplCopyWithImpl<_$StoreAccountStatsImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$StoreAccountStatsImplToJson(
      this,
    );
  }
}
abstract class _StoreAccountStats implements StoreAccountStats {
  const factory _StoreAccountStats(
          {@JsonKey(name: 'total_count') final int totalCount,
          @JsonKey(name: 'total_quantity') final double totalQuantity,
          @JsonKey(name: 'total_amount') final double totalAmount,
          @JsonKey(name: 'today_count') final int todayCount,
          @JsonKey(name: 'today_amount') final double todayAmount,
          @JsonKey(name: 'month_amount') final double monthAmount}) =
      _$StoreAccountStatsImpl;
  factory _StoreAccountStats.fromJson(Map<String, dynamic> json) =
      _$StoreAccountStatsImpl.fromJson;
  @override
  @JsonKey(name: 'total_count')
  int get totalCount;
  @override
  @JsonKey(name: 'total_quantity')
  double get totalQuantity;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  @JsonKey(name: 'today_count')
  int get todayCount;
  @override
  @JsonKey(name: 'today_amount')
  double get todayAmount;
  @override
  @JsonKey(name: 'month_amount')
  double get monthAmount;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreAccountStatsImplCopyWith<_$StoreAccountStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
CreateStoreAccountRequest _$CreateStoreAccountRequestFromJson(
    Map<String, dynamic> json) {
  return _CreateStoreAccountRequest.fromJson(json);
}
mixin _$CreateStoreAccountRequest {
  String get channel => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_no')
  String? get orderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_date')
  String get accountDate => throw _privateConstructorUsedError;
  List<CreateStoreAccountItem> get items => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateStoreAccountRequestCopyWith<CreateStoreAccountRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $CreateStoreAccountRequestCopyWith<$Res> {
  factory $CreateStoreAccountRequestCopyWith(CreateStoreAccountRequest value,
          $Res Function(CreateStoreAccountRequest) then) =
      _$CreateStoreAccountRequestCopyWithImpl<$Res, CreateStoreAccountRequest>;
  @useResult
  $Res call(
      {String channel,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'account_date') String accountDate,
      List<CreateStoreAccountItem> items});
}
class _$CreateStoreAccountRequestCopyWithImpl<$Res,
        $Val extends CreateStoreAccountRequest>
    implements $CreateStoreAccountRequestCopyWith<$Res> {
  _$CreateStoreAccountRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = null,
    Object? orderNo = freezed,
    Object? accountDate = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      channel: null == channel
          ? _value.channel
          : channel 
              as String,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      accountDate: null == accountDate
          ? _value.accountDate
          : accountDate 
              as String,
      items: null == items
          ? _value.items
          : items 
              as List<CreateStoreAccountItem>,
    ) as $Val);
  }
}
abstract class _$$CreateStoreAccountRequestImplCopyWith<$Res>
    implements $CreateStoreAccountRequestCopyWith<$Res> {
  factory _$$CreateStoreAccountRequestImplCopyWith(
          _$CreateStoreAccountRequestImpl value,
          $Res Function(_$CreateStoreAccountRequestImpl) then) =
      __$$CreateStoreAccountRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String channel,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'account_date') String accountDate,
      List<CreateStoreAccountItem> items});
}
class __$$CreateStoreAccountRequestImplCopyWithImpl<$Res>
    extends _$CreateStoreAccountRequestCopyWithImpl<$Res,
        _$CreateStoreAccountRequestImpl>
    implements _$$CreateStoreAccountRequestImplCopyWith<$Res> {
  __$$CreateStoreAccountRequestImplCopyWithImpl(
      _$CreateStoreAccountRequestImpl _value,
      $Res Function(_$CreateStoreAccountRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = null,
    Object? orderNo = freezed,
    Object? accountDate = null,
    Object? items = null,
  }) {
    return _then(_$CreateStoreAccountRequestImpl(
      channel: null == channel
          ? _value.channel
          : channel 
              as String,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      accountDate: null == accountDate
          ? _value.accountDate
          : accountDate 
              as String,
      items: null == items
          ? _value._items
          : items 
              as List<CreateStoreAccountItem>,
    ));
  }
}
@JsonSerializable()
class _$CreateStoreAccountRequestImpl implements _CreateStoreAccountRequest {
  const _$CreateStoreAccountRequestImpl(
      {required this.channel,
      @JsonKey(name: 'order_no') this.orderNo,
      @JsonKey(name: 'account_date') required this.accountDate,
      required final List<CreateStoreAccountItem> items})
      : _items = items;
  factory _$CreateStoreAccountRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateStoreAccountRequestImplFromJson(json);
  @override
  final String channel;
  @override
  @JsonKey(name: 'order_no')
  final String? orderNo;
  @override
  @JsonKey(name: 'account_date')
  final String accountDate;
  final List<CreateStoreAccountItem> _items;
  @override
  List<CreateStoreAccountItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    return EqualUnmodifiableListView(_items);
  }
  @override
  String toString() {
    return 'CreateStoreAccountRequest(channel: $channel, orderNo: $orderNo, accountDate: $accountDate, items: $items)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateStoreAccountRequestImpl &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.accountDate, accountDate) ||
                other.accountDate == accountDate) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, channel, orderNo, accountDate,
      const DeepCollectionEquality().hash(_items));
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateStoreAccountRequestImplCopyWith<_$CreateStoreAccountRequestImpl>
      get copyWith => __$$CreateStoreAccountRequestImplCopyWithImpl<
          _$CreateStoreAccountRequestImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$CreateStoreAccountRequestImplToJson(
      this,
    );
  }
}
abstract class _CreateStoreAccountRequest implements CreateStoreAccountRequest {
  const factory _CreateStoreAccountRequest(
          {required final String channel,
          @JsonKey(name: 'order_no') final String? orderNo,
          @JsonKey(name: 'account_date') required final String accountDate,
          required final List<CreateStoreAccountItem> items}) =
      _$CreateStoreAccountRequestImpl;
  factory _CreateStoreAccountRequest.fromJson(Map<String, dynamic> json) =
      _$CreateStoreAccountRequestImpl.fromJson;
  @override
  String get channel;
  @override
  @JsonKey(name: 'order_no')
  String? get orderNo;
  @override
  @JsonKey(name: 'account_date')
  String get accountDate;
  @override
  List<CreateStoreAccountItem> get items;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateStoreAccountRequestImplCopyWith<_$CreateStoreAccountRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
CreateStoreAccountItem _$CreateStoreAccountItemFromJson(
    Map<String, dynamic> json) {
  return _CreateStoreAccountItem.fromJson(json);
}
mixin _$CreateStoreAccountItem {
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  String? get spec => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateStoreAccountItemCopyWith<CreateStoreAccountItem> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $CreateStoreAccountItemCopyWith<$Res> {
  factory $CreateStoreAccountItemCopyWith(CreateStoreAccountItem value,
          $Res Function(CreateStoreAccountItem) then) =
      _$CreateStoreAccountItemCopyWithImpl<$Res, CreateStoreAccountItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int productId,
      String? spec,
      double quantity,
      String? unit,
      double price,
      double amount});
}
class _$CreateStoreAccountItemCopyWithImpl<$Res,
        $Val extends CreateStoreAccountItem>
    implements $CreateStoreAccountItemCopyWith<$Res> {
  _$CreateStoreAccountItemCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? spec = freezed,
    Object? quantity = null,
    Object? unit = freezed,
    Object? price = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      spec: freezed == spec
          ? _value.spec
          : spec 
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
      price: null == price
          ? _value.price
          : price 
              as double,
      amount: null == amount
          ? _value.amount
          : amount 
              as double,
    ) as $Val);
  }
}
abstract class _$$CreateStoreAccountItemImplCopyWith<$Res>
    implements $CreateStoreAccountItemCopyWith<$Res> {
  factory _$$CreateStoreAccountItemImplCopyWith(
          _$CreateStoreAccountItemImpl value,
          $Res Function(_$CreateStoreAccountItemImpl) then) =
      __$$CreateStoreAccountItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int productId,
      String? spec,
      double quantity,
      String? unit,
      double price,
      double amount});
}
class __$$CreateStoreAccountItemImplCopyWithImpl<$Res>
    extends _$CreateStoreAccountItemCopyWithImpl<$Res,
        _$CreateStoreAccountItemImpl>
    implements _$$CreateStoreAccountItemImplCopyWith<$Res> {
  __$$CreateStoreAccountItemImplCopyWithImpl(
      _$CreateStoreAccountItemImpl _value,
      $Res Function(_$CreateStoreAccountItemImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? spec = freezed,
    Object? quantity = null,
    Object? unit = freezed,
    Object? price = null,
    Object? amount = null,
  }) {
    return _then(_$CreateStoreAccountItemImpl(
      productId: null == productId
          ? _value.productId
          : productId 
              as int,
      spec: freezed == spec
          ? _value.spec
          : spec 
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity 
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit 
              as String?,
      price: null == price
          ? _value.price
          : price 
              as double,
      amount: null == amount
          ? _value.amount
          : amount 
              as double,
    ));
  }
}
@JsonSerializable()
class _$CreateStoreAccountItemImpl implements _CreateStoreAccountItem {
  const _$CreateStoreAccountItemImpl(
      {@JsonKey(name: 'product_id') required this.productId,
      this.spec,
      required this.quantity,
      this.unit,
      this.price = 0.0,
      this.amount = 0.0});
  factory _$CreateStoreAccountItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateStoreAccountItemImplFromJson(json);
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  final String? spec;
  @override
  final double quantity;
  @override
  final String? unit;
  @override
  @JsonKey()
  final double price;
  @override
  @JsonKey()
  final double amount;
  @override
  String toString() {
    return 'CreateStoreAccountItem(productId: $productId, spec: $spec, quantity: $quantity, unit: $unit, price: $price, amount: $amount)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateStoreAccountItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.spec, spec) || other.spec == spec) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.amount, amount) || other.amount == amount));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productId, spec, quantity, unit, price, amount);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateStoreAccountItemImplCopyWith<_$CreateStoreAccountItemImpl>
      get copyWith => __$$CreateStoreAccountItemImplCopyWithImpl<
          _$CreateStoreAccountItemImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$CreateStoreAccountItemImplToJson(
      this,
    );
  }
}
abstract class _CreateStoreAccountItem implements CreateStoreAccountItem {
  const factory _CreateStoreAccountItem(
      {@JsonKey(name: 'product_id') required final int productId,
      final String? spec,
      required final double quantity,
      final String? unit,
      final double price,
      final double amount}) = _$CreateStoreAccountItemImpl;
  factory _CreateStoreAccountItem.fromJson(Map<String, dynamic> json) =
      _$CreateStoreAccountItemImpl.fromJson;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  String? get spec;
  @override
  double get quantity;
  @override
  String? get unit;
  @override
  double get price;
  @override
  double get amount;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateStoreAccountItemImplCopyWith<_$CreateStoreAccountItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
UpdateStoreAccountRequest _$UpdateStoreAccountRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateStoreAccountRequest.fromJson(json);
}
mixin _$UpdateStoreAccountRequest {
  String? get channel => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_no')
  String? get orderNo => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_date')
  String? get accountDate => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateStoreAccountRequestCopyWith<UpdateStoreAccountRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $UpdateStoreAccountRequestCopyWith<$Res> {
  factory $UpdateStoreAccountRequestCopyWith(UpdateStoreAccountRequest value,
          $Res Function(UpdateStoreAccountRequest) then) =
      _$UpdateStoreAccountRequestCopyWithImpl<$Res, UpdateStoreAccountRequest>;
  @useResult
  $Res call(
      {String? channel,
      @JsonKey(name: 'order_no') String? orderNo,
      String? remark,
      @JsonKey(name: 'account_date') String? accountDate});
}
class _$UpdateStoreAccountRequestCopyWithImpl<$Res,
        $Val extends UpdateStoreAccountRequest>
    implements $UpdateStoreAccountRequestCopyWith<$Res> {
  _$UpdateStoreAccountRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = freezed,
    Object? orderNo = freezed,
    Object? remark = freezed,
    Object? accountDate = freezed,
  }) {
    return _then(_value.copyWith(
      channel: freezed == channel
          ? _value.channel
          : channel 
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      accountDate: freezed == accountDate
          ? _value.accountDate
          : accountDate 
              as String?,
    ) as $Val);
  }
}
abstract class _$$UpdateStoreAccountRequestImplCopyWith<$Res>
    implements $UpdateStoreAccountRequestCopyWith<$Res> {
  factory _$$UpdateStoreAccountRequestImplCopyWith(
          _$UpdateStoreAccountRequestImpl value,
          $Res Function(_$UpdateStoreAccountRequestImpl) then) =
      __$$UpdateStoreAccountRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? channel,
      @JsonKey(name: 'order_no') String? orderNo,
      String? remark,
      @JsonKey(name: 'account_date') String? accountDate});
}
class __$$UpdateStoreAccountRequestImplCopyWithImpl<$Res>
    extends _$UpdateStoreAccountRequestCopyWithImpl<$Res,
        _$UpdateStoreAccountRequestImpl>
    implements _$$UpdateStoreAccountRequestImplCopyWith<$Res> {
  __$$UpdateStoreAccountRequestImplCopyWithImpl(
      _$UpdateStoreAccountRequestImpl _value,
      $Res Function(_$UpdateStoreAccountRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = freezed,
    Object? orderNo = freezed,
    Object? remark = freezed,
    Object? accountDate = freezed,
  }) {
    return _then(_$UpdateStoreAccountRequestImpl(
      channel: freezed == channel
          ? _value.channel
          : channel 
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      accountDate: freezed == accountDate
          ? _value.accountDate
          : accountDate 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$UpdateStoreAccountRequestImpl implements _UpdateStoreAccountRequest {
  const _$UpdateStoreAccountRequestImpl(
      {this.channel,
      @JsonKey(name: 'order_no') this.orderNo,
      this.remark,
      @JsonKey(name: 'account_date') this.accountDate});
  factory _$UpdateStoreAccountRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateStoreAccountRequestImplFromJson(json);
  @override
  final String? channel;
  @override
  @JsonKey(name: 'order_no')
  final String? orderNo;
  @override
  final String? remark;
  @override
  @JsonKey(name: 'account_date')
  final String? accountDate;
  @override
  String toString() {
    return 'UpdateStoreAccountRequest(channel: $channel, orderNo: $orderNo, remark: $remark, accountDate: $accountDate)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateStoreAccountRequestImpl &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.accountDate, accountDate) ||
                other.accountDate == accountDate));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, channel, orderNo, remark, accountDate);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateStoreAccountRequestImplCopyWith<_$UpdateStoreAccountRequestImpl>
      get copyWith => __$$UpdateStoreAccountRequestImplCopyWithImpl<
          _$UpdateStoreAccountRequestImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateStoreAccountRequestImplToJson(
      this,
    );
  }
}
abstract class _UpdateStoreAccountRequest implements UpdateStoreAccountRequest {
  const factory _UpdateStoreAccountRequest(
          {final String? channel,
          @JsonKey(name: 'order_no') final String? orderNo,
          final String? remark,
          @JsonKey(name: 'account_date') final String? accountDate}) =
      _$UpdateStoreAccountRequestImpl;
  factory _UpdateStoreAccountRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateStoreAccountRequestImpl.fromJson;
  @override
  String? get channel;
  @override
  @JsonKey(name: 'order_no')
  String? get orderNo;
  @override
  String? get remark;
  @override
  @JsonKey(name: 'account_date')
  String? get accountDate;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateStoreAccountRequestImplCopyWith<_$UpdateStoreAccountRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
