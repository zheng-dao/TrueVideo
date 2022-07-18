// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReplyForm _$$_ReplyFormFromJson(Map<String, dynamic> json) => _$_ReplyForm(
      uid: json['uid'] as String?,
      templateUID: json['templateUID'] as String? ?? "",
      templateVersion: json['templateVersion'] as String? ?? "",
      accountUID: json['accountUID'] as String? ?? "",
      createdAt: json['createdAt'] as String? ?? "",
      updatedAt: json['updatedAt'] as String? ?? "",
      assigneeUID: json['assigneeUID'] as String? ?? "",
      entityType: json['entityType'] as String? ?? "",
      entityUID: json['entityUID'] as String? ?? "",
      visibleFor: json['visibleFor'] as String? ?? "",
      replyStatus: json['replyStatus'] as String? ?? "",
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Reply>[],
    );

Map<String, dynamic> _$$_ReplyFormToJson(_$_ReplyForm instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'templateUID': instance.templateUID,
      'templateVersion': instance.templateVersion,
      'accountUID': instance.accountUID,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'assigneeUID': instance.assigneeUID,
      'entityType': instance.entityType,
      'entityUID': instance.entityUID,
      'visibleFor': instance.visibleFor,
      'replyStatus': instance.replyStatus,
      'replies': instance.replies.map((e) => e.toJson()).toList(),
    };
