// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TextMessageModel _$$_TextMessageModelFromJson(Map<String, dynamic> json) =>
    _$_TextMessageModel(
      conversationId: json['conversationId'] as int? ?? 0,
      direction: json['direction'] as String? ?? "",
      message: json['message'] as String? ?? "",
      from: json['from'] as String? ?? "",
      to: json['to'] as String? ?? "",
      attachment: json['attachment'] == null
          ? null
          : FileInfoModel.fromJson(json['attachment'] as Map<String, dynamic>),
      mmsAttachment: json['mmsAttachment'] == null
          ? null
          : FileAttachmentModel.fromJson(
              json['mmsAttachment'] as Map<String, dynamic>),
      deliveryStatus: json['deliveryStatus'] as String? ?? "",
      dateTimeSent: DateTimeConverter.fromJson(json['createDate']),
    );

Map<String, dynamic> _$$_TextMessageModelToJson(_$_TextMessageModel instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'direction': instance.direction,
      'message': instance.message,
      'from': instance.from,
      'to': instance.to,
      'attachment': instance.attachment?.toJson(),
      'mmsAttachment': instance.mmsAttachment?.toJson(),
      'deliveryStatus': instance.deliveryStatus,
      'createDate': instance.dateTimeSent?.toIso8601String(),
    };
