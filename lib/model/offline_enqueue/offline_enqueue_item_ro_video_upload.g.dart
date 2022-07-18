// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_enqueue_item_ro_video_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OfflineEnqueueItemRepairOrderVideoUploadModel
    _$$_OfflineEnqueueItemRepairOrderVideoUploadModelFromJson(
            Map<String, dynamic> json) =>
        _$_OfflineEnqueueItemRepairOrderVideoUploadModel(
          videoUploadRequestUID: json['videoUploadRequestUID'] as String? ?? "",
          videoEncodedPath: json['videoEncodedPath'] as String? ?? "",
          videoURL: json['videoURL'] as String? ?? "",
          videoThumbnailURL: json['videoThumbnailURL'] as String? ?? "",
          videoThumbnailUploadStartAt: json['videoThumbnailUploadStartAt'] ==
                  null
              ? null
              : DateTime.parse(json['videoThumbnailUploadStartAt'] as String),
          videoThumbnailUploadEndAt: json['videoThumbnailUploadEndAt'] == null
              ? null
              : DateTime.parse(json['videoThumbnailUploadEndAt'] as String),
          picturesURL: (json['picturesURL'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const <String, String>{},
          picturesUUIDs: (json['picturesUUIDs'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const <String, String>{},
          startAt: json['startAt'] == null
              ? null
              : DateTime.parse(json['startAt'] as String),
          endAt: json['endAt'] == null
              ? null
              : DateTime.parse(json['endAt'] as String),
          videoEncodeStartAt: json['videoEncodeStartAt'] == null
              ? null
              : DateTime.parse(json['videoEncodeStartAt'] as String),
          videoEncodeEndAt: json['videoEncodeEndAt'] == null
              ? null
              : DateTime.parse(json['videoEncodeEndAt'] as String),
          videoUploadStartAt: json['videoUploadStartAt'] == null
              ? null
              : DateTime.parse(json['videoUploadStartAt'] as String),
          videoUploadEndAt: json['videoUploadEndAt'] == null
              ? null
              : DateTime.parse(json['videoUploadEndAt'] as String),
          pictureUploadStartAt:
              (json['pictureUploadStartAt'] as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, DateTime.parse(e as String)),
                  ) ??
                  const <String, DateTime>{},
          pictureUploadEndAt:
              (json['pictureUploadEndAt'] as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, DateTime.parse(e as String)),
                  ) ??
                  const <String, DateTime>{},
          progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
          progressVisible: json['progressVisible'] as bool? ?? false,
          statusIndex: json['statusIndex'] as int? ?? null,
          statusData: json['statusData'] as String? ?? "",
        );

Map<String, dynamic> _$$_OfflineEnqueueItemRepairOrderVideoUploadModelToJson(
        _$_OfflineEnqueueItemRepairOrderVideoUploadModel instance) =>
    <String, dynamic>{
      'videoUploadRequestUID': instance.videoUploadRequestUID,
      'videoEncodedPath': instance.videoEncodedPath,
      'videoURL': instance.videoURL,
      'videoThumbnailURL': instance.videoThumbnailURL,
      'videoThumbnailUploadStartAt':
          instance.videoThumbnailUploadStartAt?.toIso8601String(),
      'videoThumbnailUploadEndAt':
          instance.videoThumbnailUploadEndAt?.toIso8601String(),
      'picturesURL': instance.picturesURL,
      'picturesUUIDs': instance.picturesUUIDs,
      'startAt': instance.startAt?.toIso8601String(),
      'endAt': instance.endAt?.toIso8601String(),
      'videoEncodeStartAt': instance.videoEncodeStartAt?.toIso8601String(),
      'videoEncodeEndAt': instance.videoEncodeEndAt?.toIso8601String(),
      'videoUploadStartAt': instance.videoUploadStartAt?.toIso8601String(),
      'videoUploadEndAt': instance.videoUploadEndAt?.toIso8601String(),
      'pictureUploadStartAt': instance.pictureUploadStartAt
          .map((k, e) => MapEntry(k, e.toIso8601String())),
      'pictureUploadEndAt': instance.pictureUploadEndAt
          .map((k, e) => MapEntry(k, e.toIso8601String())),
      'progress': instance.progress,
      'progressVisible': instance.progressVisible,
      'statusIndex': instance.statusIndex,
      'statusData': instance.statusData,
    };
