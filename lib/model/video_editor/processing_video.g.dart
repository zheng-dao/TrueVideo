// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoEditorProcessingVideoModel _$$_VideoEditorProcessingVideoModelFromJson(
        Map<String, dynamic> json) =>
    _$_VideoEditorProcessingVideoModel(
      originalPath: json['originalPath'] as String? ?? "",
      loading: json['loading'] as bool? ?? false,
      error: json['error'],
      video:
          CameraVideoFileModel.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_VideoEditorProcessingVideoModelToJson(
        _$_VideoEditorProcessingVideoModel instance) =>
    <String, dynamic>{
      'originalPath': instance.originalPath,
      'loading': instance.loading,
      'error': instance.error,
      'video': instance.video.toJson(),
    };
