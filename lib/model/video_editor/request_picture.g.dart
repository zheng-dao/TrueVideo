// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoEditorRequestPictureModel _$$_VideoEditorRequestPictureModelFromJson(
        Map<String, dynamic> json) =>
    _$_VideoEditorRequestPictureModel(
      path: json['path'] as String? ?? "",
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0.0,
      flipHorizontal: json['flipHorizontal'] as bool? ?? false,
    );

Map<String, dynamic> _$$_VideoEditorRequestPictureModelToJson(
        _$_VideoEditorRequestPictureModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'rotation': instance.rotation,
      'flipHorizontal': instance.flipHorizontal,
    };
