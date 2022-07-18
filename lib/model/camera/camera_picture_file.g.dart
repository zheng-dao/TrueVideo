// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_picture_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CameraPictureFileModel _$$_CameraPictureFileModelFromJson(
        Map<String, dynamic> json) =>
    _$_CameraPictureFileModel(
      path: json['path'] as String? ?? "",
      size: json['size'] as int? ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$_CameraPictureFileModelToJson(
        _$_CameraPictureFileModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'size': instance.size,
      'width': instance.width,
      'height': instance.height,
    };
