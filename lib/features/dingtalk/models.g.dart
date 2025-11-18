// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DingTalkRobotImpl _$$DingTalkRobotImplFromJson(Map<String, dynamic> json) =>
    _$DingTalkRobotImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      botType: json['bot_type'] as String? ?? '',
      webhook: json['webhook'] as String? ?? '',
      secret: json['secret'] as String? ?? '',
      clientId: json['client_id'] as String? ?? '',
      clientSecret: json['client_secret'] as String? ?? '',
      agentId: _parseIntFromDynamic(json['agent_id']),
      storeId: (json['store_id'] as num?)?.toInt(),
      isEnabled: json['is_enabled'] as bool? ?? true,
      msgType: json['msg_type'] as String? ?? '',
      robotCode: json['robot_code'] as String? ?? '',
      openConversationId: json['open_conversation_id'] as String?,
      remark: json['remark'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$DingTalkRobotImplToJson(_$DingTalkRobotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bot_type': instance.botType,
      'webhook': instance.webhook,
      'secret': instance.secret,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'agent_id': instance.agentId,
      'store_id': instance.storeId,
      'is_enabled': instance.isEnabled,
      'msg_type': instance.msgType,
      'robot_code': instance.robotCode,
      'open_conversation_id': instance.openConversationId,
      'remark': instance.remark,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$CreateDingTalkRobotRequestImpl _$$CreateDingTalkRobotRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateDingTalkRobotRequestImpl(
      name: json['name'] as String,
      botType: json['bot_type'] as String?,
      webhook: json['webhook'] as String?,
      secret: json['secret'] as String?,
      clientId: json['client_id'] as String?,
      clientSecret: json['client_secret'] as String?,
      agentId: _parseIntFromDynamic(json['agent_id']),
      robotCode: json['robot_code'] as String?,
      storeId: (json['store_id'] as num?)?.toInt(),
      isEnabled: json['is_enabled'] as bool?,
      msgType: json['msg_type'] as String?,
      openConversationId: json['open_conversation_id'] as String?,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$$CreateDingTalkRobotRequestImplToJson(
        _$CreateDingTalkRobotRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'bot_type': instance.botType,
      'webhook': instance.webhook,
      'secret': instance.secret,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'agent_id': _intToDynamic(instance.agentId),
      'robot_code': instance.robotCode,
      'store_id': instance.storeId,
      'is_enabled': instance.isEnabled,
      'msg_type': instance.msgType,
      'open_conversation_id': instance.openConversationId,
      'remark': instance.remark,
    };

_$UpdateDingTalkRobotRequestImpl _$$UpdateDingTalkRobotRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateDingTalkRobotRequestImpl(
      name: json['name'] as String?,
      botType: json['bot_type'] as String?,
      webhook: json['webhook'] as String?,
      secret: json['secret'] as String?,
      clientId: json['client_id'] as String?,
      clientSecret: json['client_secret'] as String?,
      agentId: _parseIntFromDynamic(json['agent_id']),
      robotCode: json['robot_code'] as String?,
      storeId: (json['store_id'] as num?)?.toInt(),
      isEnabled: json['is_enabled'] as bool?,
      msgType: json['msg_type'] as String?,
      openConversationId: json['open_conversation_id'] as String?,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$$UpdateDingTalkRobotRequestImplToJson(
        _$UpdateDingTalkRobotRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'bot_type': instance.botType,
      'webhook': instance.webhook,
      'secret': instance.secret,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'agent_id': _intToDynamic(instance.agentId),
      'robot_code': instance.robotCode,
      'store_id': instance.storeId,
      'is_enabled': instance.isEnabled,
      'msg_type': instance.msgType,
      'open_conversation_id': instance.openConversationId,
      'remark': instance.remark,
    };
