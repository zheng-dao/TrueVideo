// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_call_participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageCallParticipantModel _$$_MessageCallParticipantModelFromJson(
        Map<String, dynamic> json) =>
    _$_MessageCallParticipantModel(
      callSid: json['callSid'] as String? ?? "",
      conferenceSid: json['conferenceSid'] as String? ?? "",
      messageableEntityUID: json['messageableEntityUID'] as String? ?? "",
      messageableEntityDisplayName:
          json['messageableEntityDisplayName'] as String? ?? "",
      status: json['status'] as String? ?? "",
      hold: json['hold'] as bool? ?? false,
      muted: json['muted'] as bool? ?? false,
      createdAt: DateTimeConverter.fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$_MessageCallParticipantModelToJson(
        _$_MessageCallParticipantModel instance) =>
    <String, dynamic>{
      'callSid': instance.callSid,
      'conferenceSid': instance.conferenceSid,
      'messageableEntityUID': instance.messageableEntityUID,
      'messageableEntityDisplayName': instance.messageableEntityDisplayName,
      'status': instance.status,
      'hold': instance.hold,
      'muted': instance.muted,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
