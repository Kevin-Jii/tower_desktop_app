part of 'models.dart';
T _$identity<T>(T value) => value;
final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https:
Member _$MemberFromJson(Map<String, dynamic> json) {
  return _Member.fromJson(json);
}
mixin _$Member {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'uid')
  String? get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'level_id')
  int? get levelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'level_name')
  String? get levelName => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance')
  String? get balance => throw _privateConstructorUsedError;
  @JsonKey(name: 'points')
  int? get points => throw _privateConstructorUsedError;
  @JsonKey(name: 'version')
  int? get version => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberCopyWith<Member> get copyWith => throw _privateConstructorUsedError;
}
abstract class $MemberCopyWith<$Res> {
  factory $MemberCopyWith(Member value, $Res Function(Member) then) =
      _$MemberCopyWithImpl<$Res, Member>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'uid') String? uid,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'level_id') int? levelId,
      @JsonKey(name: 'level_name') String? levelName,
      @JsonKey(name: 'balance') String? balance,
      @JsonKey(name: 'points') int? points,
      @JsonKey(name: 'version') int? version,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}
class _$MemberCopyWithImpl<$Res, $Val extends Member>
    implements $MemberCopyWith<$Res> {
  _$MemberCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? levelId = freezed,
    Object? levelName = freezed,
    Object? balance = freezed,
    Object? points = freezed,
    Object? version = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      uid: freezed == uid
          ? _value.uid
          : uid 
              as String?,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone 
              as String?,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId 
              as int?,
      levelName: freezed == levelName
          ? _value.levelName
          : levelName 
              as String?,
      balance: freezed == balance
          ? _value.balance
          : balance 
              as String?,
      points: freezed == points
          ? _value.points
          : points 
              as int?,
      version: freezed == version
          ? _value.version
          : version 
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt 
              as String?,
    ) as $Val);
  }
}
abstract class _$$MemberImplCopyWith<$Res> implements $MemberCopyWith<$Res> {
  factory _$$MemberImplCopyWith(
          _$MemberImpl value, $Res Function(_$MemberImpl) then) =
      __$$MemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'uid') String? uid,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'level_id') int? levelId,
      @JsonKey(name: 'level_name') String? levelName,
      @JsonKey(name: 'balance') String? balance,
      @JsonKey(name: 'points') int? points,
      @JsonKey(name: 'version') int? version,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}
class __$$MemberImplCopyWithImpl<$Res>
    extends _$MemberCopyWithImpl<$Res, _$MemberImpl>
    implements _$$MemberImplCopyWith<$Res> {
  __$$MemberImplCopyWithImpl(
      _$MemberImpl _value, $Res Function(_$MemberImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? levelId = freezed,
    Object? levelName = freezed,
    Object? balance = freezed,
    Object? points = freezed,
    Object? version = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MemberImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      uid: freezed == uid
          ? _value.uid
          : uid 
              as String?,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone 
              as String?,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId 
              as int?,
      levelName: freezed == levelName
          ? _value.levelName
          : levelName 
              as String?,
      balance: freezed == balance
          ? _value.balance
          : balance 
              as String?,
      points: freezed == points
          ? _value.points
          : points 
              as int?,
      version: freezed == version
          ? _value.version
          : version 
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$MemberImpl implements _Member {
  const _$MemberImpl(
      {required this.id,
      @JsonKey(name: 'uid') this.uid,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'phone') this.phone,
      @JsonKey(name: 'level_id') this.levelId,
      @JsonKey(name: 'level_name') this.levelName,
      @JsonKey(name: 'balance') this.balance,
      @JsonKey(name: 'points') this.points,
      @JsonKey(name: 'version') this.version,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});
  factory _$MemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'uid')
  final String? uid;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'phone')
  final String? phone;
  @override
  @JsonKey(name: 'level_id')
  final int? levelId;
  @override
  @JsonKey(name: 'level_name')
  final String? levelName;
  @override
  @JsonKey(name: 'balance')
  final String? balance;
  @override
  @JsonKey(name: 'points')
  final int? points;
  @override
  @JsonKey(name: 'version')
  final int? version;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  String toString() {
    return 'Member(id: $id, uid: $uid, name: $name, phone: $phone, levelId: $levelId, levelName: $levelName, balance: $balance, points: $points, version: $version, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.levelId, levelId) || other.levelId == levelId) &&
            (identical(other.levelName, levelName) ||
                other.levelName == levelName) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uid, name, phone, levelId,
      levelName, balance, points, version, createdAt, updatedAt);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberImplCopyWith<_$MemberImpl> get copyWith =>
      __$$MemberImplCopyWithImpl<_$MemberImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$MemberImplToJson(
      this,
    );
  }
}
abstract class _Member implements Member {
  const factory _Member(
      {required final int id,
      @JsonKey(name: 'uid') final String? uid,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'phone') final String? phone,
      @JsonKey(name: 'level_id') final int? levelId,
      @JsonKey(name: 'level_name') final String? levelName,
      @JsonKey(name: 'balance') final String? balance,
      @JsonKey(name: 'points') final int? points,
      @JsonKey(name: 'version') final int? version,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$MemberImpl;
  factory _Member.fromJson(Map<String, dynamic> json) = _$MemberImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'uid')
  String? get uid;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'phone')
  String? get phone;
  @override
  @JsonKey(name: 'level_id')
  int? get levelId;
  @override
  @JsonKey(name: 'level_name')
  String? get levelName;
  @override
  @JsonKey(name: 'balance')
  String? get balance;
  @override
  @JsonKey(name: 'points')
  int? get points;
  @override
  @JsonKey(name: 'version')
  int? get version;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberImplCopyWith<_$MemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
WalletLog _$WalletLogFromJson(Map<String, dynamic> json) {
  return _WalletLog.fromJson(json);
}
mixin _$WalletLog {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_id')
  int? get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_type')
  int? get changeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_amount')
  String? get changeAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance_before')
  String? get balanceBefore => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance_after')
  String? get balanceAfter => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_no')
  String? get orderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletLogCopyWith<WalletLog> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $WalletLogCopyWith<$Res> {
  factory $WalletLogCopyWith(WalletLog value, $Res Function(WalletLog) then) =
      _$WalletLogCopyWithImpl<$Res, WalletLog>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'member_id') int? memberId,
      @JsonKey(name: 'change_type') int? changeType,
      @JsonKey(name: 'change_amount') String? changeAmount,
      @JsonKey(name: 'balance_before') String? balanceBefore,
      @JsonKey(name: 'balance_after') String? balanceAfter,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'created_at') String? createdAt});
}
class _$WalletLogCopyWithImpl<$Res, $Val extends WalletLog>
    implements $WalletLogCopyWith<$Res> {
  _$WalletLogCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memberId = freezed,
    Object? changeType = freezed,
    Object? changeAmount = freezed,
    Object? balanceBefore = freezed,
    Object? balanceAfter = freezed,
    Object? remark = freezed,
    Object? orderNo = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id 
              as int,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId 
              as int?,
      changeType: freezed == changeType
          ? _value.changeType
          : changeType 
              as int?,
      changeAmount: freezed == changeAmount
          ? _value.changeAmount
          : changeAmount 
              as String?,
      balanceBefore: freezed == balanceBefore
          ? _value.balanceBefore
          : balanceBefore 
              as String?,
      balanceAfter: freezed == balanceAfter
          ? _value.balanceAfter
          : balanceAfter 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
    ) as $Val);
  }
}
abstract class _$$WalletLogImplCopyWith<$Res>
    implements $WalletLogCopyWith<$Res> {
  factory _$$WalletLogImplCopyWith(
          _$WalletLogImpl value, $Res Function(_$WalletLogImpl) then) =
      __$$WalletLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'member_id') int? memberId,
      @JsonKey(name: 'change_type') int? changeType,
      @JsonKey(name: 'change_amount') String? changeAmount,
      @JsonKey(name: 'balance_before') String? balanceBefore,
      @JsonKey(name: 'balance_after') String? balanceAfter,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'created_at') String? createdAt});
}
class __$$WalletLogImplCopyWithImpl<$Res>
    extends _$WalletLogCopyWithImpl<$Res, _$WalletLogImpl>
    implements _$$WalletLogImplCopyWith<$Res> {
  __$$WalletLogImplCopyWithImpl(
      _$WalletLogImpl _value, $Res Function(_$WalletLogImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memberId = freezed,
    Object? changeType = freezed,
    Object? changeAmount = freezed,
    Object? balanceBefore = freezed,
    Object? balanceAfter = freezed,
    Object? remark = freezed,
    Object? orderNo = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$WalletLogImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId 
              as int?,
      changeType: freezed == changeType
          ? _value.changeType
          : changeType 
              as int?,
      changeAmount: freezed == changeAmount
          ? _value.changeAmount
          : changeAmount 
              as String?,
      balanceBefore: freezed == balanceBefore
          ? _value.balanceBefore
          : balanceBefore 
              as String?,
      balanceAfter: freezed == balanceAfter
          ? _value.balanceAfter
          : balanceAfter 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$WalletLogImpl implements _WalletLog {
  const _$WalletLogImpl(
      {required this.id,
      @JsonKey(name: 'member_id') this.memberId,
      @JsonKey(name: 'change_type') this.changeType,
      @JsonKey(name: 'change_amount') this.changeAmount,
      @JsonKey(name: 'balance_before') this.balanceBefore,
      @JsonKey(name: 'balance_after') this.balanceAfter,
      @JsonKey(name: 'remark') this.remark,
      @JsonKey(name: 'order_no') this.orderNo,
      @JsonKey(name: 'created_at') this.createdAt});
  factory _$WalletLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletLogImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'member_id')
  final int? memberId;
  @override
  @JsonKey(name: 'change_type')
  final int? changeType;
  @override
  @JsonKey(name: 'change_amount')
  final String? changeAmount;
  @override
  @JsonKey(name: 'balance_before')
  final String? balanceBefore;
  @override
  @JsonKey(name: 'balance_after')
  final String? balanceAfter;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  @JsonKey(name: 'order_no')
  final String? orderNo;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  String toString() {
    return 'WalletLog(id: $id, memberId: $memberId, changeType: $changeType, changeAmount: $changeAmount, balanceBefore: $balanceBefore, balanceAfter: $balanceAfter, remark: $remark, orderNo: $orderNo, createdAt: $createdAt)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.changeType, changeType) ||
                other.changeType == changeType) &&
            (identical(other.changeAmount, changeAmount) ||
                other.changeAmount == changeAmount) &&
            (identical(other.balanceBefore, balanceBefore) ||
                other.balanceBefore == balanceBefore) &&
            (identical(other.balanceAfter, balanceAfter) ||
                other.balanceAfter == balanceAfter) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, memberId, changeType,
      changeAmount, balanceBefore, balanceAfter, remark, orderNo, createdAt);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletLogImplCopyWith<_$WalletLogImpl> get copyWith =>
      __$$WalletLogImplCopyWithImpl<_$WalletLogImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$WalletLogImplToJson(
      this,
    );
  }
}
abstract class _WalletLog implements WalletLog {
  const factory _WalletLog(
      {required final int id,
      @JsonKey(name: 'member_id') final int? memberId,
      @JsonKey(name: 'change_type') final int? changeType,
      @JsonKey(name: 'change_amount') final String? changeAmount,
      @JsonKey(name: 'balance_before') final String? balanceBefore,
      @JsonKey(name: 'balance_after') final String? balanceAfter,
      @JsonKey(name: 'remark') final String? remark,
      @JsonKey(name: 'order_no') final String? orderNo,
      @JsonKey(name: 'created_at') final String? createdAt}) = _$WalletLogImpl;
  factory _WalletLog.fromJson(Map<String, dynamic> json) =
      _$WalletLogImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'member_id')
  int? get memberId;
  @override
  @JsonKey(name: 'change_type')
  int? get changeType;
  @override
  @JsonKey(name: 'change_amount')
  String? get changeAmount;
  @override
  @JsonKey(name: 'balance_before')
  String? get balanceBefore;
  @override
  @JsonKey(name: 'balance_after')
  String? get balanceAfter;
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(name: 'order_no')
  String? get orderNo;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletLogImplCopyWith<_$WalletLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
RechargeOrder _$RechargeOrderFromJson(Map<String, dynamic> json) {
  return _RechargeOrder.fromJson(json);
}
mixin _$RechargeOrder {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_no')
  String? get orderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_id')
  int? get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_name')
  String? get memberName => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_amount')
  String? get payAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'gift_amount')
  String? get giftAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_type')
  int? get payType => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_status')
  int? get payStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_time')
  String? get payTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RechargeOrderCopyWith<RechargeOrder> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $RechargeOrderCopyWith<$Res> {
  factory $RechargeOrderCopyWith(
          RechargeOrder value, $Res Function(RechargeOrder) then) =
      _$RechargeOrderCopyWithImpl<$Res, RechargeOrder>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'member_id') int? memberId,
      @JsonKey(name: 'member_name') String? memberName,
      @JsonKey(name: 'pay_amount') String? payAmount,
      @JsonKey(name: 'gift_amount') String? giftAmount,
      @JsonKey(name: 'pay_type') int? payType,
      @JsonKey(name: 'pay_status') int? payStatus,
      @JsonKey(name: 'pay_time') String? payTime,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'created_at') String? createdAt});
}
class _$RechargeOrderCopyWithImpl<$Res, $Val extends RechargeOrder>
    implements $RechargeOrderCopyWith<$Res> {
  _$RechargeOrderCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNo = freezed,
    Object? memberId = freezed,
    Object? memberName = freezed,
    Object? payAmount = freezed,
    Object? giftAmount = freezed,
    Object? payType = freezed,
    Object? payStatus = freezed,
    Object? payTime = freezed,
    Object? remark = freezed,
    Object? createdAt = freezed,
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
      memberId: freezed == memberId
          ? _value.memberId
          : memberId 
              as int?,
      memberName: freezed == memberName
          ? _value.memberName
          : memberName 
              as String?,
      payAmount: freezed == payAmount
          ? _value.payAmount
          : payAmount 
              as String?,
      giftAmount: freezed == giftAmount
          ? _value.giftAmount
          : giftAmount 
              as String?,
      payType: freezed == payType
          ? _value.payType
          : payType 
              as int?,
      payStatus: freezed == payStatus
          ? _value.payStatus
          : payStatus 
              as int?,
      payTime: freezed == payTime
          ? _value.payTime
          : payTime 
              as String?,
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
abstract class _$$RechargeOrderImplCopyWith<$Res>
    implements $RechargeOrderCopyWith<$Res> {
  factory _$$RechargeOrderImplCopyWith(
          _$RechargeOrderImpl value, $Res Function(_$RechargeOrderImpl) then) =
      __$$RechargeOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'order_no') String? orderNo,
      @JsonKey(name: 'member_id') int? memberId,
      @JsonKey(name: 'member_name') String? memberName,
      @JsonKey(name: 'pay_amount') String? payAmount,
      @JsonKey(name: 'gift_amount') String? giftAmount,
      @JsonKey(name: 'pay_type') int? payType,
      @JsonKey(name: 'pay_status') int? payStatus,
      @JsonKey(name: 'pay_time') String? payTime,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'created_at') String? createdAt});
}
class __$$RechargeOrderImplCopyWithImpl<$Res>
    extends _$RechargeOrderCopyWithImpl<$Res, _$RechargeOrderImpl>
    implements _$$RechargeOrderImplCopyWith<$Res> {
  __$$RechargeOrderImplCopyWithImpl(
      _$RechargeOrderImpl _value, $Res Function(_$RechargeOrderImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNo = freezed,
    Object? memberId = freezed,
    Object? memberName = freezed,
    Object? payAmount = freezed,
    Object? giftAmount = freezed,
    Object? payType = freezed,
    Object? payStatus = freezed,
    Object? payTime = freezed,
    Object? remark = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$RechargeOrderImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo 
              as String?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId 
              as int?,
      memberName: freezed == memberName
          ? _value.memberName
          : memberName 
              as String?,
      payAmount: freezed == payAmount
          ? _value.payAmount
          : payAmount 
              as String?,
      giftAmount: freezed == giftAmount
          ? _value.giftAmount
          : giftAmount 
              as String?,
      payType: freezed == payType
          ? _value.payType
          : payType 
              as int?,
      payStatus: freezed == payStatus
          ? _value.payStatus
          : payStatus 
              as int?,
      payTime: freezed == payTime
          ? _value.payTime
          : payTime 
              as String?,
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
class _$RechargeOrderImpl implements _RechargeOrder {
  const _$RechargeOrderImpl(
      {required this.id,
      @JsonKey(name: 'order_no') this.orderNo,
      @JsonKey(name: 'member_id') this.memberId,
      @JsonKey(name: 'member_name') this.memberName,
      @JsonKey(name: 'pay_amount') this.payAmount,
      @JsonKey(name: 'gift_amount') this.giftAmount,
      @JsonKey(name: 'pay_type') this.payType,
      @JsonKey(name: 'pay_status') this.payStatus,
      @JsonKey(name: 'pay_time') this.payTime,
      @JsonKey(name: 'remark') this.remark,
      @JsonKey(name: 'created_at') this.createdAt});
  factory _$RechargeOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$RechargeOrderImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'order_no')
  final String? orderNo;
  @override
  @JsonKey(name: 'member_id')
  final int? memberId;
  @override
  @JsonKey(name: 'member_name')
  final String? memberName;
  @override
  @JsonKey(name: 'pay_amount')
  final String? payAmount;
  @override
  @JsonKey(name: 'gift_amount')
  final String? giftAmount;
  @override
  @JsonKey(name: 'pay_type')
  final int? payType;
  @override
  @JsonKey(name: 'pay_status')
  final int? payStatus;
  @override
  @JsonKey(name: 'pay_time')
  final String? payTime;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  String toString() {
    return 'RechargeOrder(id: $id, orderNo: $orderNo, memberId: $memberId, memberName: $memberName, payAmount: $payAmount, giftAmount: $giftAmount, payType: $payType, payStatus: $payStatus, payTime: $payTime, remark: $remark, createdAt: $createdAt)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RechargeOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.payAmount, payAmount) ||
                other.payAmount == payAmount) &&
            (identical(other.giftAmount, giftAmount) ||
                other.giftAmount == giftAmount) &&
            (identical(other.payType, payType) || other.payType == payType) &&
            (identical(other.payStatus, payStatus) ||
                other.payStatus == payStatus) &&
            (identical(other.payTime, payTime) || other.payTime == payTime) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderNo,
      memberId,
      memberName,
      payAmount,
      giftAmount,
      payType,
      payStatus,
      payTime,
      remark,
      createdAt);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RechargeOrderImplCopyWith<_$RechargeOrderImpl> get copyWith =>
      __$$RechargeOrderImplCopyWithImpl<_$RechargeOrderImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$RechargeOrderImplToJson(
      this,
    );
  }
}
abstract class _RechargeOrder implements RechargeOrder {
  const factory _RechargeOrder(
          {required final int id,
          @JsonKey(name: 'order_no') final String? orderNo,
          @JsonKey(name: 'member_id') final int? memberId,
          @JsonKey(name: 'member_name') final String? memberName,
          @JsonKey(name: 'pay_amount') final String? payAmount,
          @JsonKey(name: 'gift_amount') final String? giftAmount,
          @JsonKey(name: 'pay_type') final int? payType,
          @JsonKey(name: 'pay_status') final int? payStatus,
          @JsonKey(name: 'pay_time') final String? payTime,
          @JsonKey(name: 'remark') final String? remark,
          @JsonKey(name: 'created_at') final String? createdAt}) =
      _$RechargeOrderImpl;
  factory _RechargeOrder.fromJson(Map<String, dynamic> json) =
      _$RechargeOrderImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'order_no')
  String? get orderNo;
  @override
  @JsonKey(name: 'member_id')
  int? get memberId;
  @override
  @JsonKey(name: 'member_name')
  String? get memberName;
  @override
  @JsonKey(name: 'pay_amount')
  String? get payAmount;
  @override
  @JsonKey(name: 'gift_amount')
  String? get giftAmount;
  @override
  @JsonKey(name: 'pay_type')
  int? get payType;
  @override
  @JsonKey(name: 'pay_status')
  int? get payStatus;
  @override
  @JsonKey(name: 'pay_time')
  String? get payTime;
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RechargeOrderImplCopyWith<_$RechargeOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
CreateMemberReq _$CreateMemberReqFromJson(Map<String, dynamic> json) {
  return _CreateMemberReq.fromJson(json);
}
mixin _$CreateMemberReq {
  String? get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  int? get levelId => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateMemberReqCopyWith<CreateMemberReq> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $CreateMemberReqCopyWith<$Res> {
  factory $CreateMemberReqCopyWith(
          CreateMemberReq value, $Res Function(CreateMemberReq) then) =
      _$CreateMemberReqCopyWithImpl<$Res, CreateMemberReq>;
  @useResult
  $Res call({String? uid, String name, String phone, int? levelId});
}
class _$CreateMemberReqCopyWithImpl<$Res, $Val extends CreateMemberReq>
    implements $CreateMemberReqCopyWith<$Res> {
  _$CreateMemberReqCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? name = null,
    Object? phone = null,
    Object? levelId = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid 
              as String?,
      name: null == name
          ? _value.name
          : name 
              as String,
      phone: null == phone
          ? _value.phone
          : phone 
              as String,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId 
              as int?,
    ) as $Val);
  }
}
abstract class _$$CreateMemberReqImplCopyWith<$Res>
    implements $CreateMemberReqCopyWith<$Res> {
  factory _$$CreateMemberReqImplCopyWith(_$CreateMemberReqImpl value,
          $Res Function(_$CreateMemberReqImpl) then) =
      __$$CreateMemberReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? uid, String name, String phone, int? levelId});
}
class __$$CreateMemberReqImplCopyWithImpl<$Res>
    extends _$CreateMemberReqCopyWithImpl<$Res, _$CreateMemberReqImpl>
    implements _$$CreateMemberReqImplCopyWith<$Res> {
  __$$CreateMemberReqImplCopyWithImpl(
      _$CreateMemberReqImpl _value, $Res Function(_$CreateMemberReqImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? name = null,
    Object? phone = null,
    Object? levelId = freezed,
  }) {
    return _then(_$CreateMemberReqImpl(
      uid: freezed == uid
          ? _value.uid
          : uid 
              as String?,
      name: null == name
          ? _value.name
          : name 
              as String,
      phone: null == phone
          ? _value.phone
          : phone 
              as String,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId 
              as int?,
    ));
  }
}
@JsonSerializable()
class _$CreateMemberReqImpl implements _CreateMemberReq {
  const _$CreateMemberReqImpl(
      {this.uid, required this.name, required this.phone, this.levelId});
  factory _$CreateMemberReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateMemberReqImplFromJson(json);
  @override
  final String? uid;
  @override
  final String name;
  @override
  final String phone;
  @override
  final int? levelId;
  @override
  String toString() {
    return 'CreateMemberReq(uid: $uid, name: $name, phone: $phone, levelId: $levelId)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateMemberReqImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.levelId, levelId) || other.levelId == levelId));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, name, phone, levelId);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateMemberReqImplCopyWith<_$CreateMemberReqImpl> get copyWith =>
      __$$CreateMemberReqImplCopyWithImpl<_$CreateMemberReqImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$CreateMemberReqImplToJson(
      this,
    );
  }
}
abstract class _CreateMemberReq implements CreateMemberReq {
  const factory _CreateMemberReq(
      {final String? uid,
      required final String name,
      required final String phone,
      final int? levelId}) = _$CreateMemberReqImpl;
  factory _CreateMemberReq.fromJson(Map<String, dynamic> json) =
      _$CreateMemberReqImpl.fromJson;
  @override
  String? get uid;
  @override
  String get name;
  @override
  String get phone;
  @override
  int? get levelId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateMemberReqImplCopyWith<_$CreateMemberReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
UpdateMemberReq _$UpdateMemberReqFromJson(Map<String, dynamic> json) {
  return _UpdateMemberReq.fromJson(json);
}
mixin _$UpdateMemberReq {
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  int? get points => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateMemberReqCopyWith<UpdateMemberReq> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $UpdateMemberReqCopyWith<$Res> {
  factory $UpdateMemberReqCopyWith(
          UpdateMemberReq value, $Res Function(UpdateMemberReq) then) =
      _$UpdateMemberReqCopyWithImpl<$Res, UpdateMemberReq>;
  @useResult
  $Res call({String? name, String? phone, int? points, int? level});
}
class _$UpdateMemberReqCopyWithImpl<$Res, $Val extends UpdateMemberReq>
    implements $UpdateMemberReqCopyWith<$Res> {
  _$UpdateMemberReqCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? phone = freezed,
    Object? points = freezed,
    Object? level = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone 
              as String?,
      points: freezed == points
          ? _value.points
          : points 
              as int?,
      level: freezed == level
          ? _value.level
          : level 
              as int?,
    ) as $Val);
  }
}
abstract class _$$UpdateMemberReqImplCopyWith<$Res>
    implements $UpdateMemberReqCopyWith<$Res> {
  factory _$$UpdateMemberReqImplCopyWith(_$UpdateMemberReqImpl value,
          $Res Function(_$UpdateMemberReqImpl) then) =
      __$$UpdateMemberReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? phone, int? points, int? level});
}
class __$$UpdateMemberReqImplCopyWithImpl<$Res>
    extends _$UpdateMemberReqCopyWithImpl<$Res, _$UpdateMemberReqImpl>
    implements _$$UpdateMemberReqImplCopyWith<$Res> {
  __$$UpdateMemberReqImplCopyWithImpl(
      _$UpdateMemberReqImpl _value, $Res Function(_$UpdateMemberReqImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? phone = freezed,
    Object? points = freezed,
    Object? level = freezed,
  }) {
    return _then(_$UpdateMemberReqImpl(
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone 
              as String?,
      points: freezed == points
          ? _value.points
          : points 
              as int?,
      level: freezed == level
          ? _value.level
          : level 
              as int?,
    ));
  }
}
@JsonSerializable()
class _$UpdateMemberReqImpl implements _UpdateMemberReq {
  const _$UpdateMemberReqImpl({this.name, this.phone, this.points, this.level});
  factory _$UpdateMemberReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateMemberReqImplFromJson(json);
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final int? points;
  @override
  final int? level;
  @override
  String toString() {
    return 'UpdateMemberReq(name: $name, phone: $phone, points: $points, level: $level)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMemberReqImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.level, level) || other.level == level));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, phone, points, level);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateMemberReqImplCopyWith<_$UpdateMemberReqImpl> get copyWith =>
      __$$UpdateMemberReqImplCopyWithImpl<_$UpdateMemberReqImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateMemberReqImplToJson(
      this,
    );
  }
}
abstract class _UpdateMemberReq implements UpdateMemberReq {
  const factory _UpdateMemberReq(
      {final String? name,
      final String? phone,
      final int? points,
      final int? level}) = _$UpdateMemberReqImpl;
  factory _UpdateMemberReq.fromJson(Map<String, dynamic> json) =
      _$UpdateMemberReqImpl.fromJson;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  int? get points;
  @override
  int? get level;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateMemberReqImplCopyWith<_$UpdateMemberReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
AdjustBalanceReq _$AdjustBalanceReqFromJson(Map<String, dynamic> json) {
  return _AdjustBalanceReq.fromJson(json);
}
mixin _$AdjustBalanceReq {
  String get amount => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  int? get version => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdjustBalanceReqCopyWith<AdjustBalanceReq> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $AdjustBalanceReqCopyWith<$Res> {
  factory $AdjustBalanceReqCopyWith(
          AdjustBalanceReq value, $Res Function(AdjustBalanceReq) then) =
      _$AdjustBalanceReqCopyWithImpl<$Res, AdjustBalanceReq>;
  @useResult
  $Res call({String amount, int type, String? remark, int? version});
}
class _$AdjustBalanceReqCopyWithImpl<$Res, $Val extends AdjustBalanceReq>
    implements $AdjustBalanceReqCopyWith<$Res> {
  _$AdjustBalanceReqCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? type = null,
    Object? remark = freezed,
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount 
              as String,
      type: null == type
          ? _value.type
          : type 
              as int,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      version: freezed == version
          ? _value.version
          : version 
              as int?,
    ) as $Val);
  }
}
abstract class _$$AdjustBalanceReqImplCopyWith<$Res>
    implements $AdjustBalanceReqCopyWith<$Res> {
  factory _$$AdjustBalanceReqImplCopyWith(_$AdjustBalanceReqImpl value,
          $Res Function(_$AdjustBalanceReqImpl) then) =
      __$$AdjustBalanceReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String amount, int type, String? remark, int? version});
}
class __$$AdjustBalanceReqImplCopyWithImpl<$Res>
    extends _$AdjustBalanceReqCopyWithImpl<$Res, _$AdjustBalanceReqImpl>
    implements _$$AdjustBalanceReqImplCopyWith<$Res> {
  __$$AdjustBalanceReqImplCopyWithImpl(_$AdjustBalanceReqImpl _value,
      $Res Function(_$AdjustBalanceReqImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? type = null,
    Object? remark = freezed,
    Object? version = freezed,
  }) {
    return _then(_$AdjustBalanceReqImpl(
      amount: null == amount
          ? _value.amount
          : amount 
              as String,
      type: null == type
          ? _value.type
          : type 
              as int,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      version: freezed == version
          ? _value.version
          : version 
              as int?,
    ));
  }
}
@JsonSerializable()
class _$AdjustBalanceReqImpl implements _AdjustBalanceReq {
  const _$AdjustBalanceReqImpl(
      {required this.amount, required this.type, this.remark, this.version});
  factory _$AdjustBalanceReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdjustBalanceReqImplFromJson(json);
  @override
  final String amount;
  @override
  final int type;
  @override
  final String? remark;
  @override
  final int? version;
  @override
  String toString() {
    return 'AdjustBalanceReq(amount: $amount, type: $type, remark: $remark, version: $version)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdjustBalanceReqImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.version, version) || other.version == version));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, type, remark, version);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdjustBalanceReqImplCopyWith<_$AdjustBalanceReqImpl> get copyWith =>
      __$$AdjustBalanceReqImplCopyWithImpl<_$AdjustBalanceReqImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$AdjustBalanceReqImplToJson(
      this,
    );
  }
}
abstract class _AdjustBalanceReq implements AdjustBalanceReq {
  const factory _AdjustBalanceReq(
      {required final String amount,
      required final int type,
      final String? remark,
      final int? version}) = _$AdjustBalanceReqImpl;
  factory _AdjustBalanceReq.fromJson(Map<String, dynamic> json) =
      _$AdjustBalanceReqImpl.fromJson;
  @override
  String get amount;
  @override
  int get type;
  @override
  String? get remark;
  @override
  int? get version;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdjustBalanceReqImplCopyWith<_$AdjustBalanceReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
CreateRechargeOrderReq _$CreateRechargeOrderReqFromJson(
    Map<String, dynamic> json) {
  return _CreateRechargeOrderReq.fromJson(json);
}
mixin _$CreateRechargeOrderReq {
  int get memberId => throw _privateConstructorUsedError;
  String get payAmount => throw _privateConstructorUsedError;
  String? get giftAmount => throw _privateConstructorUsedError;
  int get payType => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateRechargeOrderReqCopyWith<CreateRechargeOrderReq> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $CreateRechargeOrderReqCopyWith<$Res> {
  factory $CreateRechargeOrderReqCopyWith(CreateRechargeOrderReq value,
          $Res Function(CreateRechargeOrderReq) then) =
      _$CreateRechargeOrderReqCopyWithImpl<$Res, CreateRechargeOrderReq>;
  @useResult
  $Res call(
      {int memberId,
      String payAmount,
      String? giftAmount,
      int payType,
      String? remark});
}
class _$CreateRechargeOrderReqCopyWithImpl<$Res,
        $Val extends CreateRechargeOrderReq>
    implements $CreateRechargeOrderReqCopyWith<$Res> {
  _$CreateRechargeOrderReqCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? payAmount = null,
    Object? giftAmount = freezed,
    Object? payType = null,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      memberId: null == memberId
          ? _value.memberId
          : memberId 
              as int,
      payAmount: null == payAmount
          ? _value.payAmount
          : payAmount 
              as String,
      giftAmount: freezed == giftAmount
          ? _value.giftAmount
          : giftAmount 
              as String?,
      payType: null == payType
          ? _value.payType
          : payType 
              as int,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ) as $Val);
  }
}
abstract class _$$CreateRechargeOrderReqImplCopyWith<$Res>
    implements $CreateRechargeOrderReqCopyWith<$Res> {
  factory _$$CreateRechargeOrderReqImplCopyWith(
          _$CreateRechargeOrderReqImpl value,
          $Res Function(_$CreateRechargeOrderReqImpl) then) =
      __$$CreateRechargeOrderReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int memberId,
      String payAmount,
      String? giftAmount,
      int payType,
      String? remark});
}
class __$$CreateRechargeOrderReqImplCopyWithImpl<$Res>
    extends _$CreateRechargeOrderReqCopyWithImpl<$Res,
        _$CreateRechargeOrderReqImpl>
    implements _$$CreateRechargeOrderReqImplCopyWith<$Res> {
  __$$CreateRechargeOrderReqImplCopyWithImpl(
      _$CreateRechargeOrderReqImpl _value,
      $Res Function(_$CreateRechargeOrderReqImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? payAmount = null,
    Object? giftAmount = freezed,
    Object? payType = null,
    Object? remark = freezed,
  }) {
    return _then(_$CreateRechargeOrderReqImpl(
      memberId: null == memberId
          ? _value.memberId
          : memberId 
              as int,
      payAmount: null == payAmount
          ? _value.payAmount
          : payAmount 
              as String,
      giftAmount: freezed == giftAmount
          ? _value.giftAmount
          : giftAmount 
              as String?,
      payType: null == payType
          ? _value.payType
          : payType 
              as int,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$CreateRechargeOrderReqImpl implements _CreateRechargeOrderReq {
  const _$CreateRechargeOrderReqImpl(
      {required this.memberId,
      required this.payAmount,
      this.giftAmount,
      required this.payType,
      this.remark});
  factory _$CreateRechargeOrderReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateRechargeOrderReqImplFromJson(json);
  @override
  final int memberId;
  @override
  final String payAmount;
  @override
  final String? giftAmount;
  @override
  final int payType;
  @override
  final String? remark;
  @override
  String toString() {
    return 'CreateRechargeOrderReq(memberId: $memberId, payAmount: $payAmount, giftAmount: $giftAmount, payType: $payType, remark: $remark)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateRechargeOrderReqImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.payAmount, payAmount) ||
                other.payAmount == payAmount) &&
            (identical(other.giftAmount, giftAmount) ||
                other.giftAmount == giftAmount) &&
            (identical(other.payType, payType) || other.payType == payType) &&
            (identical(other.remark, remark) || other.remark == remark));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, memberId, payAmount, giftAmount, payType, remark);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateRechargeOrderReqImplCopyWith<_$CreateRechargeOrderReqImpl>
      get copyWith => __$$CreateRechargeOrderReqImplCopyWithImpl<
          _$CreateRechargeOrderReqImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$CreateRechargeOrderReqImplToJson(
      this,
    );
  }
}
abstract class _CreateRechargeOrderReq implements CreateRechargeOrderReq {
  const factory _CreateRechargeOrderReq(
      {required final int memberId,
      required final String payAmount,
      final String? giftAmount,
      required final int payType,
      final String? remark}) = _$CreateRechargeOrderReqImpl;
  factory _CreateRechargeOrderReq.fromJson(Map<String, dynamic> json) =
      _$CreateRechargeOrderReqImpl.fromJson;
  @override
  int get memberId;
  @override
  String get payAmount;
  @override
  String? get giftAmount;
  @override
  int get payType;
  @override
  String? get remark;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateRechargeOrderReqImplCopyWith<_$CreateRechargeOrderReqImpl>
      get copyWith => throw _privateConstructorUsedError;
}
PayRechargeOrderReq _$PayRechargeOrderReqFromJson(Map<String, dynamic> json) {
  return _PayRechargeOrderReq.fromJson(json);
}
mixin _$PayRechargeOrderReq {
  String get orderNo => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayRechargeOrderReqCopyWith<PayRechargeOrderReq> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $PayRechargeOrderReqCopyWith<$Res> {
  factory $PayRechargeOrderReqCopyWith(
          PayRechargeOrderReq value, $Res Function(PayRechargeOrderReq) then) =
      _$PayRechargeOrderReqCopyWithImpl<$Res, PayRechargeOrderReq>;
  @useResult
  $Res call({String orderNo});
}
class _$PayRechargeOrderReqCopyWithImpl<$Res, $Val extends PayRechargeOrderReq>
    implements $PayRechargeOrderReqCopyWith<$Res> {
  _$PayRechargeOrderReqCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNo = null,
  }) {
    return _then(_value.copyWith(
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo 
              as String,
    ) as $Val);
  }
}
abstract class _$$PayRechargeOrderReqImplCopyWith<$Res>
    implements $PayRechargeOrderReqCopyWith<$Res> {
  factory _$$PayRechargeOrderReqImplCopyWith(_$PayRechargeOrderReqImpl value,
          $Res Function(_$PayRechargeOrderReqImpl) then) =
      __$$PayRechargeOrderReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String orderNo});
}
class __$$PayRechargeOrderReqImplCopyWithImpl<$Res>
    extends _$PayRechargeOrderReqCopyWithImpl<$Res, _$PayRechargeOrderReqImpl>
    implements _$$PayRechargeOrderReqImplCopyWith<$Res> {
  __$$PayRechargeOrderReqImplCopyWithImpl(_$PayRechargeOrderReqImpl _value,
      $Res Function(_$PayRechargeOrderReqImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNo = null,
  }) {
    return _then(_$PayRechargeOrderReqImpl(
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo 
              as String,
    ));
  }
}
@JsonSerializable()
class _$PayRechargeOrderReqImpl implements _PayRechargeOrderReq {
  const _$PayRechargeOrderReqImpl({required this.orderNo});
  factory _$PayRechargeOrderReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayRechargeOrderReqImplFromJson(json);
  @override
  final String orderNo;
  @override
  String toString() {
    return 'PayRechargeOrderReq(orderNo: $orderNo)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayRechargeOrderReqImpl &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, orderNo);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayRechargeOrderReqImplCopyWith<_$PayRechargeOrderReqImpl> get copyWith =>
      __$$PayRechargeOrderReqImplCopyWithImpl<_$PayRechargeOrderReqImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$PayRechargeOrderReqImplToJson(
      this,
    );
  }
}
abstract class _PayRechargeOrderReq implements PayRechargeOrderReq {
  const factory _PayRechargeOrderReq({required final String orderNo}) =
      _$PayRechargeOrderReqImpl;
  factory _PayRechargeOrderReq.fromJson(Map<String, dynamic> json) =
      _$PayRechargeOrderReqImpl.fromJson;
  @override
  String get orderNo;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayRechargeOrderReqImplCopyWith<_$PayRechargeOrderReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
ListWalletLogReq _$ListWalletLogReqFromJson(Map<String, dynamic> json) {
  return _ListWalletLogReq.fromJson(json);
}
mixin _$ListWalletLogReq {
  int? get memberId => throw _privateConstructorUsedError;
  int? get changeType => throw _privateConstructorUsedError;
  String? get startTime => throw _privateConstructorUsedError;
  String? get endTime => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListWalletLogReqCopyWith<ListWalletLogReq> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $ListWalletLogReqCopyWith<$Res> {
  factory $ListWalletLogReqCopyWith(
          ListWalletLogReq value, $Res Function(ListWalletLogReq) then) =
      _$ListWalletLogReqCopyWithImpl<$Res, ListWalletLogReq>;
  @useResult
  $Res call(
      {int? memberId,
      int? changeType,
      String? startTime,
      String? endTime,
      int? page,
      int? pageSize});
}
class _$ListWalletLogReqCopyWithImpl<$Res, $Val extends ListWalletLogReq>
    implements $ListWalletLogReqCopyWith<$Res> {
  _$ListWalletLogReqCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = freezed,
    Object? changeType = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_value.copyWith(
      memberId: freezed == memberId
          ? _value.memberId
          : memberId 
              as int?,
      changeType: freezed == changeType
          ? _value.changeType
          : changeType 
              as int?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime 
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime 
              as String?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ) as $Val);
  }
}
abstract class _$$ListWalletLogReqImplCopyWith<$Res>
    implements $ListWalletLogReqCopyWith<$Res> {
  factory _$$ListWalletLogReqImplCopyWith(_$ListWalletLogReqImpl value,
          $Res Function(_$ListWalletLogReqImpl) then) =
      __$$ListWalletLogReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? memberId,
      int? changeType,
      String? startTime,
      String? endTime,
      int? page,
      int? pageSize});
}
class __$$ListWalletLogReqImplCopyWithImpl<$Res>
    extends _$ListWalletLogReqCopyWithImpl<$Res, _$ListWalletLogReqImpl>
    implements _$$ListWalletLogReqImplCopyWith<$Res> {
  __$$ListWalletLogReqImplCopyWithImpl(_$ListWalletLogReqImpl _value,
      $Res Function(_$ListWalletLogReqImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = freezed,
    Object? changeType = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$ListWalletLogReqImpl(
      memberId: freezed == memberId
          ? _value.memberId
          : memberId 
              as int?,
      changeType: freezed == changeType
          ? _value.changeType
          : changeType 
              as int?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime 
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime 
              as String?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ));
  }
}
@JsonSerializable()
class _$ListWalletLogReqImpl implements _ListWalletLogReq {
  const _$ListWalletLogReqImpl(
      {this.memberId,
      this.changeType,
      this.startTime,
      this.endTime,
      this.page,
      this.pageSize});
  factory _$ListWalletLogReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListWalletLogReqImplFromJson(json);
  @override
  final int? memberId;
  @override
  final int? changeType;
  @override
  final String? startTime;
  @override
  final String? endTime;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  String toString() {
    return 'ListWalletLogReq(memberId: $memberId, changeType: $changeType, startTime: $startTime, endTime: $endTime, page: $page, pageSize: $pageSize)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListWalletLogReqImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.changeType, changeType) ||
                other.changeType == changeType) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, memberId, changeType, startTime, endTime, page, pageSize);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListWalletLogReqImplCopyWith<_$ListWalletLogReqImpl> get copyWith =>
      __$$ListWalletLogReqImplCopyWithImpl<_$ListWalletLogReqImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$ListWalletLogReqImplToJson(
      this,
    );
  }
}
abstract class _ListWalletLogReq implements ListWalletLogReq {
  const factory _ListWalletLogReq(
      {final int? memberId,
      final int? changeType,
      final String? startTime,
      final String? endTime,
      final int? page,
      final int? pageSize}) = _$ListWalletLogReqImpl;
  factory _ListWalletLogReq.fromJson(Map<String, dynamic> json) =
      _$ListWalletLogReqImpl.fromJson;
  @override
  int? get memberId;
  @override
  int? get changeType;
  @override
  String? get startTime;
  @override
  String? get endTime;
  @override
  int? get page;
  @override
  int? get pageSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListWalletLogReqImplCopyWith<_$ListWalletLogReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
ListRechargeOrderReq _$ListRechargeOrderReqFromJson(Map<String, dynamic> json) {
  return _ListRechargeOrderReq.fromJson(json);
}
mixin _$ListRechargeOrderReq {
  int? get memberId => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListRechargeOrderReqCopyWith<ListRechargeOrderReq> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $ListRechargeOrderReqCopyWith<$Res> {
  factory $ListRechargeOrderReqCopyWith(ListRechargeOrderReq value,
          $Res Function(ListRechargeOrderReq) then) =
      _$ListRechargeOrderReqCopyWithImpl<$Res, ListRechargeOrderReq>;
  @useResult
  $Res call({int? memberId, int? status, int? page, int? pageSize});
}
class _$ListRechargeOrderReqCopyWithImpl<$Res,
        $Val extends ListRechargeOrderReq>
    implements $ListRechargeOrderReqCopyWith<$Res> {
  _$ListRechargeOrderReqCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = freezed,
    Object? status = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_value.copyWith(
      memberId: freezed == memberId
          ? _value.memberId
          : memberId 
              as int?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ) as $Val);
  }
}
abstract class _$$ListRechargeOrderReqImplCopyWith<$Res>
    implements $ListRechargeOrderReqCopyWith<$Res> {
  factory _$$ListRechargeOrderReqImplCopyWith(_$ListRechargeOrderReqImpl value,
          $Res Function(_$ListRechargeOrderReqImpl) then) =
      __$$ListRechargeOrderReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? memberId, int? status, int? page, int? pageSize});
}
class __$$ListRechargeOrderReqImplCopyWithImpl<$Res>
    extends _$ListRechargeOrderReqCopyWithImpl<$Res, _$ListRechargeOrderReqImpl>
    implements _$$ListRechargeOrderReqImplCopyWith<$Res> {
  __$$ListRechargeOrderReqImplCopyWithImpl(_$ListRechargeOrderReqImpl _value,
      $Res Function(_$ListRechargeOrderReqImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = freezed,
    Object? status = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$ListRechargeOrderReqImpl(
      memberId: freezed == memberId
          ? _value.memberId
          : memberId 
              as int?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ));
  }
}
@JsonSerializable()
class _$ListRechargeOrderReqImpl implements _ListRechargeOrderReq {
  const _$ListRechargeOrderReqImpl(
      {this.memberId, this.status, this.page, this.pageSize});
  factory _$ListRechargeOrderReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListRechargeOrderReqImplFromJson(json);
  @override
  final int? memberId;
  @override
  final int? status;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  String toString() {
    return 'ListRechargeOrderReq(memberId: $memberId, status: $status, page: $page, pageSize: $pageSize)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListRechargeOrderReqImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, memberId, status, page, pageSize);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListRechargeOrderReqImplCopyWith<_$ListRechargeOrderReqImpl>
      get copyWith =>
          __$$ListRechargeOrderReqImplCopyWithImpl<_$ListRechargeOrderReqImpl>(
              this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$ListRechargeOrderReqImplToJson(
      this,
    );
  }
}
abstract class _ListRechargeOrderReq implements ListRechargeOrderReq {
  const factory _ListRechargeOrderReq(
      {final int? memberId,
      final int? status,
      final int? page,
      final int? pageSize}) = _$ListRechargeOrderReqImpl;
  factory _ListRechargeOrderReq.fromJson(Map<String, dynamic> json) =
      _$ListRechargeOrderReqImpl.fromJson;
  @override
  int? get memberId;
  @override
  int? get status;
  @override
  int? get page;
  @override
  int? get pageSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListRechargeOrderReqImplCopyWith<_$ListRechargeOrderReqImpl>
      get copyWith => throw _privateConstructorUsedError;
}
MemberListResp _$MemberListRespFromJson(Map<String, dynamic> json) {
  return _MemberListResp.fromJson(json);
}
mixin _$MemberListResp {
  List<Member> get list => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int? get pageSize => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberListRespCopyWith<MemberListResp> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $MemberListRespCopyWith<$Res> {
  factory $MemberListRespCopyWith(
          MemberListResp value, $Res Function(MemberListResp) then) =
      _$MemberListRespCopyWithImpl<$Res, MemberListResp>;
  @useResult
  $Res call(
      {List<Member> list,
      @JsonKey(name: 'total') int? total,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'page_size') int? pageSize});
}
class _$MemberListRespCopyWithImpl<$Res, $Val extends MemberListResp>
    implements $MemberListRespCopyWith<$Res> {
  _$MemberListRespCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list 
              as List<Member>,
      total: freezed == total
          ? _value.total
          : total 
              as int?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ) as $Val);
  }
}
abstract class _$$MemberListRespImplCopyWith<$Res>
    implements $MemberListRespCopyWith<$Res> {
  factory _$$MemberListRespImplCopyWith(_$MemberListRespImpl value,
          $Res Function(_$MemberListRespImpl) then) =
      __$$MemberListRespImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Member> list,
      @JsonKey(name: 'total') int? total,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'page_size') int? pageSize});
}
class __$$MemberListRespImplCopyWithImpl<$Res>
    extends _$MemberListRespCopyWithImpl<$Res, _$MemberListRespImpl>
    implements _$$MemberListRespImplCopyWith<$Res> {
  __$$MemberListRespImplCopyWithImpl(
      _$MemberListRespImpl _value, $Res Function(_$MemberListRespImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$MemberListRespImpl(
      list: null == list
          ? _value._list
          : list 
              as List<Member>,
      total: freezed == total
          ? _value.total
          : total 
              as int?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ));
  }
}
@JsonSerializable()
class _$MemberListRespImpl implements _MemberListResp {
  const _$MemberListRespImpl(
      {required final List<Member> list,
      @JsonKey(name: 'total') this.total,
      @JsonKey(name: 'page') this.page,
      @JsonKey(name: 'page_size') this.pageSize})
      : _list = list;
  factory _$MemberListRespImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberListRespImplFromJson(json);
  final List<Member> _list;
  @override
  List<Member> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    return EqualUnmodifiableListView(_list);
  }
  @override
  @JsonKey(name: 'total')
  final int? total;
  @override
  @JsonKey(name: 'page')
  final int? page;
  @override
  @JsonKey(name: 'page_size')
  final int? pageSize;
  @override
  String toString() {
    return 'MemberListResp(list: $list, total: $total, page: $page, pageSize: $pageSize)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberListRespImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_list), total, page, pageSize);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberListRespImplCopyWith<_$MemberListRespImpl> get copyWith =>
      __$$MemberListRespImplCopyWithImpl<_$MemberListRespImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$MemberListRespImplToJson(
      this,
    );
  }
}
abstract class _MemberListResp implements MemberListResp {
  const factory _MemberListResp(
      {required final List<Member> list,
      @JsonKey(name: 'total') final int? total,
      @JsonKey(name: 'page') final int? page,
      @JsonKey(name: 'page_size') final int? pageSize}) = _$MemberListRespImpl;
  factory _MemberListResp.fromJson(Map<String, dynamic> json) =
      _$MemberListRespImpl.fromJson;
  @override
  List<Member> get list;
  @override
  @JsonKey(name: 'total')
  int? get total;
  @override
  @JsonKey(name: 'page')
  int? get page;
  @override
  @JsonKey(name: 'page_size')
  int? get pageSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberListRespImplCopyWith<_$MemberListRespImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
WalletLogListResp _$WalletLogListRespFromJson(Map<String, dynamic> json) {
  return _WalletLogListResp.fromJson(json);
}
mixin _$WalletLogListResp {
  List<WalletLog> get list => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int? get pageSize => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletLogListRespCopyWith<WalletLogListResp> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $WalletLogListRespCopyWith<$Res> {
  factory $WalletLogListRespCopyWith(
          WalletLogListResp value, $Res Function(WalletLogListResp) then) =
      _$WalletLogListRespCopyWithImpl<$Res, WalletLogListResp>;
  @useResult
  $Res call(
      {List<WalletLog> list,
      @JsonKey(name: 'total') int? total,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'page_size') int? pageSize});
}
class _$WalletLogListRespCopyWithImpl<$Res, $Val extends WalletLogListResp>
    implements $WalletLogListRespCopyWith<$Res> {
  _$WalletLogListRespCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list 
              as List<WalletLog>,
      total: freezed == total
          ? _value.total
          : total 
              as int?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ) as $Val);
  }
}
abstract class _$$WalletLogListRespImplCopyWith<$Res>
    implements $WalletLogListRespCopyWith<$Res> {
  factory _$$WalletLogListRespImplCopyWith(_$WalletLogListRespImpl value,
          $Res Function(_$WalletLogListRespImpl) then) =
      __$$WalletLogListRespImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<WalletLog> list,
      @JsonKey(name: 'total') int? total,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'page_size') int? pageSize});
}
class __$$WalletLogListRespImplCopyWithImpl<$Res>
    extends _$WalletLogListRespCopyWithImpl<$Res, _$WalletLogListRespImpl>
    implements _$$WalletLogListRespImplCopyWith<$Res> {
  __$$WalletLogListRespImplCopyWithImpl(_$WalletLogListRespImpl _value,
      $Res Function(_$WalletLogListRespImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$WalletLogListRespImpl(
      list: null == list
          ? _value._list
          : list 
              as List<WalletLog>,
      total: freezed == total
          ? _value.total
          : total 
              as int?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ));
  }
}
@JsonSerializable()
class _$WalletLogListRespImpl implements _WalletLogListResp {
  const _$WalletLogListRespImpl(
      {required final List<WalletLog> list,
      @JsonKey(name: 'total') this.total,
      @JsonKey(name: 'page') this.page,
      @JsonKey(name: 'page_size') this.pageSize})
      : _list = list;
  factory _$WalletLogListRespImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletLogListRespImplFromJson(json);
  final List<WalletLog> _list;
  @override
  List<WalletLog> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    return EqualUnmodifiableListView(_list);
  }
  @override
  @JsonKey(name: 'total')
  final int? total;
  @override
  @JsonKey(name: 'page')
  final int? page;
  @override
  @JsonKey(name: 'page_size')
  final int? pageSize;
  @override
  String toString() {
    return 'WalletLogListResp(list: $list, total: $total, page: $page, pageSize: $pageSize)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletLogListRespImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_list), total, page, pageSize);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletLogListRespImplCopyWith<_$WalletLogListRespImpl> get copyWith =>
      __$$WalletLogListRespImplCopyWithImpl<_$WalletLogListRespImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$WalletLogListRespImplToJson(
      this,
    );
  }
}
abstract class _WalletLogListResp implements WalletLogListResp {
  const factory _WalletLogListResp(
          {required final List<WalletLog> list,
          @JsonKey(name: 'total') final int? total,
          @JsonKey(name: 'page') final int? page,
          @JsonKey(name: 'page_size') final int? pageSize}) =
      _$WalletLogListRespImpl;
  factory _WalletLogListResp.fromJson(Map<String, dynamic> json) =
      _$WalletLogListRespImpl.fromJson;
  @override
  List<WalletLog> get list;
  @override
  @JsonKey(name: 'total')
  int? get total;
  @override
  @JsonKey(name: 'page')
  int? get page;
  @override
  @JsonKey(name: 'page_size')
  int? get pageSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletLogListRespImplCopyWith<_$WalletLogListRespImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
RechargeOrderListResp _$RechargeOrderListRespFromJson(
    Map<String, dynamic> json) {
  return _RechargeOrderListResp.fromJson(json);
}
mixin _$RechargeOrderListResp {
  List<RechargeOrder> get list => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int? get pageSize => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RechargeOrderListRespCopyWith<RechargeOrderListResp> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $RechargeOrderListRespCopyWith<$Res> {
  factory $RechargeOrderListRespCopyWith(RechargeOrderListResp value,
          $Res Function(RechargeOrderListResp) then) =
      _$RechargeOrderListRespCopyWithImpl<$Res, RechargeOrderListResp>;
  @useResult
  $Res call(
      {List<RechargeOrder> list,
      @JsonKey(name: 'total') int? total,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'page_size') int? pageSize});
}
class _$RechargeOrderListRespCopyWithImpl<$Res,
        $Val extends RechargeOrderListResp>
    implements $RechargeOrderListRespCopyWith<$Res> {
  _$RechargeOrderListRespCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list 
              as List<RechargeOrder>,
      total: freezed == total
          ? _value.total
          : total 
              as int?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ) as $Val);
  }
}
abstract class _$$RechargeOrderListRespImplCopyWith<$Res>
    implements $RechargeOrderListRespCopyWith<$Res> {
  factory _$$RechargeOrderListRespImplCopyWith(
          _$RechargeOrderListRespImpl value,
          $Res Function(_$RechargeOrderListRespImpl) then) =
      __$$RechargeOrderListRespImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RechargeOrder> list,
      @JsonKey(name: 'total') int? total,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'page_size') int? pageSize});
}
class __$$RechargeOrderListRespImplCopyWithImpl<$Res>
    extends _$RechargeOrderListRespCopyWithImpl<$Res,
        _$RechargeOrderListRespImpl>
    implements _$$RechargeOrderListRespImplCopyWith<$Res> {
  __$$RechargeOrderListRespImplCopyWithImpl(_$RechargeOrderListRespImpl _value,
      $Res Function(_$RechargeOrderListRespImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$RechargeOrderListRespImpl(
      list: null == list
          ? _value._list
          : list 
              as List<RechargeOrder>,
      total: freezed == total
          ? _value.total
          : total 
              as int?,
      page: freezed == page
          ? _value.page
          : page 
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize 
              as int?,
    ));
  }
}
@JsonSerializable()
class _$RechargeOrderListRespImpl implements _RechargeOrderListResp {
  const _$RechargeOrderListRespImpl(
      {required final List<RechargeOrder> list,
      @JsonKey(name: 'total') this.total,
      @JsonKey(name: 'page') this.page,
      @JsonKey(name: 'page_size') this.pageSize})
      : _list = list;
  factory _$RechargeOrderListRespImpl.fromJson(Map<String, dynamic> json) =>
      _$$RechargeOrderListRespImplFromJson(json);
  final List<RechargeOrder> _list;
  @override
  List<RechargeOrder> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    return EqualUnmodifiableListView(_list);
  }
  @override
  @JsonKey(name: 'total')
  final int? total;
  @override
  @JsonKey(name: 'page')
  final int? page;
  @override
  @JsonKey(name: 'page_size')
  final int? pageSize;
  @override
  String toString() {
    return 'RechargeOrderListResp(list: $list, total: $total, page: $page, pageSize: $pageSize)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RechargeOrderListRespImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_list), total, page, pageSize);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RechargeOrderListRespImplCopyWith<_$RechargeOrderListRespImpl>
      get copyWith => __$$RechargeOrderListRespImplCopyWithImpl<
          _$RechargeOrderListRespImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$RechargeOrderListRespImplToJson(
      this,
    );
  }
}
abstract class _RechargeOrderListResp implements RechargeOrderListResp {
  const factory _RechargeOrderListResp(
          {required final List<RechargeOrder> list,
          @JsonKey(name: 'total') final int? total,
          @JsonKey(name: 'page') final int? page,
          @JsonKey(name: 'page_size') final int? pageSize}) =
      _$RechargeOrderListRespImpl;
  factory _RechargeOrderListResp.fromJson(Map<String, dynamic> json) =
      _$RechargeOrderListRespImpl.fromJson;
  @override
  List<RechargeOrder> get list;
  @override
  @JsonKey(name: 'total')
  int? get total;
  @override
  @JsonKey(name: 'page')
  int? get page;
  @override
  @JsonKey(name: 'page_size')
  int? get pageSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RechargeOrderListRespImplCopyWith<_$RechargeOrderListRespImpl>
      get copyWith => throw _privateConstructorUsedError;
}
