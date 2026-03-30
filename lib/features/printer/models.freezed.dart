part of 'models.dart';
T _$identity<T>(T value) => value;
final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https:
Printer _$PrinterFromJson(Map<String, dynamic> json) {
  return _Printer.fromJson(json);
}
mixin _$Printer {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  int get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String? get sn => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  int? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_name')
  String? get typeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_name')
  String? get statusName => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  int? get isDefault => throw _privateConstructorUsedError;
  @JsonKey(name: 'online')
  int? get online => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_heartbeat')
  String? get lastHeartbeat => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrinterCopyWith<Printer> get copyWith => throw _privateConstructorUsedError;
}
abstract class $PrinterCopyWith<$Res> {
  factory $PrinterCopyWith(Printer value, $Res Function(Printer) then) =
      _$PrinterCopyWithImpl<$Res, Printer>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'sn') String? sn,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'type') int? type,
      @JsonKey(name: 'type_name') String? typeName,
      @JsonKey(name: 'status') int? status,
      @JsonKey(name: 'status_name') String? statusName,
      @JsonKey(name: 'is_default') int? isDefault,
      @JsonKey(name: 'online') int? online,
      @JsonKey(name: 'last_heartbeat') String? lastHeartbeat,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'created_at') String? createdAt});
}
class _$PrinterCopyWithImpl<$Res, $Val extends Printer>
    implements $PrinterCopyWith<$Res> {
  _$PrinterCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? sn = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? typeName = freezed,
    Object? status = freezed,
    Object? statusName = freezed,
    Object? isDefault = freezed,
    Object? online = freezed,
    Object? lastHeartbeat = freezed,
    Object? remark = freezed,
    Object? createdAt = freezed,
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
      sn: freezed == sn
          ? _value.sn
          : sn 
              as String?,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      type: freezed == type
          ? _value.type
          : type 
              as int?,
      typeName: freezed == typeName
          ? _value.typeName
          : typeName 
              as String?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      statusName: freezed == statusName
          ? _value.statusName
          : statusName 
              as String?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault 
              as int?,
      online: freezed == online
          ? _value.online
          : online 
              as int?,
      lastHeartbeat: freezed == lastHeartbeat
          ? _value.lastHeartbeat
          : lastHeartbeat 
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
abstract class _$$PrinterImplCopyWith<$Res> implements $PrinterCopyWith<$Res> {
  factory _$$PrinterImplCopyWith(
          _$PrinterImpl value, $Res Function(_$PrinterImpl) then) =
      __$$PrinterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'sn') String? sn,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'type') int? type,
      @JsonKey(name: 'type_name') String? typeName,
      @JsonKey(name: 'status') int? status,
      @JsonKey(name: 'status_name') String? statusName,
      @JsonKey(name: 'is_default') int? isDefault,
      @JsonKey(name: 'online') int? online,
      @JsonKey(name: 'last_heartbeat') String? lastHeartbeat,
      @JsonKey(name: 'remark') String? remark,
      @JsonKey(name: 'created_at') String? createdAt});
}
class __$$PrinterImplCopyWithImpl<$Res>
    extends _$PrinterCopyWithImpl<$Res, _$PrinterImpl>
    implements _$$PrinterImplCopyWith<$Res> {
  __$$PrinterImplCopyWithImpl(
      _$PrinterImpl _value, $Res Function(_$PrinterImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? sn = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? typeName = freezed,
    Object? status = freezed,
    Object? statusName = freezed,
    Object? isDefault = freezed,
    Object? online = freezed,
    Object? lastHeartbeat = freezed,
    Object? remark = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$PrinterImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId 
              as int,
      sn: freezed == sn
          ? _value.sn
          : sn 
              as String?,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      type: freezed == type
          ? _value.type
          : type 
              as int?,
      typeName: freezed == typeName
          ? _value.typeName
          : typeName 
              as String?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      statusName: freezed == statusName
          ? _value.statusName
          : statusName 
              as String?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault 
              as int?,
      online: freezed == online
          ? _value.online
          : online 
              as int?,
      lastHeartbeat: freezed == lastHeartbeat
          ? _value.lastHeartbeat
          : lastHeartbeat 
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
class _$PrinterImpl implements _Printer {
  const _$PrinterImpl(
      {required this.id,
      @JsonKey(name: 'store_id') required this.storeId,
      @JsonKey(name: 'sn') this.sn,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'type_name') this.typeName,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'status_name') this.statusName,
      @JsonKey(name: 'is_default') this.isDefault,
      @JsonKey(name: 'online') this.online,
      @JsonKey(name: 'last_heartbeat') this.lastHeartbeat,
      @JsonKey(name: 'remark') this.remark,
      @JsonKey(name: 'created_at') this.createdAt});
  factory _$PrinterImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrinterImplFromJson(json);
  @override
  final int id;
  @override
  @JsonKey(name: 'store_id')
  final int storeId;
  @override
  @JsonKey(name: 'sn')
  final String? sn;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'type')
  final int? type;
  @override
  @JsonKey(name: 'type_name')
  final String? typeName;
  @override
  @JsonKey(name: 'status')
  final int? status;
  @override
  @JsonKey(name: 'status_name')
  final String? statusName;
  @override
  @JsonKey(name: 'is_default')
  final int? isDefault;
  @override
  @JsonKey(name: 'online')
  final int? online;
  @override
  @JsonKey(name: 'last_heartbeat')
  final String? lastHeartbeat;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  String toString() {
    return 'Printer(id: $id, storeId: $storeId, sn: $sn, name: $name, type: $type, typeName: $typeName, status: $status, statusName: $statusName, isDefault: $isDefault, online: $online, lastHeartbeat: $lastHeartbeat, remark: $remark, createdAt: $createdAt)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrinterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusName, statusName) ||
                other.statusName == statusName) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.lastHeartbeat, lastHeartbeat) ||
                other.lastHeartbeat == lastHeartbeat) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      storeId,
      sn,
      name,
      type,
      typeName,
      status,
      statusName,
      isDefault,
      online,
      lastHeartbeat,
      remark,
      createdAt);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrinterImplCopyWith<_$PrinterImpl> get copyWith =>
      __$$PrinterImplCopyWithImpl<_$PrinterImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$PrinterImplToJson(
      this,
    );
  }
}
abstract class _Printer implements Printer {
  const factory _Printer(
      {required final int id,
      @JsonKey(name: 'store_id') required final int storeId,
      @JsonKey(name: 'sn') final String? sn,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'type') final int? type,
      @JsonKey(name: 'type_name') final String? typeName,
      @JsonKey(name: 'status') final int? status,
      @JsonKey(name: 'status_name') final String? statusName,
      @JsonKey(name: 'is_default') final int? isDefault,
      @JsonKey(name: 'online') final int? online,
      @JsonKey(name: 'last_heartbeat') final String? lastHeartbeat,
      @JsonKey(name: 'remark') final String? remark,
      @JsonKey(name: 'created_at') final String? createdAt}) = _$PrinterImpl;
  factory _Printer.fromJson(Map<String, dynamic> json) = _$PrinterImpl.fromJson;
  @override
  int get id;
  @override
  @JsonKey(name: 'store_id')
  int get storeId;
  @override
  @JsonKey(name: 'sn')
  String? get sn;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'type')
  int? get type;
  @override
  @JsonKey(name: 'type_name')
  String? get typeName;
  @override
  @JsonKey(name: 'status')
  int? get status;
  @override
  @JsonKey(name: 'status_name')
  String? get statusName;
  @override
  @JsonKey(name: 'is_default')
  int? get isDefault;
  @override
  @JsonKey(name: 'online')
  int? get online;
  @override
  @JsonKey(name: 'last_heartbeat')
  String? get lastHeartbeat;
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrinterImplCopyWith<_$PrinterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
BindPrinterReq _$BindPrinterReqFromJson(Map<String, dynamic> json) {
  return _BindPrinterReq.fromJson(json);
}
mixin _$BindPrinterReq {
  @JsonKey(name: 'store_id')
  int get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String get sn => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  int? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  int? get isDefault => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BindPrinterReqCopyWith<BindPrinterReq> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $BindPrinterReqCopyWith<$Res> {
  factory $BindPrinterReqCopyWith(
          BindPrinterReq value, $Res Function(BindPrinterReq) then) =
      _$BindPrinterReqCopyWithImpl<$Res, BindPrinterReq>;
  @useResult
  $Res call(
      {@JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'sn') String sn,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'type') int? type,
      @JsonKey(name: 'is_default') int? isDefault,
      @JsonKey(name: 'remark') String? remark});
}
class _$BindPrinterReqCopyWithImpl<$Res, $Val extends BindPrinterReq>
    implements $BindPrinterReqCopyWith<$Res> {
  _$BindPrinterReqCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? sn = null,
    Object? name = freezed,
    Object? type = freezed,
    Object? isDefault = freezed,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      storeId: null == storeId
          ? _value.storeId
          : storeId 
              as int,
      sn: null == sn
          ? _value.sn
          : sn 
              as String,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      type: freezed == type
          ? _value.type
          : type 
              as int?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault 
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ) as $Val);
  }
}
abstract class _$$BindPrinterReqImplCopyWith<$Res>
    implements $BindPrinterReqCopyWith<$Res> {
  factory _$$BindPrinterReqImplCopyWith(_$BindPrinterReqImpl value,
          $Res Function(_$BindPrinterReqImpl) then) =
      __$$BindPrinterReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'store_id') int storeId,
      @JsonKey(name: 'sn') String sn,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'type') int? type,
      @JsonKey(name: 'is_default') int? isDefault,
      @JsonKey(name: 'remark') String? remark});
}
class __$$BindPrinterReqImplCopyWithImpl<$Res>
    extends _$BindPrinterReqCopyWithImpl<$Res, _$BindPrinterReqImpl>
    implements _$$BindPrinterReqImplCopyWith<$Res> {
  __$$BindPrinterReqImplCopyWithImpl(
      _$BindPrinterReqImpl _value, $Res Function(_$BindPrinterReqImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? sn = null,
    Object? name = freezed,
    Object? type = freezed,
    Object? isDefault = freezed,
    Object? remark = freezed,
  }) {
    return _then(_$BindPrinterReqImpl(
      storeId: null == storeId
          ? _value.storeId
          : storeId 
              as int,
      sn: null == sn
          ? _value.sn
          : sn 
              as String,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      type: freezed == type
          ? _value.type
          : type 
              as int?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault 
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$BindPrinterReqImpl implements _BindPrinterReq {
  const _$BindPrinterReqImpl(
      {@JsonKey(name: 'store_id') required this.storeId,
      @JsonKey(name: 'sn') required this.sn,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'is_default') this.isDefault,
      @JsonKey(name: 'remark') this.remark});
  factory _$BindPrinterReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$BindPrinterReqImplFromJson(json);
  @override
  @JsonKey(name: 'store_id')
  final int storeId;
  @override
  @JsonKey(name: 'sn')
  final String sn;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'type')
  final int? type;
  @override
  @JsonKey(name: 'is_default')
  final int? isDefault;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  String toString() {
    return 'BindPrinterReq(storeId: $storeId, sn: $sn, name: $name, type: $type, isDefault: $isDefault, remark: $remark)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BindPrinterReqImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.remark, remark) || other.remark == remark));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, storeId, sn, name, type, isDefault, remark);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BindPrinterReqImplCopyWith<_$BindPrinterReqImpl> get copyWith =>
      __$$BindPrinterReqImplCopyWithImpl<_$BindPrinterReqImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$BindPrinterReqImplToJson(
      this,
    );
  }
}
abstract class _BindPrinterReq implements BindPrinterReq {
  const factory _BindPrinterReq(
      {@JsonKey(name: 'store_id') required final int storeId,
      @JsonKey(name: 'sn') required final String sn,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'type') final int? type,
      @JsonKey(name: 'is_default') final int? isDefault,
      @JsonKey(name: 'remark') final String? remark}) = _$BindPrinterReqImpl;
  factory _BindPrinterReq.fromJson(Map<String, dynamic> json) =
      _$BindPrinterReqImpl.fromJson;
  @override
  @JsonKey(name: 'store_id')
  int get storeId;
  @override
  @JsonKey(name: 'sn')
  String get sn;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'type')
  int? get type;
  @override
  @JsonKey(name: 'is_default')
  int? get isDefault;
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BindPrinterReqImplCopyWith<_$BindPrinterReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
UpdatePrinterReq _$UpdatePrinterReqFromJson(Map<String, dynamic> json) {
  return _UpdatePrinterReq.fromJson(json);
}
mixin _$UpdatePrinterReq {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  int? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  int? get isDefault => throw _privateConstructorUsedError;
  @JsonKey(name: 'remark')
  String? get remark => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePrinterReqCopyWith<UpdatePrinterReq> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $UpdatePrinterReqCopyWith<$Res> {
  factory $UpdatePrinterReqCopyWith(
          UpdatePrinterReq value, $Res Function(UpdatePrinterReq) then) =
      _$UpdatePrinterReqCopyWithImpl<$Res, UpdatePrinterReq>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'type') int? type,
      @JsonKey(name: 'status') int? status,
      @JsonKey(name: 'is_default') int? isDefault,
      @JsonKey(name: 'remark') String? remark});
}
class _$UpdatePrinterReqCopyWithImpl<$Res, $Val extends UpdatePrinterReq>
    implements $UpdatePrinterReqCopyWith<$Res> {
  _$UpdatePrinterReqCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? isDefault = freezed,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      type: freezed == type
          ? _value.type
          : type 
              as int?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault 
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ) as $Val);
  }
}
abstract class _$$UpdatePrinterReqImplCopyWith<$Res>
    implements $UpdatePrinterReqCopyWith<$Res> {
  factory _$$UpdatePrinterReqImplCopyWith(_$UpdatePrinterReqImpl value,
          $Res Function(_$UpdatePrinterReqImpl) then) =
      __$$UpdatePrinterReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'type') int? type,
      @JsonKey(name: 'status') int? status,
      @JsonKey(name: 'is_default') int? isDefault,
      @JsonKey(name: 'remark') String? remark});
}
class __$$UpdatePrinterReqImplCopyWithImpl<$Res>
    extends _$UpdatePrinterReqCopyWithImpl<$Res, _$UpdatePrinterReqImpl>
    implements _$$UpdatePrinterReqImplCopyWith<$Res> {
  __$$UpdatePrinterReqImplCopyWithImpl(_$UpdatePrinterReqImpl _value,
      $Res Function(_$UpdatePrinterReqImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? isDefault = freezed,
    Object? remark = freezed,
  }) {
    return _then(_$UpdatePrinterReqImpl(
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      type: freezed == type
          ? _value.type
          : type 
              as int?,
      status: freezed == status
          ? _value.status
          : status 
              as int?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault 
              as int?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$UpdatePrinterReqImpl implements _UpdatePrinterReq {
  const _$UpdatePrinterReqImpl(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'is_default') this.isDefault,
      @JsonKey(name: 'remark') this.remark});
  factory _$UpdatePrinterReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePrinterReqImplFromJson(json);
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'type')
  final int? type;
  @override
  @JsonKey(name: 'status')
  final int? status;
  @override
  @JsonKey(name: 'is_default')
  final int? isDefault;
  @override
  @JsonKey(name: 'remark')
  final String? remark;
  @override
  String toString() {
    return 'UpdatePrinterReq(name: $name, type: $type, status: $status, isDefault: $isDefault, remark: $remark)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePrinterReqImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.remark, remark) || other.remark == remark));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, type, status, isDefault, remark);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePrinterReqImplCopyWith<_$UpdatePrinterReqImpl> get copyWith =>
      __$$UpdatePrinterReqImplCopyWithImpl<_$UpdatePrinterReqImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePrinterReqImplToJson(
      this,
    );
  }
}
abstract class _UpdatePrinterReq implements UpdatePrinterReq {
  const factory _UpdatePrinterReq(
      {@JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'type') final int? type,
      @JsonKey(name: 'status') final int? status,
      @JsonKey(name: 'is_default') final int? isDefault,
      @JsonKey(name: 'remark') final String? remark}) = _$UpdatePrinterReqImpl;
  factory _UpdatePrinterReq.fromJson(Map<String, dynamic> json) =
      _$UpdatePrinterReqImpl.fromJson;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'type')
  int? get type;
  @override
  @JsonKey(name: 'status')
  int? get status;
  @override
  @JsonKey(name: 'is_default')
  int? get isDefault;
  @override
  @JsonKey(name: 'remark')
  String? get remark;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePrinterReqImplCopyWith<_$UpdatePrinterReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
PrinterListResp _$PrinterListRespFromJson(Map<String, dynamic> json) {
  return _PrinterListResp.fromJson(json);
}
mixin _$PrinterListResp {
  List<Printer> get list => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int? get pageSize => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrinterListRespCopyWith<PrinterListResp> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $PrinterListRespCopyWith<$Res> {
  factory $PrinterListRespCopyWith(
          PrinterListResp value, $Res Function(PrinterListResp) then) =
      _$PrinterListRespCopyWithImpl<$Res, PrinterListResp>;
  @useResult
  $Res call(
      {List<Printer> list,
      @JsonKey(name: 'total') int? total,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'page_size') int? pageSize});
}
class _$PrinterListRespCopyWithImpl<$Res, $Val extends PrinterListResp>
    implements $PrinterListRespCopyWith<$Res> {
  _$PrinterListRespCopyWithImpl(this._value, this._then);
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
              as List<Printer>,
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
abstract class _$$PrinterListRespImplCopyWith<$Res>
    implements $PrinterListRespCopyWith<$Res> {
  factory _$$PrinterListRespImplCopyWith(_$PrinterListRespImpl value,
          $Res Function(_$PrinterListRespImpl) then) =
      __$$PrinterListRespImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Printer> list,
      @JsonKey(name: 'total') int? total,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'page_size') int? pageSize});
}
class __$$PrinterListRespImplCopyWithImpl<$Res>
    extends _$PrinterListRespCopyWithImpl<$Res, _$PrinterListRespImpl>
    implements _$$PrinterListRespImplCopyWith<$Res> {
  __$$PrinterListRespImplCopyWithImpl(
      _$PrinterListRespImpl _value, $Res Function(_$PrinterListRespImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? total = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$PrinterListRespImpl(
      list: null == list
          ? _value._list
          : list 
              as List<Printer>,
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
class _$PrinterListRespImpl implements _PrinterListResp {
  const _$PrinterListRespImpl(
      {required final List<Printer> list,
      @JsonKey(name: 'total') this.total,
      @JsonKey(name: 'page') this.page,
      @JsonKey(name: 'page_size') this.pageSize})
      : _list = list;
  factory _$PrinterListRespImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrinterListRespImplFromJson(json);
  final List<Printer> _list;
  @override
  List<Printer> get list {
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
    return 'PrinterListResp(list: $list, total: $total, page: $page, pageSize: $pageSize)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrinterListRespImpl &&
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
  _$$PrinterListRespImplCopyWith<_$PrinterListRespImpl> get copyWith =>
      __$$PrinterListRespImplCopyWithImpl<_$PrinterListRespImpl>(
          this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$PrinterListRespImplToJson(
      this,
    );
  }
}
abstract class _PrinterListResp implements PrinterListResp {
  const factory _PrinterListResp(
      {required final List<Printer> list,
      @JsonKey(name: 'total') final int? total,
      @JsonKey(name: 'page') final int? page,
      @JsonKey(name: 'page_size') final int? pageSize}) = _$PrinterListRespImpl;
  factory _PrinterListResp.fromJson(Map<String, dynamic> json) =
      _$PrinterListRespImpl.fromJson;
  @override
  List<Printer> get list;
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
  _$$PrinterListRespImplCopyWith<_$PrinterListRespImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
