part of 'models.dart';
_$PrinterImpl _$$PrinterImplFromJson(Map<String, dynamic> json) =>
    _$PrinterImpl(
      id: (json['id'] as num).toInt(),
      storeId: (json['store_id'] as num).toInt(),
      sn: json['sn'] as String?,
      name: json['name'] as String?,
      type: (json['type'] as num?)?.toInt(),
      typeName: json['type_name'] as String?,
      status: (json['status'] as num?)?.toInt(),
      statusName: json['status_name'] as String?,
      isDefault: (json['is_default'] as num?)?.toInt(),
      online: (json['online'] as num?)?.toInt(),
      lastHeartbeat: json['last_heartbeat'] as String?,
      remark: json['remark'] as String?,
      createdAt: json['created_at'] as String?,
    );
Map<String, dynamic> _$$PrinterImplToJson(_$PrinterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'sn': instance.sn,
      'name': instance.name,
      'type': instance.type,
      'type_name': instance.typeName,
      'status': instance.status,
      'status_name': instance.statusName,
      'is_default': instance.isDefault,
      'online': instance.online,
      'last_heartbeat': instance.lastHeartbeat,
      'remark': instance.remark,
      'created_at': instance.createdAt,
    };
_$BindPrinterReqImpl _$$BindPrinterReqImplFromJson(Map<String, dynamic> json) =>
    _$BindPrinterReqImpl(
      storeId: (json['store_id'] as num).toInt(),
      sn: json['sn'] as String,
      name: json['name'] as String?,
      type: (json['type'] as num?)?.toInt(),
      isDefault: (json['is_default'] as num?)?.toInt(),
      remark: json['remark'] as String?,
    );
Map<String, dynamic> _$$BindPrinterReqImplToJson(
        _$BindPrinterReqImpl instance) =>
    <String, dynamic>{
      'store_id': instance.storeId,
      'sn': instance.sn,
      'name': instance.name,
      'type': instance.type,
      'is_default': instance.isDefault,
      'remark': instance.remark,
    };
_$UpdatePrinterReqImpl _$$UpdatePrinterReqImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePrinterReqImpl(
      name: json['name'] as String?,
      type: (json['type'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      isDefault: (json['is_default'] as num?)?.toInt(),
      remark: json['remark'] as String?,
    );
Map<String, dynamic> _$$UpdatePrinterReqImplToJson(
        _$UpdatePrinterReqImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'status': instance.status,
      'is_default': instance.isDefault,
      'remark': instance.remark,
    };
_$PrinterListRespImpl _$$PrinterListRespImplFromJson(
        Map<String, dynamic> json) =>
    _$PrinterListRespImpl(
      list: (json['list'] as List<dynamic>)
          .map((e) => Printer.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['page_size'] as num?)?.toInt(),
    );
Map<String, dynamic> _$$PrinterListRespImplToJson(
        _$PrinterListRespImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'page': instance.page,
      'page_size': instance.pageSize,
    };
