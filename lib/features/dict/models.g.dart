// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DictTypeImpl _$$DictTypeImplFromJson(Map<String, dynamic> json) =>
    _$DictTypeImpl(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
      remark: json['remark'] as String?,
      status: (json['status'] as num?)?.toInt() ?? 1,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$DictTypeImplToJson(_$DictTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'remark': instance.remark,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$DictDataImpl _$$DictDataImplFromJson(Map<String, dynamic> json) =>
    _$DictDataImpl(
      id: (json['id'] as num).toInt(),
      typeId: (json['type_id'] as num).toInt(),
      typeCode: json['type_code'] as String,
      label: json['label'] as String,
      value: json['value'] as String,
      sort: (json['sort'] as num?)?.toInt() ?? 0,
      cssClass: json['css_class'] as String?,
      listClass: json['list_class'] as String?,
      isDefault: json['is_default'] as bool? ?? false,
      remark: json['remark'] as String?,
      status: (json['status'] as num?)?.toInt() ?? 1,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$DictDataImplToJson(_$DictDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type_id': instance.typeId,
      'type_code': instance.typeCode,
      'label': instance.label,
      'value': instance.value,
      'sort': instance.sort,
      'css_class': instance.cssClass,
      'list_class': instance.listClass,
      'is_default': instance.isDefault,
      'remark': instance.remark,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
