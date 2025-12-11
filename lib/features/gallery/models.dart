import 'package:freezed_annotation/freezed_annotation.dart';
part 'models.freezed.dart';
part 'models.g.dart';
class GalleryCategory {
  static const String product = 'product';
  static const String supplier = 'supplier';
  static const String avatar = 'avatar';
  static const String other = 'other';
  static const Map<String, String> labels = {
    product: '商品图片',
    supplier: '供应商',
    avatar: '头像',
    other: '其他',
  };
}
@freezed
class GalleryImage with _$GalleryImage {
  const factory GalleryImage({
    required int id,
    String? name,
    String? url,
    @JsonKey(name: 'thumb_url') String? thumbUrl,
    @JsonKey(name: 'file_size') int? fileSize,
    @JsonKey(name: 'mime_type') String? mimeType,
    String? category,
    String? remark,
    @JsonKey(name: 'store_id') int? storeId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _GalleryImage;
  factory GalleryImage.fromJson(Map<String, dynamic> json) =>
      _$GalleryImageFromJson(json);
}
@freezed
class UpdateGalleryRequest with _$UpdateGalleryRequest {
  const factory UpdateGalleryRequest({
    String? name,
    String? category,
    String? remark,
  }) = _UpdateGalleryRequest;
  factory UpdateGalleryRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateGalleryRequestFromJson(json);
}
