// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_upload_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoUploadImageDTO _$$_VideoUploadImageDTOFromJson(
        Map<String, dynamic> json) =>
    _$_VideoUploadImageDTO(
      name: json['name'] as String? ?? "",
      fileId: json['fileId'] as String? ?? "",
      contentType: json['contentType'] as String? ?? "",
      url: json['url'] as String? ?? "",
      size: json['size'] as int? ?? 0,
    );

Map<String, dynamic> _$$_VideoUploadImageDTOToJson(
        _$_VideoUploadImageDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fileId': instance.fileId,
      'contentType': instance.contentType,
      'url': instance.url,
      'size': instance.size,
    };
