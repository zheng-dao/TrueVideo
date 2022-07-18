// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/camera/camera_result.dart';
import 'package:truvideo_enterprise/model/converter/date.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';

part 'upload_video_request.freezed.dart';

part 'upload_video_request.g.dart';

@freezed
class RepairOrderUploadVideoRequestModel with _$RepairOrderUploadVideoRequestModel {
  const RepairOrderUploadVideoRequestModel._();

  @JsonSerializable(explicitToJson: true)
  const factory RepairOrderUploadVideoRequestModel({
    @Default("") String uid,
    @Default("") String offlineEnqueueUID,
    OfflineEnqueueItemStatus? offlineEnqueueStatus,
    @Default(0) int orderID,
    @Default("") String orderType,
    CameraResultModel? cameraResult,
    @JsonKey(name: "creationDate", fromJson: DateTimeConverter.fromJson) DateTime? creationDate,
    @JsonKey(name: "updateDate", fromJson: DateTimeConverter.fromJson) DateTime? updateDate,
    @Default("") String videoTagID,
    @Default("") String videoTypeID,
    @Default("") String videoDescription,
  }) = _RepairOrderUploadVideoRequestModel;

  factory RepairOrderUploadVideoRequestModel.fromJson(Map<String, dynamic> json) => _$RepairOrderUploadVideoRequestModelFromJson(json);
}
