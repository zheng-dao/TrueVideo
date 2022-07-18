// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoInfoModel _$$_VideoInfoModelFromJson(Map<String, dynamic> json) =>
    _$_VideoInfoModel(
      path: json['path'] as String? ?? "",
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      durationMillis: json['durationMillis'] as int? ?? 0,
      rotation: json['rotation'] as int? ?? 0,
      size: json['size'] as int? ?? 0,
    );

Map<String, dynamic> _$$_VideoInfoModelToJson(_$_VideoInfoModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'width': instance.width,
      'height': instance.height,
      'durationMillis': instance.durationMillis,
      'rotation': instance.rotation,
      'size': instance.size,
    };
