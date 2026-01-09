part of 'models.dart';
T _$identity<T>(T value) => value;
final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https:
Member _$MemberFromJson(Map<String, dynamic> json) {
  return _Member.fromJson(json);
}
mixin _$Member {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'level_id')
  int? get levelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'level_name')
  String? get levelName => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance')
  double? get balance => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_recharge')
  double? get totalRecharge => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_consume')
  double? get totalConsume => throw _privateConstructorUsedError;
  @JsonKey(name: 'points')
  int? get points => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int? get status => throw _privateConstructorUsedError;
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
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'level_id') int? levelId,
      @JsonKey(name: 'level_name') String? levelName,
      @JsonKey(name: 'balance') double? balance,
      @JsonKey(name: 'total_recharge') double? totalRecharge,
      @JsonKey(name: 'total_consume') double? totalConsume,
      @JsonKey(name: 'points') int? points,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'status') int? status,
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
    Object? name = freezed,
    Object? phone = freezed,
    Object? levelId = freezed,
    Object? levelName = freezed,
    Object? balance = freezed,
    Object? totalRecharge = freezed,
    Object? totalConsume = freezed,
    Object? points = freezed,
    Object? remark = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
              as double?,
      totalRecharge: freezed == totalRecharge
          ? _value.totalRecharge
          : totalRecharge 
              as double?,
      totalConsume: freezed == totalConsume
          ? _value.totalConsume
          : totalConsume 
              as double?,
      points: freezed == points
          ? _value.points
          : points 
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      status: freezed == status
          ? _value.status
          : status 
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
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'level_id') int? levelId,
      @JsonKey(name: 'level_name') String? levelName,
      @JsonKey(name: 'balance') double? balance,
      @JsonKey(name: 'total_recharge') double? totalRecharge,
      @JsonKey(name: 'total_consume') double? totalConsume,
      @JsonKey(name: 'points') int? points,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'status') int? status,
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
    Object? name = freezed,
    Object? phone = freezed,
    Object? levelId = freezed,
    Object? levelName = freezed,
    Object? balance = freezed,
    Object? totalRecharge = freezed,
    Object? totalConsume = freezed,
    Object? points = freezed,
    Object? remark = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MemberImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
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
              as double?,
      totalRecharge: freezed == totalRecharge
          ? _value.totalRecharge
          : totalRecharge 
              as double?,
      totalConsume: freezed == totalConsume
          ? _value.totalConsume
          : totalConsume 
              as double?,
      points: freezed == points
          ? _value.points
          : points 
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      status: freezed == status
          ? _value.status
          : status 
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
class _$MemberImpl with DiagnosticableTreeMixin implements _Member {
  const _$MemberImpl(
      {required this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'phone') this.phone,
      @JsonKey(name: 'level_id') this.levelId,
      @JsonKey(name: 'level_name') this.levelName,
      @JsonKey(name: 'balance') this.balance,
      @JsonKey(name: 'total_recharge') this.totalRecharge,
      @JsonKey(name: 'total_consume') this.totalConsume,
      @JsonKey(name: 'points') this.points,
      @JsonKey(name: 'remark') this.remark,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});
  factory _$MemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberImplFromJson(json);
  @override
  final int id;
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
  final double? balance;
  @override
  @JsonKey(name: 'total_recharge')
  final double? totalRecharge;
  @override
  @JsonKey(name: 'total_consume')
  final double? totalConsume;
  @override
  @JsonKey(name: 'points')
  final int? points;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  @JsonKey(name: 'status')
  final int? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Member(id: $id, name: $name, phone: $phone, levelId: $levelId, levelName: $levelName, balance: $balance, totalRecharge: $totalRecharge, totalConsume: $totalConsume, points: $points, remark: $remark, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Member'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('levelId', levelId))
      ..add(DiagnosticsProperty('levelName', levelName))
      ..add(DiagnosticsProperty('balance', balance))
      ..add(DiagnosticsProperty('totalRecharge', totalRecharge))
      ..add(DiagnosticsProperty('totalConsume', totalConsume))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('remark', remark))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.levelId, levelId) || other.levelId == levelId) &&
            (identical(other.levelName, levelName) ||
                other.levelName == levelName) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.totalRecharge, totalRecharge) ||
                other.totalRecharge == totalRecharge) &&
            (identical(other.totalConsume, totalConsume) ||
                other.totalConsume == totalConsume) &&
            (identical(other.points, points) || other.points == points) &&
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
      name,
      phone,
      levelId,
      levelName,
      balance,
      totalRecharge,
      totalConsume,
      points,
      remark,
      status,
      createdAt,
      updatedAt);
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
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'phone') final String? phone,
      @JsonKey(name: 'level_id') final int? levelId,
      @JsonKey(name: 'level_name') final String? levelName,
      @JsonKey(name: 'balance') final double? balance,
      @JsonKey(name: 'total_recharge') final double? totalRecharge,
      @JsonKey(name: 'total_consume') final double? totalConsume,
      @JsonKey(name: 'points') final int? points,
      @JsonKey(name: 'remark') final String? remark,
      @JsonKey(name: 'status') final int? status,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$MemberImpl;
  factory _Member.fromJson(Map<String, dynamic> json) = _$MemberImpl.fromJson;
  @override
  int get id;
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
  double? get balance;
  @override
  @JsonKey(name: 'total_recharge')
  double? get totalRecharge;
  @override
  @JsonKey(name: 'total_consume')
  double? get totalConsume;
  @override
  @JsonKey(name: 'points')
  int? get points;
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(name: 'status')
  int? get status;
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
CreateMemberRequest _$CreateMemberRequestFromJson(Map<String, dynamic> json) {
  return _CreateMemberRequest.fromJson(json);
}
mixin _$CreateMemberRequest {
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'level_id')
  int? get levelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateMemberRequestCopyWith<CreateMemberRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $CreateMemberRequestCopyWith<$Res> {
  factory $CreateMemberRequestCopyWith(
          CreateMemberRequest value, $Res Function(CreateMemberRequest) then) =
      _$CreateMemberRequestCopyWithImpl<$Res, CreateMemberRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'phone') String phone,
      @JsonKey(name: 'level_id') int? levelId,
      @JsonKey(name: 'remark') String? remark});
}
class _$CreateMemberRequestCopyWithImpl<$Res, $Val extends CreateMemberRequest>
    implements $CreateMemberRequestCopyWith<$Res> {
  _$CreateMemberRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phone = null,
    Object? levelId = freezed,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
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
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ) as $Val);
  }
}
abstract class _$$CreateMemberRequestImplCopyWith<$Res>
    implements $CreateMemberRequestCopyWith<$Res> {
  factory _$$CreateMemberRequestImplCopyWith(_$CreateMemberRequestImpl value,
          $Res Function(_$CreateMemberRequestImpl) then) =
      __$$CreateMemberRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'phone') String phone,
      @JsonKey(name: 'level_id') int? levelId,
      @JsonKey(name: 'remark') String? remark});
}
class __$$CreateMemberRequestImplCopyWithImpl<$Res>
    extends _$CreateMemberRequestCopyWithImpl<$Res, _$CreateMemberRequestImpl>
    implements _$$CreateMemberRequestImplCopyWith<$Res> {
  __$$CreateMemberRequestImplCopyWithImpl(_$CreateMemberRequestImpl _value,
      $Res Function(_$CreateMemberRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phone = null,
    Object? levelId = freezed,
    Object? remark = freezed,
  }) {
    return _then(_$CreateMemberRequestImpl(
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
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$CreateMemberRequestImpl
    with DiagnosticableTreeMixin
    implements _CreateMemberRequest {
  const _$CreateMemberRequestImpl(
      {@JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'phone') required this.phone,
      @JsonKey(name: 'level_id') this.levelId,
      @JsonKey(name: 'remark') this.remark});
  factory _$CreateMemberRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateMemberRequestImplFromJson(json);
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'phone')
  final String phone;
  @override
  @JsonKey(name: 'level_id')
  final int? levelId;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateMemberRequest(name: $name, phone: $phone, levelId: $levelId, remark: $remark)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateMemberRequest'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('levelId', levelId))
      ..add(DiagnosticsProperty('remark', remark));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateMemberRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.levelId, levelId) || other.levelId == levelId) &&
            (identical(other.remark, remark) || other.remark == remark));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, phone, levelId, remark);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateMemberRequestImplCopyWith<_$CreateMemberRequestImpl> get copyWith =>
      __$$CreateMemberRequestImplCopyWithImpl<_$CreateMemberRequestImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$CreateMemberRequestImplToJson(
      this,
    );
  }
}
abstract class _CreateMemberRequest implements CreateMemberRequest {
  const factory _CreateMemberRequest(
          {@JsonKey(name: 'name') required final String name,
          @JsonKey(name: 'phone') required final String phone,
          @JsonKey(name: 'level_id') final int? levelId,
          @JsonKey(name: 'remark') final String? remark}) =
      _$CreateMemberRequestImpl;
  factory _CreateMemberRequest.fromJson(Map<String, dynamic> json) =
      _$CreateMemberRequestImpl.fromJson;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'phone')
  String get phone;
  @override
  @JsonKey(name: 'level_id')
  int? get levelId;
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateMemberRequestImplCopyWith<_$CreateMemberRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
UpdateMemberRequest _$UpdateMemberRequestFromJson(Map<String, dynamic> json) {
  return _UpdateMemberRequest.fromJson(json);
}
mixin _$UpdateMemberRequest {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'level_id')
  int? get levelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int? get status => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateMemberRequestCopyWith<UpdateMemberRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $UpdateMemberRequestCopyWith<$Res> {
  factory $UpdateMemberRequestCopyWith(
          UpdateMemberRequest value, $Res Function(UpdateMemberRequest) then) =
      _$UpdateMemberRequestCopyWithImpl<$Res, UpdateMemberRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'level_id') int? levelId,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'status') int? status});
}
class _$UpdateMemberRequestCopyWithImpl<$Res, $Val extends UpdateMemberRequest>
    implements $UpdateMemberRequestCopyWith<$Res> {
  _$UpdateMemberRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? phone = freezed,
    Object? levelId = freezed,
    Object? remark = freezed,
    Object? status = freezed,
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
      levelId: freezed == levelId
          ? _value.levelId
          : levelId 
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
    ) as $Val);
  }
}
abstract class _$$UpdateMemberRequestImplCopyWith<$Res>
    implements $UpdateMemberRequestCopyWith<$Res> {
  factory _$$UpdateMemberRequestImplCopyWith(_$UpdateMemberRequestImpl value,
          $Res Function(_$UpdateMemberRequestImpl) then) =
      __$$UpdateMemberRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'level_id') int? levelId,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'status') int? status});
}
class __$$UpdateMemberRequestImplCopyWithImpl<$Res>
    extends _$UpdateMemberRequestCopyWithImpl<$Res, _$UpdateMemberRequestImpl>
    implements _$$UpdateMemberRequestImplCopyWith<$Res> {
  __$$UpdateMemberRequestImplCopyWithImpl(_$UpdateMemberRequestImpl _value,
      $Res Function(_$UpdateMemberRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? phone = freezed,
    Object? levelId = freezed,
    Object? remark = freezed,
    Object? status = freezed,
  }) {
    return _then(_$UpdateMemberRequestImpl(
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
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
    ));
  }
}
@JsonSerializable()
class _$UpdateMemberRequestImpl
    with DiagnosticableTreeMixin
    implements _UpdateMemberRequest {
  const _$UpdateMemberRequestImpl(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'phone') this.phone,
      @JsonKey(name: 'level_id') this.levelId,
      @JsonKey(name: 'remark') this.remark,
      @JsonKey(name: 'status') this.status});
  factory _$UpdateMemberRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateMemberRequestImplFromJson(json);
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
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  @JsonKey(name: 'status')
  final int? status;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdateMemberRequest(name: $name, phone: $phone, levelId: $levelId, remark: $remark, status: $status)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UpdateMemberRequest'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('levelId', levelId))
      ..add(DiagnosticsProperty('remark', remark))
      ..add(DiagnosticsProperty('status', status));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMemberRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.levelId, levelId) || other.levelId == levelId) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.status, status) || other.status == status));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, phone, levelId, remark, status);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateMemberRequestImplCopyWith<_$UpdateMemberRequestImpl> get copyWith =>
      __$$UpdateMemberRequestImplCopyWithImpl<_$UpdateMemberRequestImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateMemberRequestImplToJson(
      this,
    );
  }
}
abstract class _UpdateMemberRequest implements UpdateMemberRequest {
  const factory _UpdateMemberRequest(
      {@JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'phone') final String? phone,
      @JsonKey(name: 'level_id') final int? levelId,
      @JsonKey(name: 'remark') final String? remark,
      @JsonKey(name: 'status') final int? status}) = _$UpdateMemberRequestImpl;
  factory _UpdateMemberRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateMemberRequestImpl.fromJson;
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
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(name: 'status')
  int? get status;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateMemberRequestImplCopyWith<_$UpdateMemberRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
AdjustBalanceRequest _$AdjustBalanceRequestFromJson(Map<String, dynamic> json) {
  return _AdjustBalanceRequest.fromJson(json);
}
mixin _$AdjustBalanceRequest {
  @JsonKey(name: 'amount')
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  int get type => throw _privateConstructorUsedError; 
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdjustBalanceRequestCopyWith<AdjustBalanceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $AdjustBalanceRequestCopyWith<$Res> {
  factory $AdjustBalanceRequestCopyWith(AdjustBalanceRequest value,
          $Res Function(AdjustBalanceRequest) then) =
      _$AdjustBalanceRequestCopyWithImpl<$Res, AdjustBalanceRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'amount') double amount,
      @JsonKey(name: 'type') int type,
      @JsonKey(name: 'remark') String? remark});
}
class _$AdjustBalanceRequestCopyWithImpl<$Res,
        $Val extends AdjustBalanceRequest>
    implements $AdjustBalanceRequestCopyWith<$Res> {
  _$AdjustBalanceRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? type = null,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount 
              as double,
      type: null == type
          ? _value.type
          : type 
              as int,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ) as $Val);
  }
}
abstract class _$$AdjustBalanceRequestImplCopyWith<$Res>
    implements $AdjustBalanceRequestCopyWith<$Res> {
  factory _$$AdjustBalanceRequestImplCopyWith(_$AdjustBalanceRequestImpl value,
          $Res Function(_$AdjustBalanceRequestImpl) then) =
      __$$AdjustBalanceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'amount') double amount,
      @JsonKey(name: 'type') int type,
      @JsonKey(name: 'remark') String? remark});
}
class __$$AdjustBalanceRequestImplCopyWithImpl<$Res>
    extends _$AdjustBalanceRequestCopyWithImpl<$Res, _$AdjustBalanceRequestImpl>
    implements _$$AdjustBalanceRequestImplCopyWith<$Res> {
  __$$AdjustBalanceRequestImplCopyWithImpl(_$AdjustBalanceRequestImpl _value,
      $Res Function(_$AdjustBalanceRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? type = null,
    Object? remark = freezed,
  }) {
    return _then(_$AdjustBalanceRequestImpl(
      amount: null == amount
          ? _value.amount
          : amount 
              as double,
      type: null == type
          ? _value.type
          : type 
              as int,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$AdjustBalanceRequestImpl
    with DiagnosticableTreeMixin
    implements _AdjustBalanceRequest {
  const _$AdjustBalanceRequestImpl(
      {@JsonKey(name: 'amount') required this.amount,
      @JsonKey(name: 'type') required this.type,
      @JsonKey(name: 'remark') this.remark});
  factory _$AdjustBalanceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdjustBalanceRequestImplFromJson(json);
  @override
  @JsonKey(name: 'amount')
  final double amount;
  @override
  @JsonKey(name: 'type')
  final int type;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AdjustBalanceRequest(amount: $amount, type: $type, remark: $remark)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AdjustBalanceRequest'))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('remark', remark));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdjustBalanceRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.remark, remark) || other.remark == remark));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, type, remark);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdjustBalanceRequestImplCopyWith<_$AdjustBalanceRequestImpl>
      get copyWith =>
          __$$AdjustBalanceRequestImplCopyWithImpl<_$AdjustBalanceRequestImpl>(
              this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$AdjustBalanceRequestImplToJson(
      this,
    );
  }
}
abstract class _AdjustBalanceRequest implements AdjustBalanceRequest {
  const factory _AdjustBalanceRequest(
          {@JsonKey(name: 'amount') required final double amount,
          @JsonKey(name: 'type') required final int type,
          @JsonKey(name: 'remark') final String? remark}) =
      _$AdjustBalanceRequestImpl;
  factory _AdjustBalanceRequest.fromJson(Map<String, dynamic> json) =
      _$AdjustBalanceRequestImpl.fromJson;
  @override
  @JsonKey(name: 'amount')
  double get amount;
  @override
  @JsonKey(name: 'type')
  int get type; 
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdjustBalanceRequestImplCopyWith<_$AdjustBalanceRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
WalletLog _$WalletLogFromJson(Map<String, dynamic> json) {
  return _WalletLog.fromJson(json);
}
mixin _$WalletLog {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_id')
  int? get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_name')
  String? get memberName => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_phone')
  String? get memberPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  int? get type => throw _privateConstructorUsedError; 
  @JsonKey(name: 'type_name')
  String? get typeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount')
  double? get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance_before')
  double? get balanceBefore => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance_after')
  double? get balanceAfter => throw _privateConstructorUsedError;
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
      @JsonKey(name: 'member_name') String? memberName,
      @JsonKey(name: 'member_phone') String? memberPhone,
      @JsonKey(name: 'type') int? type,
      @JsonKey(name: 'type_name') String? typeName,
      @JsonKey(name: 'amount') double? amount,
      @JsonKey(name: 'balance_before') double? balanceBefore,
      @JsonKey(name: 'balance_after') double? balanceAfter,
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
    Object? memberName = freezed,
    Object? memberPhone = freezed,
    Object? type = freezed,
    Object? typeName = freezed,
    Object? amount = freezed,
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
      memberName: freezed == memberName
          ? _value.memberName
          : memberName 
              as String?,
      memberPhone: freezed == memberPhone
          ? _value.memberPhone
          : memberPhone 
              as String?,
      type: freezed == type
          ? _value.type
          : type 
              as int?,
      typeName: freezed == typeName
          ? _value.typeName
          : typeName 
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount 
              as double?,
      balanceBefore: freezed == balanceBefore
          ? _value.balanceBefore
          : balanceBefore 
              as double?,
      balanceAfter: freezed == balanceAfter
          ? _value.balanceAfter
          : balanceAfter 
              as double?,
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
      @JsonKey(name: 'member_name') String? memberName,
      @JsonKey(name: 'member_phone') String? memberPhone,
      @JsonKey(name: 'type') int? type,
      @JsonKey(name: 'type_name') String? typeName,
      @JsonKey(name: 'amount') double? amount,
      @JsonKey(name: 'balance_before') double? balanceBefore,
      @JsonKey(name: 'balance_after') double? balanceAfter,
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
    Object? memberName = freezed,
    Object? memberPhone = freezed,
    Object? type = freezed,
    Object? typeName = freezed,
    Object? amount = freezed,
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
      memberName: freezed == memberName
          ? _value.memberName
          : memberName 
              as String?,
      memberPhone: freezed == memberPhone
          ? _value.memberPhone
          : memberPhone 
              as String?,
      type: freezed == type
          ? _value.type
          : type 
              as int?,
      typeName: freezed == typeName
          ? _value.typeName
          : typeName 
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount 
              as double?,
      balanceBefore: freezed == balanceBefore
          ? _value.balanceBefore
          : balanceBefore 
              as double?,
      balanceAfter: freezed == balanceAfter
          ? _value.balanceAfter
          : balanceAfter 
              as double?,
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
class _$WalletLogImpl with DiagnosticableTreeMixin implements _WalletLog {
  const _$WalletLogImpl(
      {required this.id,
      @JsonKey(name: 'member_id') this.memberId,
      @JsonKey(name: 'member_name') this.memberName,
      @JsonKey(name: 'member_phone') this.memberPhone,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'type_name') this.typeName,
      @JsonKey(name: 'amount') this.amount,
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
  @JsonKey(name: 'member_name')
  final String? memberName;
  @override
  @JsonKey(name: 'member_phone')
  final String? memberPhone;
  @override
  @JsonKey(name: 'type')
  final int? type;
  @override
  @JsonKey(name: 'type_name')
  final String? typeName;
  @override
  @JsonKey(name: 'amount')
  final double? amount;
  @override
  @JsonKey(name: 'balance_before')
  final double? balanceBefore;
  @override
  @JsonKey(name: 'balance_after')
  final double? balanceAfter;
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletLog(id: $id, memberId: $memberId, memberName: $memberName, memberPhone: $memberPhone, type: $type, typeName: $typeName, amount: $amount, balanceBefore: $balanceBefore, balanceAfter: $balanceAfter, remark: $remark, orderNo: $orderNo, createdAt: $createdAt)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletLog'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('memberId', memberId))
      ..add(DiagnosticsProperty('memberName', memberName))
      ..add(DiagnosticsProperty('memberPhone', memberPhone))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('typeName', typeName))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('balanceBefore', balanceBefore))
      ..add(DiagnosticsProperty('balanceAfter', balanceAfter))
      ..add(DiagnosticsProperty('remark', remark))
      ..add(DiagnosticsProperty('orderNo', orderNo))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.memberPhone, memberPhone) ||
                other.memberPhone == memberPhone) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
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
  int get hashCode => Object.hash(
      runtimeType,
      id,
      memberId,
      memberName,
      memberPhone,
      type,
      typeName,
      amount,
      balanceBefore,
      balanceAfter,
      remark,
      orderNo,
      createdAt);
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
      @JsonKey(name: 'member_name') final String? memberName,
      @JsonKey(name: 'member_phone') final String? memberPhone,
      @JsonKey(name: 'type') final int? type,
      @JsonKey(name: 'type_name') final String? typeName,
      @JsonKey(name: 'amount') final double? amount,
      @JsonKey(name: 'balance_before') final double? balanceBefore,
      @JsonKey(name: 'balance_after') final double? balanceAfter,
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
  @JsonKey(name: 'member_name')
  String? get memberName;
  @override
  @JsonKey(name: 'member_phone')
  String? get memberPhone;
  @override
  @JsonKey(name: 'type')
  int? get type; 
  @override
  @JsonKey(name: 'type_name')
  String? get typeName;
  @override
  @JsonKey(name: 'amount')
  double? get amount;
  @override
  @JsonKey(name: 'balance_before')
  double? get balanceBefore;
  @override
  @JsonKey(name: 'balance_after')
  double? get balanceAfter;
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
  @JsonKey(name: 'member_phone')
  String? get memberPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount')
  double? get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_amount')
  double? get payAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'gift_amount')
  double? get giftAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_type')
  int? get payType => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_type_name')
  String? get payTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_name')
  String? get statusName => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_at')
  String? get paidAt => throw _privateConstructorUsedError;
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
      @JsonKey(name: 'member_phone') String? memberPhone,
      @JsonKey(name: 'amount') double? amount,
      @JsonKey(name: 'pay_amount') double? payAmount,
      @JsonKey(name: 'gift_amount') double? giftAmount,
      @JsonKey(name: 'pay_type') int? payType,
      @JsonKey(name: 'pay_type_name') String? payTypeName,
      @JsonKey(name: 'status') int? status,
      @JsonKey(name: 'status_name') String? statusName,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'paid_at') String? paidAt,
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
    Object? memberPhone = freezed,
    Object? amount = freezed,
    Object? payAmount = freezed,
    Object? giftAmount = freezed,
    Object? payType = freezed,
    Object? payTypeName = freezed,
    Object? status = freezed,
    Object? statusName = freezed,
    Object? remark = freezed,
    Object? paidAt = freezed,
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
      memberPhone: freezed == memberPhone
          ? _value.memberPhone
          : memberPhone 
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount 
              as double?,
      payAmount: freezed == payAmount
          ? _value.payAmount
          : payAmount 
              as double?,
      giftAmount: freezed == giftAmount
          ? _value.giftAmount
          : giftAmount 
              as double?,
      payType: freezed == payType
          ? _value.payType
          : payType 
              as int?,
      payTypeName: freezed == payTypeName
          ? _value.payTypeName
          : payTypeName 
              as String?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      statusName: freezed == statusName
          ? _value.statusName
          : statusName 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt 
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
      @JsonKey(name: 'member_phone') String? memberPhone,
      @JsonKey(name: 'amount') double? amount,
      @JsonKey(name: 'pay_amount') double? payAmount,
      @JsonKey(name: 'gift_amount') double? giftAmount,
      @JsonKey(name: 'pay_type') int? payType,
      @JsonKey(name: 'pay_type_name') String? payTypeName,
      @JsonKey(name: 'status') int? status,
      @JsonKey(name: 'status_name') String? statusName,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'paid_at') String? paidAt,
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
    Object? memberPhone = freezed,
    Object? amount = freezed,
    Object? payAmount = freezed,
    Object? giftAmount = freezed,
    Object? payType = freezed,
    Object? payTypeName = freezed,
    Object? status = freezed,
    Object? statusName = freezed,
    Object? remark = freezed,
    Object? paidAt = freezed,
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
      memberPhone: freezed == memberPhone
          ? _value.memberPhone
          : memberPhone 
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount 
              as double?,
      payAmount: freezed == payAmount
          ? _value.payAmount
          : payAmount 
              as double?,
      giftAmount: freezed == giftAmount
          ? _value.giftAmount
          : giftAmount 
              as double?,
      payType: freezed == payType
          ? _value.payType
          : payType 
              as int?,
      payTypeName: freezed == payTypeName
          ? _value.payTypeName
          : payTypeName 
              as String?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      statusName: freezed == statusName
          ? _value.statusName
          : statusName 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt 
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$RechargeOrderImpl
    with DiagnosticableTreeMixin
    implements _RechargeOrder {
  const _$RechargeOrderImpl(
      {required this.id,
      @JsonKey(name: 'order_no') this.orderNo,
      @JsonKey(name: 'member_id') this.memberId,
      @JsonKey(name: 'member_name') this.memberName,
      @JsonKey(name: 'member_phone') this.memberPhone,
      @JsonKey(name: 'amount') this.amount,
      @JsonKey(name: 'pay_amount') this.payAmount,
      @JsonKey(name: 'gift_amount') this.giftAmount,
      @JsonKey(name: 'pay_type') this.payType,
      @JsonKey(name: 'pay_type_name') this.payTypeName,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'status_name') this.statusName,
      @JsonKey(name: 'remark') this.remark,
      @JsonKey(name: 'paid_at') this.paidAt,
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
  @JsonKey(name: 'member_phone')
  final String? memberPhone;
  @override
  @JsonKey(name: 'amount')
  final double? amount;
  @override
  @JsonKey(name: 'pay_amount')
  final double? payAmount;
  @override
  @JsonKey(name: 'gift_amount')
  final double? giftAmount;
  @override
  @JsonKey(name: 'pay_type')
  final int? payType;
  @override
  @JsonKey(name: 'pay_type_name')
  final String? payTypeName;
  @override
  @JsonKey(name: 'status')
  final int? status;
  @override
  @JsonKey(name: 'status_name')
  final String? statusName;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  @JsonKey(name: 'paid_at')
  final String? paidAt;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RechargeOrder(id: $id, orderNo: $orderNo, memberId: $memberId, memberName: $memberName, memberPhone: $memberPhone, amount: $amount, payAmount: $payAmount, giftAmount: $giftAmount, payType: $payType, payTypeName: $payTypeName, status: $status, statusName: $statusName, remark: $remark, paidAt: $paidAt, createdAt: $createdAt)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RechargeOrder'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('orderNo', orderNo))
      ..add(DiagnosticsProperty('memberId', memberId))
      ..add(DiagnosticsProperty('memberName', memberName))
      ..add(DiagnosticsProperty('memberPhone', memberPhone))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('payAmount', payAmount))
      ..add(DiagnosticsProperty('giftAmount', giftAmount))
      ..add(DiagnosticsProperty('payType', payType))
      ..add(DiagnosticsProperty('payTypeName', payTypeName))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('statusName', statusName))
      ..add(DiagnosticsProperty('remark', remark))
      ..add(DiagnosticsProperty('paidAt', paidAt))
      ..add(DiagnosticsProperty('createdAt', createdAt));
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
            (identical(other.memberPhone, memberPhone) ||
                other.memberPhone == memberPhone) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.payAmount, payAmount) ||
                other.payAmount == payAmount) &&
            (identical(other.giftAmount, giftAmount) ||
                other.giftAmount == giftAmount) &&
            (identical(other.payType, payType) || other.payType == payType) &&
            (identical(other.payTypeName, payTypeName) ||
                other.payTypeName == payTypeName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusName, statusName) ||
                other.statusName == statusName) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
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
      memberPhone,
      amount,
      payAmount,
      giftAmount,
      payType,
      payTypeName,
      status,
      statusName,
      remark,
      paidAt,
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
          @JsonKey(name: 'member_phone') final String? memberPhone,
          @JsonKey(name: 'amount') final double? amount,
          @JsonKey(name: 'pay_amount') final double? payAmount,
          @JsonKey(name: 'gift_amount') final double? giftAmount,
          @JsonKey(name: 'pay_type') final int? payType,
          @JsonKey(name: 'pay_type_name') final String? payTypeName,
          @JsonKey(name: 'status') final int? status,
          @JsonKey(name: 'status_name') final String? statusName,
          @JsonKey(name: 'remark') final String? remark,
          @JsonKey(name: 'paid_at') final String? paidAt,
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
  @JsonKey(name: 'member_phone')
  String? get memberPhone;
  @override
  @JsonKey(name: 'amount')
  double? get amount;
  @override
  @JsonKey(name: 'pay_amount')
  double? get payAmount;
  @override
  @JsonKey(name: 'gift_amount')
  double? get giftAmount;
  @override
  @JsonKey(name: 'pay_type')
  int? get payType;
  @override
  @JsonKey(name: 'pay_type_name')
  String? get payTypeName;
  @override
  @JsonKey(name: 'status')
  int? get status;
  @override
  @JsonKey(name: 'status_name')
  String? get statusName;
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(name: 'paid_at')
  String? get paidAt;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RechargeOrderImplCopyWith<_$RechargeOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
CreateRechargeOrderRequest _$CreateRechargeOrderRequestFromJson(
    Map<String, dynamic> json) {
  return _CreateRechargeOrderRequest.fromJson(json);
}
mixin _$CreateRechargeOrderRequest {
  @JsonKey(name: 'member_id')
  int get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount')
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_type')
  int get payType => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateRechargeOrderRequestCopyWith<CreateRechargeOrderRequest>
      get copyWith => throw _privateConstructorUsedError;
}
abstract class $CreateRechargeOrderRequestCopyWith<$Res> {
  factory $CreateRechargeOrderRequestCopyWith(CreateRechargeOrderRequest value,
          $Res Function(CreateRechargeOrderRequest) then) =
      _$CreateRechargeOrderRequestCopyWithImpl<$Res,
          CreateRechargeOrderRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'member_id') int memberId,
      @JsonKey(name: 'amount') double amount,
      @JsonKey(name: 'pay_type') int payType,
      @JsonKey(name: 'remark') String? remark});
}
class _$CreateRechargeOrderRequestCopyWithImpl<$Res,
        $Val extends CreateRechargeOrderRequest>
    implements $CreateRechargeOrderRequestCopyWith<$Res> {
  _$CreateRechargeOrderRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? amount = null,
    Object? payType = null,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      memberId: null == memberId
          ? _value.memberId
          : memberId 
              as int,
      amount: null == amount
          ? _value.amount
          : amount 
              as double,
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
abstract class _$$CreateRechargeOrderRequestImplCopyWith<$Res>
    implements $CreateRechargeOrderRequestCopyWith<$Res> {
  factory _$$CreateRechargeOrderRequestImplCopyWith(
          _$CreateRechargeOrderRequestImpl value,
          $Res Function(_$CreateRechargeOrderRequestImpl) then) =
      __$$CreateRechargeOrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'member_id') int memberId,
      @JsonKey(name: 'amount') double amount,
      @JsonKey(name: 'pay_type') int payType,
      @JsonKey(name: 'remark') String? remark});
}
class __$$CreateRechargeOrderRequestImplCopyWithImpl<$Res>
    extends _$CreateRechargeOrderRequestCopyWithImpl<$Res,
        _$CreateRechargeOrderRequestImpl>
    implements _$$CreateRechargeOrderRequestImplCopyWith<$Res> {
  __$$CreateRechargeOrderRequestImplCopyWithImpl(
      _$CreateRechargeOrderRequestImpl _value,
      $Res Function(_$CreateRechargeOrderRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? amount = null,
    Object? payType = null,
    Object? remark = freezed,
  }) {
    return _then(_$CreateRechargeOrderRequestImpl(
      memberId: null == memberId
          ? _value.memberId
          : memberId 
              as int,
      amount: null == amount
          ? _value.amount
          : amount 
              as double,
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
class _$CreateRechargeOrderRequestImpl
    with DiagnosticableTreeMixin
    implements _CreateRechargeOrderRequest {
  const _$CreateRechargeOrderRequestImpl(
      {@JsonKey(name: 'member_id') required this.memberId,
      @JsonKey(name: 'amount') required this.amount,
      @JsonKey(name: 'pay_type') required this.payType,
      @JsonKey(name: 'remark') this.remark});
  factory _$CreateRechargeOrderRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateRechargeOrderRequestImplFromJson(json);
  @override
  @JsonKey(name: 'member_id')
  final int memberId;
  @override
  @JsonKey(name: 'amount')
  final double amount;
  @override
  @JsonKey(name: 'pay_type')
  final int payType;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateRechargeOrderRequest(memberId: $memberId, amount: $amount, payType: $payType, remark: $remark)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateRechargeOrderRequest'))
      ..add(DiagnosticsProperty('memberId', memberId))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('payType', payType))
      ..add(DiagnosticsProperty('remark', remark));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateRechargeOrderRequestImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.payType, payType) || other.payType == payType) &&
            (identical(other.remark, remark) || other.remark == remark));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, memberId, amount, payType, remark);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateRechargeOrderRequestImplCopyWith<_$CreateRechargeOrderRequestImpl>
      get copyWith => __$$CreateRechargeOrderRequestImplCopyWithImpl<
          _$CreateRechargeOrderRequestImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$CreateRechargeOrderRequestImplToJson(
      this,
    );
  }
}
abstract class _CreateRechargeOrderRequest
    implements CreateRechargeOrderRequest {
  const factory _CreateRechargeOrderRequest(
          {@JsonKey(name: 'member_id') required final int memberId,
          @JsonKey(name: 'amount') required final double amount,
          @JsonKey(name: 'pay_type') required final int payType,
          @JsonKey(name: 'remark') final String? remark}) =
      _$CreateRechargeOrderRequestImpl;
  factory _CreateRechargeOrderRequest.fromJson(Map<String, dynamic> json) =
      _$CreateRechargeOrderRequestImpl.fromJson;
  @override
  @JsonKey(name: 'member_id')
  int get memberId;
  @override
  @JsonKey(name: 'amount')
  double get amount;
  @override
  @JsonKey(name: 'pay_type')
  int get payType;
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateRechargeOrderRequestImplCopyWith<_$CreateRechargeOrderRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
PayRechargeOrderRequest _$PayRechargeOrderRequestFromJson(
    Map<String, dynamic> json) {
  return _PayRechargeOrderRequest.fromJson(json);
}
mixin _$PayRechargeOrderRequest {
  @JsonKey(name: 'pay_type')
  int get payType => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_no')
  String? get transactionNo => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayRechargeOrderRequestCopyWith<PayRechargeOrderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $PayRechargeOrderRequestCopyWith<$Res> {
  factory $PayRechargeOrderRequestCopyWith(PayRechargeOrderRequest value,
          $Res Function(PayRechargeOrderRequest) then) =
      _$PayRechargeOrderRequestCopyWithImpl<$Res, PayRechargeOrderRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'pay_type') int payType,
      @JsonKey(name: 'transaction_no') String? transactionNo});
}
class _$PayRechargeOrderRequestCopyWithImpl<$Res,
        $Val extends PayRechargeOrderRequest>
    implements $PayRechargeOrderRequestCopyWith<$Res> {
  _$PayRechargeOrderRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payType = null,
    Object? transactionNo = freezed,
  }) {
    return _then(_value.copyWith(
      payType: null == payType
          ? _value.payType
          : payType 
              as int,
      transactionNo: freezed == transactionNo
          ? _value.transactionNo
          : transactionNo 
              as String?,
    ) as $Val);
  }
}
abstract class _$$PayRechargeOrderRequestImplCopyWith<$Res>
    implements $PayRechargeOrderRequestCopyWith<$Res> {
  factory _$$PayRechargeOrderRequestImplCopyWith(
          _$PayRechargeOrderRequestImpl value,
          $Res Function(_$PayRechargeOrderRequestImpl) then) =
      __$$PayRechargeOrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'pay_type') int payType,
      @JsonKey(name: 'transaction_no') String? transactionNo});
}
class __$$PayRechargeOrderRequestImplCopyWithImpl<$Res>
    extends _$PayRechargeOrderRequestCopyWithImpl<$Res,
        _$PayRechargeOrderRequestImpl>
    implements _$$PayRechargeOrderRequestImplCopyWith<$Res> {
  __$$PayRechargeOrderRequestImplCopyWithImpl(
      _$PayRechargeOrderRequestImpl _value,
      $Res Function(_$PayRechargeOrderRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payType = null,
    Object? transactionNo = freezed,
  }) {
    return _then(_$PayRechargeOrderRequestImpl(
      payType: null == payType
          ? _value.payType
          : payType 
              as int,
      transactionNo: freezed == transactionNo
          ? _value.transactionNo
          : transactionNo 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$PayRechargeOrderRequestImpl
    with DiagnosticableTreeMixin
    implements _PayRechargeOrderRequest {
  const _$PayRechargeOrderRequestImpl(
      {@JsonKey(name: 'pay_type') required this.payType,
      @JsonKey(name: 'transaction_no') this.transactionNo});
  factory _$PayRechargeOrderRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayRechargeOrderRequestImplFromJson(json);
  @override
  @JsonKey(name: 'pay_type')
  final int payType;
  @override
  @JsonKey(name: 'transaction_no')
  final String? transactionNo;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PayRechargeOrderRequest(payType: $payType, transactionNo: $transactionNo)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PayRechargeOrderRequest'))
      ..add(DiagnosticsProperty('payType', payType))
      ..add(DiagnosticsProperty('transactionNo', transactionNo));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayRechargeOrderRequestImpl &&
            (identical(other.payType, payType) || other.payType == payType) &&
            (identical(other.transactionNo, transactionNo) ||
                other.transactionNo == transactionNo));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, payType, transactionNo);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayRechargeOrderRequestImplCopyWith<_$PayRechargeOrderRequestImpl>
      get copyWith => __$$PayRechargeOrderRequestImplCopyWithImpl<
          _$PayRechargeOrderRequestImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$PayRechargeOrderRequestImplToJson(
      this,
    );
  }
}
abstract class _PayRechargeOrderRequest implements PayRechargeOrderRequest {
  const factory _PayRechargeOrderRequest(
          {@JsonKey(name: 'pay_type') required final int payType,
          @JsonKey(name: 'transaction_no') final String? transactionNo}) =
      _$PayRechargeOrderRequestImpl;
  factory _PayRechargeOrderRequest.fromJson(Map<String, dynamic> json) =
      _$PayRechargeOrderRequestImpl.fromJson;
  @override
  @JsonKey(name: 'pay_type')
  int get payType;
  @override
  @JsonKey(name: 'transaction_no')
  String? get transactionNo;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayRechargeOrderRequestImplCopyWith<_$PayRechargeOrderRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
MemberLevel _$MemberLevelFromJson(Map<String, dynamic> json) {
  return _MemberLevel.fromJson(json);
}
mixin _$MemberLevel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount')
  int? get discount => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_amount')
  double? get minAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberLevelCopyWith<MemberLevel> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $MemberLevelCopyWith<$Res> {
  factory $MemberLevelCopyWith(
          MemberLevel value, $Res Function(MemberLevel) then) =
      _$MemberLevelCopyWithImpl<$Res, MemberLevel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'discount') int? discount,
      @JsonKey(name: 'min_amount') double? minAmount,
      @JsonKey(name: 'status') int? status,
      @JsonKey(name: 'created_at') String? createdAt});
}
class _$MemberLevelCopyWithImpl<$Res, $Val extends MemberLevel>
    implements $MemberLevelCopyWith<$Res> {
  _$MemberLevelCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? discount = freezed,
    Object? minAmount = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
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
      discount: freezed == discount
          ? _value.discount
          : discount 
              as int?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount 
              as double?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
    ) as $Val);
  }
}
abstract class _$$MemberLevelImplCopyWith<$Res>
    implements $MemberLevelCopyWith<$Res> {
  factory _$$MemberLevelImplCopyWith(
          _$MemberLevelImpl value, $Res Function(_$MemberLevelImpl) then) =
      __$$MemberLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'discount') int? discount,
      @JsonKey(name: 'min_amount') double? minAmount,
      @JsonKey(name: 'status') int? status,
      @JsonKey(name: 'created_at') String? createdAt});
}
class __$$MemberLevelImplCopyWithImpl<$Res>
    extends _$MemberLevelCopyWithImpl<$Res, _$MemberLevelImpl>
    implements _$$MemberLevelImplCopyWith<$Res> {
  __$$MemberLevelImplCopyWithImpl(
      _$MemberLevelImpl _value, $Res Function(_$MemberLevelImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? discount = freezed,
    Object? minAmount = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$MemberLevelImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      discount: freezed == discount
          ? _value.discount
          : discount 
              as int?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount 
              as double?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$MemberLevelImpl with DiagnosticableTreeMixin implements _MemberLevel {
  const _$MemberLevelImpl(
      {required this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'discount') this.discount,
      @JsonKey(name: 'min_amount') this.minAmount,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'created_at') this.createdAt});
  factory _$MemberLevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberLevelImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'discount')
  final int? discount;
  @override
  @JsonKey(name: 'min_amount')
  final double? minAmount;
  @override
  @JsonKey(name: 'status')
  final int? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MemberLevel(id: $id, name: $name, discount: $discount, minAmount: $minAmount, status: $status, createdAt: $createdAt)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MemberLevel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('discount', discount))
      ..add(DiagnosticsProperty('minAmount', minAmount))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberLevelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.minAmount, minAmount) ||
                other.minAmount == minAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, discount, minAmount, status, createdAt);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberLevelImplCopyWith<_$MemberLevelImpl> get copyWith =>
      __$$MemberLevelImplCopyWithImpl<_$MemberLevelImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$MemberLevelImplToJson(
      this,
    );
  }
}
abstract class _MemberLevel implements MemberLevel {
  const factory _MemberLevel(
          {required final int id,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'discount') final int? discount,
          @JsonKey(name: 'min_amount') final double? minAmount,
          @JsonKey(name: 'status') final int? status,
          @JsonKey(name: 'created_at') final String? createdAt}) =
      _$MemberLevelImpl;
  factory _MemberLevel.fromJson(Map<String, dynamic> json) =
      _$MemberLevelImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'discount')
  int? get discount;
  @override
  @JsonKey(name: 'min_amount')
  double? get minAmount;
  @override
  @JsonKey(name: 'status')
  int? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberLevelImplCopyWith<_$MemberLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
mixin _$MemberPageResponse {
  List<Member> get list => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberPageResponseCopyWith<MemberPageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $MemberPageResponseCopyWith<$Res> {
  factory $MemberPageResponseCopyWith(
          MemberPageResponse value, $Res Function(MemberPageResponse) then) =
      _$MemberPageResponseCopyWithImpl<$Res, MemberPageResponse>;
  @useResult
  $Res call(
      {List<Member> list,
      int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'page_size') int pageSize});
}
class _$MemberPageResponseCopyWithImpl<$Res, $Val extends MemberPageResponse>
    implements $MemberPageResponseCopyWith<$Res> {
  _$MemberPageResponseCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list 
              as List<Member>,
      total: null == total
          ? _value.total
          : total 
              as int,
      page: null == page
          ? _value.page
          : page 
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize 
              as int,
    ) as $Val);
  }
}
abstract class _$$MemberPageResponseImplCopyWith<$Res>
    implements $MemberPageResponseCopyWith<$Res> {
  factory _$$MemberPageResponseImplCopyWith(_$MemberPageResponseImpl value,
          $Res Function(_$MemberPageResponseImpl) then) =
      __$$MemberPageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Member> list,
      int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'page_size') int pageSize});
}
class __$$MemberPageResponseImplCopyWithImpl<$Res>
    extends _$MemberPageResponseCopyWithImpl<$Res, _$MemberPageResponseImpl>
    implements _$$MemberPageResponseImplCopyWith<$Res> {
  __$$MemberPageResponseImplCopyWithImpl(_$MemberPageResponseImpl _value,
      $Res Function(_$MemberPageResponseImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
  }) {
    return _then(_$MemberPageResponseImpl(
      list: null == list
          ? _value._list
          : list 
              as List<Member>,
      total: null == total
          ? _value.total
          : total 
              as int,
      page: null == page
          ? _value.page
          : page 
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize 
              as int,
    ));
  }
}
class _$MemberPageResponseImpl
    with DiagnosticableTreeMixin
    implements _MemberPageResponse {
  const _$MemberPageResponseImpl(
      {required final List<Member> list,
      required this.total,
      @JsonKey(name: 'page') required this.page,
      @JsonKey(name: 'page_size') required this.pageSize})
      : _list = list;
  final List<Member> _list;
  @override
  List<Member> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    return EqualUnmodifiableListView(_list);
  }
  @override
  final int total;
  @override
  @JsonKey(name: 'page')
  final int page;
  @override
  @JsonKey(name: 'page_size')
  final int pageSize;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MemberPageResponse(list: $list, total: $total, page: $page, pageSize: $pageSize)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MemberPageResponse'))
      ..add(DiagnosticsProperty('list', list))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('pageSize', pageSize));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberPageResponseImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_list), total, page, pageSize);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberPageResponseImplCopyWith<_$MemberPageResponseImpl> get copyWith =>
      __$$MemberPageResponseImplCopyWithImpl<_$MemberPageResponseImpl>(
          this, _$identity);
}
abstract class _MemberPageResponse implements MemberPageResponse {
  const factory _MemberPageResponse(
          {required final List<Member> list,
          required final int total,
          @JsonKey(name: 'page') required final int page,
          @JsonKey(name: 'page_size') required final int pageSize}) =
      _$MemberPageResponseImpl;
  @override
  List<Member> get list;
  @override
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'page_size')
  int get pageSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberPageResponseImplCopyWith<_$MemberPageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
mixin _$WalletLogPageResponse {
  List<WalletLog> get list => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletLogPageResponseCopyWith<WalletLogPageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $WalletLogPageResponseCopyWith<$Res> {
  factory $WalletLogPageResponseCopyWith(WalletLogPageResponse value,
          $Res Function(WalletLogPageResponse) then) =
      _$WalletLogPageResponseCopyWithImpl<$Res, WalletLogPageResponse>;
  @useResult
  $Res call(
      {List<WalletLog> list,
      int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'page_size') int pageSize});
}
class _$WalletLogPageResponseCopyWithImpl<$Res,
        $Val extends WalletLogPageResponse>
    implements $WalletLogPageResponseCopyWith<$Res> {
  _$WalletLogPageResponseCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list 
              as List<WalletLog>,
      total: null == total
          ? _value.total
          : total 
              as int,
      page: null == page
          ? _value.page
          : page 
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize 
              as int,
    ) as $Val);
  }
}
abstract class _$$WalletLogPageResponseImplCopyWith<$Res>
    implements $WalletLogPageResponseCopyWith<$Res> {
  factory _$$WalletLogPageResponseImplCopyWith(
          _$WalletLogPageResponseImpl value,
          $Res Function(_$WalletLogPageResponseImpl) then) =
      __$$WalletLogPageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<WalletLog> list,
      int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'page_size') int pageSize});
}
class __$$WalletLogPageResponseImplCopyWithImpl<$Res>
    extends _$WalletLogPageResponseCopyWithImpl<$Res,
        _$WalletLogPageResponseImpl>
    implements _$$WalletLogPageResponseImplCopyWith<$Res> {
  __$$WalletLogPageResponseImplCopyWithImpl(_$WalletLogPageResponseImpl _value,
      $Res Function(_$WalletLogPageResponseImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
  }) {
    return _then(_$WalletLogPageResponseImpl(
      list: null == list
          ? _value._list
          : list 
              as List<WalletLog>,
      total: null == total
          ? _value.total
          : total 
              as int,
      page: null == page
          ? _value.page
          : page 
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize 
              as int,
    ));
  }
}
class _$WalletLogPageResponseImpl
    with DiagnosticableTreeMixin
    implements _WalletLogPageResponse {
  const _$WalletLogPageResponseImpl(
      {required final List<WalletLog> list,
      required this.total,
      @JsonKey(name: 'page') required this.page,
      @JsonKey(name: 'page_size') required this.pageSize})
      : _list = list;
  final List<WalletLog> _list;
  @override
  List<WalletLog> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    return EqualUnmodifiableListView(_list);
  }
  @override
  final int total;
  @override
  @JsonKey(name: 'page')
  final int page;
  @override
  @JsonKey(name: 'page_size')
  final int pageSize;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletLogPageResponse(list: $list, total: $total, page: $page, pageSize: $pageSize)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletLogPageResponse'))
      ..add(DiagnosticsProperty('list', list))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('pageSize', pageSize));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletLogPageResponseImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_list), total, page, pageSize);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletLogPageResponseImplCopyWith<_$WalletLogPageResponseImpl>
      get copyWith => __$$WalletLogPageResponseImplCopyWithImpl<
          _$WalletLogPageResponseImpl>(this, _$identity);
}
abstract class _WalletLogPageResponse implements WalletLogPageResponse {
  const factory _WalletLogPageResponse(
          {required final List<WalletLog> list,
          required final int total,
          @JsonKey(name: 'page') required final int page,
          @JsonKey(name: 'page_size') required final int pageSize}) =
      _$WalletLogPageResponseImpl;
  @override
  List<WalletLog> get list;
  @override
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'page_size')
  int get pageSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletLogPageResponseImplCopyWith<_$WalletLogPageResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
mixin _$RechargeOrderPageResponse {
  List<RechargeOrder> get list => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RechargeOrderPageResponseCopyWith<RechargeOrderPageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $RechargeOrderPageResponseCopyWith<$Res> {
  factory $RechargeOrderPageResponseCopyWith(RechargeOrderPageResponse value,
          $Res Function(RechargeOrderPageResponse) then) =
      _$RechargeOrderPageResponseCopyWithImpl<$Res, RechargeOrderPageResponse>;
  @useResult
  $Res call(
      {List<RechargeOrder> list,
      int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'page_size') int pageSize});
}
class _$RechargeOrderPageResponseCopyWithImpl<$Res,
        $Val extends RechargeOrderPageResponse>
    implements $RechargeOrderPageResponseCopyWith<$Res> {
  _$RechargeOrderPageResponseCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list 
              as List<RechargeOrder>,
      total: null == total
          ? _value.total
          : total 
              as int,
      page: null == page
          ? _value.page
          : page 
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize 
              as int,
    ) as $Val);
  }
}
abstract class _$$RechargeOrderPageResponseImplCopyWith<$Res>
    implements $RechargeOrderPageResponseCopyWith<$Res> {
  factory _$$RechargeOrderPageResponseImplCopyWith(
          _$RechargeOrderPageResponseImpl value,
          $Res Function(_$RechargeOrderPageResponseImpl) then) =
      __$$RechargeOrderPageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RechargeOrder> list,
      int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'page_size') int pageSize});
}
class __$$RechargeOrderPageResponseImplCopyWithImpl<$Res>
    extends _$RechargeOrderPageResponseCopyWithImpl<$Res,
        _$RechargeOrderPageResponseImpl>
    implements _$$RechargeOrderPageResponseImplCopyWith<$Res> {
  __$$RechargeOrderPageResponseImplCopyWithImpl(
      _$RechargeOrderPageResponseImpl _value,
      $Res Function(_$RechargeOrderPageResponseImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
  }) {
    return _then(_$RechargeOrderPageResponseImpl(
      list: null == list
          ? _value._list
          : list 
              as List<RechargeOrder>,
      total: null == total
          ? _value.total
          : total 
              as int,
      page: null == page
          ? _value.page
          : page 
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize 
              as int,
    ));
  }
}
class _$RechargeOrderPageResponseImpl
    with DiagnosticableTreeMixin
    implements _RechargeOrderPageResponse {
  const _$RechargeOrderPageResponseImpl(
      {required final List<RechargeOrder> list,
      required this.total,
      @JsonKey(name: 'page') required this.page,
      @JsonKey(name: 'page_size') required this.pageSize})
      : _list = list;
  final List<RechargeOrder> _list;
  @override
  List<RechargeOrder> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    return EqualUnmodifiableListView(_list);
  }
  @override
  final int total;
  @override
  @JsonKey(name: 'page')
  final int page;
  @override
  @JsonKey(name: 'page_size')
  final int pageSize;
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RechargeOrderPageResponse(list: $list, total: $total, page: $page, pageSize: $pageSize)';
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RechargeOrderPageResponse'))
      ..add(DiagnosticsProperty('list', list))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('pageSize', pageSize));
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RechargeOrderPageResponseImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_list), total, page, pageSize);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RechargeOrderPageResponseImplCopyWith<_$RechargeOrderPageResponseImpl>
      get copyWith => __$$RechargeOrderPageResponseImplCopyWithImpl<
          _$RechargeOrderPageResponseImpl>(this, _$identity);
}
abstract class _RechargeOrderPageResponse implements RechargeOrderPageResponse {
  const factory _RechargeOrderPageResponse(
          {required final List<RechargeOrder> list,
          required final int total,
          @JsonKey(name: 'page') required final int page,
          @JsonKey(name: 'page_size') required final int pageSize}) =
      _$RechargeOrderPageResponseImpl;
  @override
  List<RechargeOrder> get list;
  @override
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'page_size')
  int get pageSize;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RechargeOrderPageResponseImplCopyWith<_$RechargeOrderPageResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
