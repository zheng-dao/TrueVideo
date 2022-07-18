// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CameraResultModel _$$_CameraResultModelFromJson(Map<String, dynamic> json) =>
    _$_CameraResultModel(
      video:
          CameraVideoFileModel.fromJson(json['video'] as Map<String, dynamic>),
      pictures: (json['pictures'] as List<dynamic>?)
              ?.map((e) =>
                  CameraPictureFileModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CameraPictureFileModel>[],
    );

Map<String, dynamic> _$$_CameraResultModelToJson(
        _$_CameraResultModel instance) =>
    <String, dynamic>{
      'video': instance.video.toJson(),
      'pictures': instance.pictures.map((e) => e.toJson()).toList(),
    };
