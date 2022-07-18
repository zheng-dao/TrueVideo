// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoEditorProcessingPictureModel
    _$$_VideoEditorProcessingPictureModelFromJson(Map<String, dynamic> json) =>
        _$_VideoEditorProcessingPictureModel(
          originalPath: json['originalPath'] as String? ?? "",
          loading: json['loading'] as bool? ?? false,
          error: json['error'],
          picture: CameraPictureFileModel.fromJson(
              json['picture'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_VideoEditorProcessingPictureModelToJson(
        _$_VideoEditorProcessingPictureModel instance) =>
    <String, dynamic>{
      'originalPath': instance.originalPath,
      'loading': instance.loading,
      'error': instance.error,
      'picture': instance.picture.toJson(),
    };
