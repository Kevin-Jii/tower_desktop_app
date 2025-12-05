import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// 字典类型
@freezed
class DictType with _$DictType {
  const factory DictType({
    required int id,
    required String code,
    required String name,
    String? remark,
    @Default(1) int status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _DictType;

  factory DictType.fromJson(Map<String, dynamic> json) => _$DictTypeFromJson(json);
}

/// 字典数据
@freezed
class DictData with _$DictData {
  const factory DictData({
    required int id,
    @JsonKey(name: 'type_id') required int typeId,
    @JsonKey(name: 'type_code') required String typeCode,
    required String label,
    required String value,
    @Default(0) int sort,
    @JsonKey(name: 'css_class') String? cssClass,
    @JsonKey(name: 'list_class') String? listClass,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    String? remark,
    @Default(1) int status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _DictData;

  factory DictData.fromJson(Map<String, dynamic> json) => _$DictDataFromJson(json);
}

/// 创建字典类型请求
class CreateDictTypeRequest {
  final String code;
  final String name;
  final String? remark;
  final int status;

  CreateDictTypeRequest({
    required this.code,
    required this.name,
    this.remark,
    this.status = 1,
  });

  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    if (remark != null && remark!.isNotEmpty) 'remark': remark,
    'status': status,
  };
}

/// 更新字典类型请求
class UpdateDictTypeRequest {
  final String? code;
  final String? name;
  final String? remark;
  final int? status;

  UpdateDictTypeRequest({this.code, this.name, this.remark, this.status});

  Map<String, dynamic> toJson() => {
    if (code != null) 'code': code,
    if (name != null) 'name': name,
    if (remark != null) 'remark': remark,
    if (status != null) 'status': status,
  };
}

/// 创建字典数据请求
class CreateDictDataRequest {
  final String typeCode;
  final String label;
  final String value;
  final int sort;
  final String? cssClass;
  final String? listClass;
  final bool isDefault;
  final String? remark;
  final int status;

  CreateDictDataRequest({
    required this.typeCode,
    required this.label,
    required this.value,
    this.sort = 0,
    this.cssClass,
    this.listClass,
    this.isDefault = false,
    this.remark,
    this.status = 1,
  });

  Map<String, dynamic> toJson() => {
    'type_code': typeCode,
    'label': label,
    'value': value,
    'sort': sort,
    if (cssClass != null && cssClass!.isNotEmpty) 'css_class': cssClass,
    if (listClass != null && listClass!.isNotEmpty) 'list_class': listClass,
    'is_default': isDefault,
    if (remark != null && remark!.isNotEmpty) 'remark': remark,
    'status': status,
  };
}

/// 更新字典数据请求
class UpdateDictDataRequest {
  final String? label;
  final String? value;
  final int? sort;
  final String? cssClass;
  final String? listClass;
  final bool? isDefault;
  final String? remark;
  final int? status;

  UpdateDictDataRequest({
    this.label,
    this.value,
    this.sort,
    this.cssClass,
    this.listClass,
    this.isDefault,
    this.remark,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    if (label != null) 'label': label,
    if (value != null) 'value': value,
    if (sort != null) 'sort': sort,
    if (cssClass != null) 'css_class': cssClass,
    if (listClass != null) 'list_class': listClass,
    if (isDefault != null) 'is_default': isDefault,
    if (remark != null) 'remark': remark,
    if (status != null) 'status': status,
  };
}
