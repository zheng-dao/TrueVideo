// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TemplateReply _$$_TemplateReplyFromJson(Map<String, dynamic> json) =>
    _$_TemplateReply(
      reply: ReplyForm.fromJson(json['reply'] as Map<String, dynamic>),
      template: Template.fromJson(json['template'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TemplateReplyToJson(_$_TemplateReply instance) =>
    <String, dynamic>{
      'reply': instance.reply,
      'template': instance.template,
    };
