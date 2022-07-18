// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Reply _$$_ReplyFromJson(Map<String, dynamic> json) => _$_Reply(
      itemUID: json['itemUID'] as String,
      replyExtraNote: (json['replyExtraNote'] as List<dynamic>?)
          ?.map((e) => ReplyExtraNote.fromJson(e as Map<String, dynamic>))
          .toList(),
      replyItemValues: (json['replyItemValues'] as List<dynamic>?)
          ?.map((e) => ReplyItemValues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ReplyToJson(_$_Reply instance) => <String, dynamic>{
      'itemUID': instance.itemUID,
      'replyExtraNote':
          instance.replyExtraNote?.map((e) => e.toJson()).toList(),
      'replyItemValues':
          instance.replyItemValues?.map((e) => e.toJson()).toList(),
    };
