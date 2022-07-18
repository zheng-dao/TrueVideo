// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_order_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RepairOrderConversationModel _$$_RepairOrderConversationModelFromJson(
        Map<String, dynamic> json) =>
    _$_RepairOrderConversationModel(
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => TextMessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastTextMessage: json['lastTextMessage'] == null
          ? null
          : TextMessageModel.fromJson(
              json['lastTextMessage'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      status: json['status'] as String?,
      owner: json['owner'] == null
          ? null
          : TCEUserModel.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RepairOrderConversationModelToJson(
        _$_RepairOrderConversationModel instance) =>
    <String, dynamic>{
      'messages': instance.messages?.map((e) => e.toJson()).toList(),
      'lastTextMessage': instance.lastTextMessage?.toJson(),
      'customer': instance.customer?.toJson(),
      'status': instance.status,
      'owner': instance.owner?.toJson(),
    };
