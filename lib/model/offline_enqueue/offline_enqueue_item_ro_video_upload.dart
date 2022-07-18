// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'offline_enqueue_item_ro_video_upload.freezed.dart';

part 'offline_enqueue_item_ro_video_upload.g.dart';

@freezed
class OfflineEnqueueItemRepairOrderVideoUploadModel with _$OfflineEnqueueItemRepairOrderVideoUploadModel {
  const OfflineEnqueueItemRepairOrderVideoUploadModel._();

  @JsonSerializable(explicitToJson: true)
  const factory OfflineEnqueueItemRepairOrderVideoUploadModel({
    @Default("") String videoUploadRequestUID,
    @Default("") String videoEncodedPath,
    @Default("") String videoURL,
    @Default("") String videoThumbnailURL,
    DateTime? videoThumbnailUploadStartAt,
    DateTime? videoThumbnailUploadEndAt,
    @Default(<String, String>{}) Map<String, String> picturesURL,
    @Default(<String, String>{}) Map<String, String> picturesUUIDs,
    DateTime? startAt,
    DateTime? endAt,
    DateTime? videoEncodeStartAt,
    DateTime? videoEncodeEndAt,
    DateTime? videoUploadStartAt,
    DateTime? videoUploadEndAt,
    @Default(<String, DateTime>{}) Map<String, DateTime> pictureUploadStartAt,
    @Default(<String, DateTime>{}) Map<String, DateTime> pictureUploadEndAt,
    @Default(0.0) double progress,
    @Default(false) bool progressVisible,
    @Default(null) int? statusIndex,
    @Default("") String statusData,
  }) = _OfflineEnqueueItemRepairOrderVideoUploadModel;

  factory OfflineEnqueueItemRepairOrderVideoUploadModel.fromJson(Map<String, dynamic> json) =>
      _$OfflineEnqueueItemRepairOrderVideoUploadModelFromJson(json);

  OfflineEnqueueItemRepairOrderVideoUploadStatus? get status {
    if (statusIndex == null) return null;

    try {
      return OfflineEnqueueItemRepairOrderVideoUploadStatus.values[statusIndex!];
    } catch (_) {
      return null;
    }
  }
}

enum OfflineEnqueueItemRepairOrderVideoUploadStatus {
  videoThumbnailUpload,
  videoEncode,
  videoUpload,
  pictureUpload,
  save,
}

extension OfflineEnqueueItemRepairOrderVideoUploadStatusX on OfflineEnqueueItemRepairOrderVideoUploadStatus {
  String get name {
    switch (this) {
      case OfflineEnqueueItemRepairOrderVideoUploadStatus.videoThumbnailUpload:
        return "Uploading video thumbnail";
      case OfflineEnqueueItemRepairOrderVideoUploadStatus.videoEncode:
        return "Encoding video";
      case OfflineEnqueueItemRepairOrderVideoUploadStatus.videoUpload:
        return "Uploading video";
      case OfflineEnqueueItemRepairOrderVideoUploadStatus.pictureUpload:
        return "Uploading picture";
      case OfflineEnqueueItemRepairOrderVideoUploadStatus.save:
        return "Saving";
    }
  }
}
