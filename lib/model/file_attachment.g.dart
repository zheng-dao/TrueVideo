// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FileAttachmentModel _$$_FileAttachmentModelFromJson(
        Map<String, dynamic> json) =>
    _$_FileAttachmentModel(
      url: json['url'] as String?,
      contentType: json['contentType'] as String?,
      s3FileKey: json['s3FileKey'] as String?,
      message: json['message'] == null
          ? null
          : TextMessageModel.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FileAttachmentModelToJson(
        _$_FileAttachmentModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'contentType': instance.contentType,
      's3FileKey': instance.s3FileKey,
      'message': instance.message?.toJson(),
    };
