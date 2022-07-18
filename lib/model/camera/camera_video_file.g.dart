// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_video_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CameraVideoFileModel _$$_CameraVideoFileModelFromJson(
        Map<String, dynamic> json) =>
    _$_CameraVideoFileModel(
      info: VideoInfoModel.fromJson(json['info'] as Map<String, dynamic>),
      thumbnailPath: json['thumbnailPath'] as String? ?? "",
    );

Map<String, dynamic> _$$_CameraVideoFileModelToJson(
        _$_CameraVideoFileModel instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'thumbnailPath': instance.thumbnailPath,
    };
