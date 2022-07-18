// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoUploadDTO _$$_VideoUploadDTOFromJson(Map<String, dynamic> json) =>
    _$_VideoUploadDTO(
      videoDTO: json['videoDTO'] == null
          ? null
          : VideoUploadVideoDTO.fromJson(
              json['videoDTO'] as Map<String, dynamic>),
      imageDTO: (json['imageDTO'] as List<dynamic>?)
              ?.map((e) =>
                  VideoUploadImageDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VideoUploadImageDTO>[],
    );

Map<String, dynamic> _$$_VideoUploadDTOToJson(_$_VideoUploadDTO instance) =>
    <String, dynamic>{
      'videoDTO': instance.videoDTO?.toJson(),
      'imageDTO': instance.imageDTO.map((e) => e.toJson()).toList(),
    };
