part of 'models.dart';
T _$identity<T>(T value) => value;
final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https:
GalleryImage _$GalleryImageFromJson(Map<String, dynamic> json) {
  return _GalleryImage.fromJson(json);
}
mixin _$GalleryImage {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumb_url')
  String? get thumbUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_size')
  int? get fileSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'mime_type')
  String? get mimeType => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  int? get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GalleryImageCopyWith<GalleryImage> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $GalleryImageCopyWith<$Res> {
  factory $GalleryImageCopyWith(
          GalleryImage value, $Res Function(GalleryImage) then) =
      _$GalleryImageCopyWithImpl<$Res, GalleryImage>;
  @useResult
  $Res call(
      {int id,
      String? name,
      String? url,
      @JsonKey(name: 'thumb_url') String? thumbUrl,
      @JsonKey(name: 'file_size') int? fileSize,
      @JsonKey(name: 'mime_type') String? mimeType,
      String? category,
      String? remark,
      @JsonKey(name: 'store_id') int? storeId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}
class _$GalleryImageCopyWithImpl<$Res, $Val extends GalleryImage>
    implements $GalleryImageCopyWith<$Res> {
  _$GalleryImageCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? url = freezed,
    Object? thumbUrl = freezed,
    Object? fileSize = freezed,
    Object? mimeType = freezed,
    Object? category = freezed,
    Object? remark = freezed,
    Object? storeId = freezed,
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
      url: freezed == url
          ? _value.url
          : url 
              as String?,
      thumbUrl: freezed == thumbUrl
          ? _value.thumbUrl
          : thumbUrl 
              as String?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize 
              as int?,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType 
              as String?,
      category: freezed == category
          ? _value.category
          : category 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId 
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
abstract class _$$GalleryImageImplCopyWith<$Res>
    implements $GalleryImageCopyWith<$Res> {
  factory _$$GalleryImageImplCopyWith(
          _$GalleryImageImpl value, $Res Function(_$GalleryImageImpl) then) =
      __$$GalleryImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      String? url,
      @JsonKey(name: 'thumb_url') String? thumbUrl,
      @JsonKey(name: 'file_size') int? fileSize,
      @JsonKey(name: 'mime_type') String? mimeType,
      String? category,
      String? remark,
      @JsonKey(name: 'store_id') int? storeId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}
class __$$GalleryImageImplCopyWithImpl<$Res>
    extends _$GalleryImageCopyWithImpl<$Res, _$GalleryImageImpl>
    implements _$$GalleryImageImplCopyWith<$Res> {
  __$$GalleryImageImplCopyWithImpl(
      _$GalleryImageImpl _value, $Res Function(_$GalleryImageImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? url = freezed,
    Object? thumbUrl = freezed,
    Object? fileSize = freezed,
    Object? mimeType = freezed,
    Object? category = freezed,
    Object? remark = freezed,
    Object? storeId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$GalleryImageImpl(
      id: null == id
          ? _value.id
          : id 
              as int,
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      url: freezed == url
          ? _value.url
          : url 
              as String?,
      thumbUrl: freezed == thumbUrl
          ? _value.thumbUrl
          : thumbUrl 
              as String?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize 
              as int?,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType 
              as String?,
      category: freezed == category
          ? _value.category
          : category 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId 
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
class _$GalleryImageImpl implements _GalleryImage {
  const _$GalleryImageImpl(
      {required this.id,
      this.name,
      this.url,
      @JsonKey(name: 'thumb_url') this.thumbUrl,
      @JsonKey(name: 'file_size') this.fileSize,
      @JsonKey(name: 'mime_type') this.mimeType,
      this.category,
      this.remark,
      @JsonKey(name: 'store_id') this.storeId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});
  factory _$GalleryImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$GalleryImageImplFromJson(json);
  @override
  final int id;
  @override
  final String? name;
  @override
  final String? url;
  @override
  @JsonKey(name: 'thumb_url')
  final String? thumbUrl;
  @override
  @JsonKey(name: 'file_size')
  final int? fileSize;
  @override
  @JsonKey(name: 'mime_type')
  final String? mimeType;
  @override
  final String? category;
  @override
  final String? remark;
  @override
  @JsonKey(name: 'store_id')
  final int? storeId;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  String toString() {
    return 'GalleryImage(id: $id, name: $name, url: $url, thumbUrl: $thumbUrl, fileSize: $fileSize, mimeType: $mimeType, category: $category, remark: $remark, storeId: $storeId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GalleryImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbUrl, thumbUrl) ||
                other.thumbUrl == thumbUrl) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, url, thumbUrl,
      fileSize, mimeType, category, remark, storeId, createdAt, updatedAt);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GalleryImageImplCopyWith<_$GalleryImageImpl> get copyWith =>
      __$$GalleryImageImplCopyWithImpl<_$GalleryImageImpl>(this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$GalleryImageImplToJson(
      this,
    );
  }
}
abstract class _GalleryImage implements GalleryImage {
  const factory _GalleryImage(
          {required final int id,
          final String? name,
          final String? url,
          @JsonKey(name: 'thumb_url') final String? thumbUrl,
          @JsonKey(name: 'file_size') final int? fileSize,
          @JsonKey(name: 'mime_type') final String? mimeType,
          final String? category,
          final String? remark,
          @JsonKey(name: 'store_id') final int? storeId,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt}) =
      _$GalleryImageImpl;
  factory _GalleryImage.fromJson(Map<String, dynamic> json) =
      _$GalleryImageImpl.fromJson;
  @override
  int get id;
  @override
  String? get name;
  @override
  String? get url;
  @override
  @JsonKey(name: 'thumb_url')
  String? get thumbUrl;
  @override
  @JsonKey(name: 'file_size')
  int? get fileSize;
  @override
  @JsonKey(name: 'mime_type')
  String? get mimeType;
  @override
  String? get category;
  @override
  String? get remark;
  @override
  @JsonKey(name: 'store_id')
  int? get storeId;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GalleryImageImplCopyWith<_$GalleryImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
UpdateGalleryRequest _$UpdateGalleryRequestFromJson(Map<String, dynamic> json) {
  return _UpdateGalleryRequest.fromJson(json);
}
mixin _$UpdateGalleryRequest {
  String? get name => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get remark => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateGalleryRequestCopyWith<UpdateGalleryRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
abstract class $UpdateGalleryRequestCopyWith<$Res> {
  factory $UpdateGalleryRequestCopyWith(UpdateGalleryRequest value,
          $Res Function(UpdateGalleryRequest) then) =
      _$UpdateGalleryRequestCopyWithImpl<$Res, UpdateGalleryRequest>;
  @useResult
  $Res call({String? name, String? category, String? remark});
}
class _$UpdateGalleryRequestCopyWithImpl<$Res,
        $Val extends UpdateGalleryRequest>
    implements $UpdateGalleryRequestCopyWith<$Res> {
  _$UpdateGalleryRequestCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? category = freezed,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      category: freezed == category
          ? _value.category
          : category 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ) as $Val);
  }
}
abstract class _$$UpdateGalleryRequestImplCopyWith<$Res>
    implements $UpdateGalleryRequestCopyWith<$Res> {
  factory _$$UpdateGalleryRequestImplCopyWith(_$UpdateGalleryRequestImpl value,
          $Res Function(_$UpdateGalleryRequestImpl) then) =
      __$$UpdateGalleryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? category, String? remark});
}
class __$$UpdateGalleryRequestImplCopyWithImpl<$Res>
    extends _$UpdateGalleryRequestCopyWithImpl<$Res, _$UpdateGalleryRequestImpl>
    implements _$$UpdateGalleryRequestImplCopyWith<$Res> {
  __$$UpdateGalleryRequestImplCopyWithImpl(_$UpdateGalleryRequestImpl _value,
      $Res Function(_$UpdateGalleryRequestImpl) _then)
      : super(_value, _then);
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? category = freezed,
    Object? remark = freezed,
  }) {
    return _then(_$UpdateGalleryRequestImpl(
      name: freezed == name
          ? _value.name
          : name 
              as String?,
      category: freezed == category
          ? _value.category
          : category 
              as String?,
      remark: freezed == remark
          ? _value.remark
          : remark 
              as String?,
    ));
  }
}
@JsonSerializable()
class _$UpdateGalleryRequestImpl implements _UpdateGalleryRequest {
  const _$UpdateGalleryRequestImpl({this.name, this.category, this.remark});
  factory _$UpdateGalleryRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateGalleryRequestImplFromJson(json);
  @override
  final String? name;
  @override
  final String? category;
  @override
  final String? remark;
  @override
  String toString() {
    return 'UpdateGalleryRequest(name: $name, category: $category, remark: $remark)';
  }
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateGalleryRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.remark, remark) || other.remark == remark));
  }
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, category, remark);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateGalleryRequestImplCopyWith<_$UpdateGalleryRequestImpl>
      get copyWith =>
          __$$UpdateGalleryRequestImplCopyWithImpl<_$UpdateGalleryRequestImpl>(
              this, _$identity);
  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateGalleryRequestImplToJson(
      this,
    );
  }
}
abstract class _UpdateGalleryRequest implements UpdateGalleryRequest {
  const factory _UpdateGalleryRequest(
      {final String? name,
      final String? category,
      final String? remark}) = _$UpdateGalleryRequestImpl;
  factory _UpdateGalleryRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateGalleryRequestImpl.fromJson;
  @override
  String? get name;
  @override
  String? get category;
  @override
  String? get remark;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateGalleryRequestImplCopyWith<_$UpdateGalleryRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
