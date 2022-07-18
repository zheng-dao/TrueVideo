// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoSessionModel _$$_VideoSessionModelFromJson(Map<String, dynamic> json) =>
    _$_VideoSessionModel(
      videos: (json['videos'] as List<dynamic>?)
              ?.map((e) =>
                  VideoSessionFileModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VideoSessionFileModel>[],
      pictures: (json['pictures'] as List<dynamic>?)
              ?.map((e) =>
                  VideoSessionFileModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VideoSessionFileModel>[],
      uid: json['uid'] as String? ?? "",
      tag: json['tag'] as String? ?? "",
      createdAt: DateTimeConverter.fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$_VideoSessionModelToJson(
        _$_VideoSessionModel instance) =>
    <String, dynamic>{
      'videos': instance.videos.map((e) => e.toJson()).toList(),
      'pictures': instance.pictures.map((e) => e.toJson()).toList(),
      'uid': instance.uid,
      'tag': instance.tag,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
