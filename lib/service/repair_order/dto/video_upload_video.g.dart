// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_upload_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoUploadVideoDTO _$$_VideoUploadVideoDTOFromJson(
        Map<String, dynamic> json) =>
    _$_VideoUploadVideoDTO(
      thumbnail: json['thumbnail'] as String? ?? "",
      videoLink: json['videoLink'] as String? ?? "",
      length: json['length'] as int? ?? 0,
      videoTag: json['videoTag'] as String? ?? "",
      videoType: json['videoType'] as String? ?? "",
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$$_VideoUploadVideoDTOToJson(
        _$_VideoUploadVideoDTO instance) =>
    <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'videoLink': instance.videoLink,
      'length': instance.length,
      'videoTag': instance.videoTag,
      'videoType': instance.videoType,
      'description': instance.description,
    };
