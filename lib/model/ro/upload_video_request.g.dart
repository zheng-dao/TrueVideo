// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_video_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RepairOrderUploadVideoRequestModel
    _$$_RepairOrderUploadVideoRequestModelFromJson(Map<String, dynamic> json) =>
        _$_RepairOrderUploadVideoRequestModel(
          uid: json['uid'] as String? ?? "",
          offlineEnqueueUID: json['offlineEnqueueUID'] as String? ?? "",
          offlineEnqueueStatus: $enumDecodeNullable(
              _$OfflineEnqueueItemStatusEnumMap, json['offlineEnqueueStatus']),
          orderID: json['orderID'] as int? ?? 0,
          orderType: json['orderType'] as String? ?? "",
          cameraResult: json['cameraResult'] == null
              ? null
              : CameraResultModel.fromJson(
                  json['cameraResult'] as Map<String, dynamic>),
          creationDate: DateTimeConverter.fromJson(json['creationDate']),
          updateDate: DateTimeConverter.fromJson(json['updateDate']),
          videoTagID: json['videoTagID'] as String? ?? "",
          videoTypeID: json['videoTypeID'] as String? ?? "",
          videoDescription: json['videoDescription'] as String? ?? "",
        );

Map<String, dynamic> _$$_RepairOrderUploadVideoRequestModelToJson(
        _$_RepairOrderUploadVideoRequestModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'offlineEnqueueUID': instance.offlineEnqueueUID,
      'offlineEnqueueStatus':
          _$OfflineEnqueueItemStatusEnumMap[instance.offlineEnqueueStatus],
      'orderID': instance.orderID,
      'orderType': instance.orderType,
      'cameraResult': instance.cameraResult?.toJson(),
      'creationDate': instance.creationDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'videoTagID': instance.videoTagID,
      'videoTypeID': instance.videoTypeID,
      'videoDescription': instance.videoDescription,
    };

const _$OfflineEnqueueItemStatusEnumMap = {
  OfflineEnqueueItemStatus.pending: 'pending',
  OfflineEnqueueItemStatus.processing: 'processing',
  OfflineEnqueueItemStatus.done: 'done',
  OfflineEnqueueItemStatus.error: 'error',
};
