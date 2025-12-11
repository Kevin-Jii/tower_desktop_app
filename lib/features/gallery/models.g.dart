part of 'models.dart';
_$GalleryImageImpl _$$GalleryImageImplFromJson(Map<String, dynamic> json) =>
    _$GalleryImageImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      url: json['url'] as String?,
      thumbUrl: json['thumb_url'] as String?,
      fileSize: (json['file_size'] as num?)?.toInt(),
      mimeType: json['mime_type'] as String?,
      category: json['category'] as String?,
      remark: json['remark'] as String?,
      storeId: (json['store_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
Map<String, dynamic> _$$GalleryImageImplToJson(_$GalleryImageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'thumb_url': instance.thumbUrl,
      'file_size': instance.fileSize,
      'mime_type': instance.mimeType,
      'category': instance.category,
      'remark': instance.remark,
      'store_id': instance.storeId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
_$UpdateGalleryRequestImpl _$$UpdateGalleryRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateGalleryRequestImpl(
      name: json['name'] as String?,
      category: json['category'] as String?,
      remark: json['remark'] as String?,
    );
Map<String, dynamic> _$$UpdateGalleryRequestImplToJson(
        _$UpdateGalleryRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'remark': instance.remark,
    };
