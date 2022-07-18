// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoEditorRequestVideoModel _$$_VideoEditorRequestVideoModelFromJson(
        Map<String, dynamic> json) =>
    _$_VideoEditorRequestVideoModel(
      path: json['path'] as String? ?? "",
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$_VideoEditorRequestVideoModelToJson(
        _$_VideoEditorRequestVideoModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'rotation': instance.rotation,
    };
