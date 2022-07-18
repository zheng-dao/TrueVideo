import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/core/video.dart';
import 'package:truvideo_enterprise/model/camera/camera_picture_file.dart';
import 'package:truvideo_enterprise/model/event_bus/event_video_uploaded.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/event_bus/_interface.dart';
import 'package:truvideo_enterprise/service/file_bucket/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface_item.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/service/repair_order/dto/video_upload.dart';
import 'package:truvideo_enterprise/service/repair_order/dto/video_upload_image.dart';
import 'package:truvideo_enterprise/service/repair_order/dto/video_upload_video.dart';
import 'package:uuid/uuid.dart';

class OfflineEnqueueVideoUploadServiceImpl extends OfflineEnqueueItemService {
  RepairOrderService get _repairOrderService => GetIt.I.get();

  FileBucketService get _fileBucketService => GetIt.I.get();

  LogEventService get _logEventService => GetIt.I.get();

  EventBusService get _eventBusService => GetIt.I.get();

  OfflineEnqueueService get _offlineEnqueueService => GetIt.I.get();

  String get _boxName => "offline-enqueue-items";

  Future<OfflineEnqueueItemRepairOrderVideoUploadModel?> _getDataByUid(String uid) async {
    final model = await _offlineEnqueueService.getByUID(uid);
    if (model == null) return null;
    try {
      return OfflineEnqueueItemRepairOrderVideoUploadModel.fromJson(model.data!);
    } catch (error) {
      log("Error parsing OfflineEnqueueItemRepairOrderVideoUploadModel", error: error);
      return null;
    }
  }

  Future<OfflineEnqueueItemModel> _update(String uid, OfflineEnqueueItemModel model) async {
    final updatedModel = model.copyWith(updatedAt: DateTime.now());
    final LocalDatabaseService localDatabaseService = GetIt.I.get();
    await localDatabaseService.write(_boxName, uid, updatedModel.toJson());
    return updatedModel;
  }

  Future<OfflineEnqueueItemRepairOrderVideoUploadModel> _updateDataByUid(String uid, OfflineEnqueueItemRepairOrderVideoUploadModel data) async {
    final model = await _offlineEnqueueService.getByUID(uid);
    if (model == null) throw CustomException(message: "Request data not found");
    await _update(
      uid,
      model.copyWith(data: data.toJson()),
    );
    return data;
  }

  @override
  Future<void> onDone(String uid) async {
    final data = await _getDataByUid(uid);

    if (data != null && data.videoUploadRequestUID.trim().isNotEmpty) {
      final RepairOrderService service = GetIt.I.get();
      var request = await service.getVideoUploadRequestByUID(data.videoUploadRequestUID);
      if (request != null) {
        request = request.copyWith(
          offlineEnqueueStatus: OfflineEnqueueItemStatus.done,
          updateDate: DateTime.now(),
        );
        await service.updateVideoUploadRequest(request);
      }
    }
  }

  @override
  Future<void> onError(String uid, dynamic error) async {
    int? orderID;

    final data = await _getDataByUid(uid);
    if (data != null && data.videoUploadRequestUID.trim().isNotEmpty) {
      final RepairOrderService service = GetIt.I.get();
      var request = await service.getVideoUploadRequestByUID(data.videoUploadRequestUID);
      if (request != null) {
        orderID = request.orderID;
        request = request.copyWith(
          offlineEnqueueStatus: OfflineEnqueueItemStatus.error,
          updateDate: DateTime.now(),
        );
        await service.updateVideoUploadRequest(request);
      }
    }

    _logEventService.logEvent(
      LogEventModule.videoUpload,
      action: LogEventActionVideoUpload.error.eventName,
      orderID: orderID,
      raw: jsonEncode({"requestUID": uid}),
      level: LogEventLevel.error,
      message: error.toString(),
    );
  }

  @override
  Future<void> onPending(String uid) async {
    final data = await _getDataByUid(uid);

    if (data != null && data.videoUploadRequestUID.trim().isNotEmpty) {
      final RepairOrderService service = GetIt.I.get();
      var request = await service.getVideoUploadRequestByUID(data.videoUploadRequestUID);
      if (request != null) {
        request = request.copyWith(
          offlineEnqueueStatus: OfflineEnqueueItemStatus.pending,
          updateDate: DateTime.now(),
        );
        await service.updateVideoUploadRequest(request);
      }
    }
  }

  @override
  Future<void> onProcess(String uid) async {
    var d = await _getDataByUid(uid);
    if (d == null) return;
    OfflineEnqueueItemRepairOrderVideoUploadModel data = d;

    RepairOrderUploadVideoRequestModel? request;
    try {
      // Get the video upload request
      request = await _repairOrderService.getVideoUploadRequestByUID(data.videoUploadRequestUID);
      if (request == null) {
        throw CustomException(message: "Video upload request not found");
      }

      // Update the status
      request = request.copyWith(
        offlineEnqueueStatus: OfflineEnqueueItemStatus.processing,
        updateDate: DateTime.now(),
      );
      await _repairOrderService.updateVideoUploadRequest(request);

      // Start process
      data = await _updateDataByUid(
        uid,
        data.copyWith(
          statusIndex: null,
          statusData: "",
          startAt: DateTime.now(),
          endAt: DateTime.now(),
          progress: 0.0,
          progressVisible: false,
        ),
      );
    } catch (error) {
      if (error is CustomException) rethrow;
      throw CustomException(message: "Error fetching upload request data");
    }

    // Buckets info
    String videoFileBucketName = "";
    String videoFileBucketPoolID = "";
    String videoFileBucketRegion = "";
    String pictureFileBucketName = "";
    String pictureFileBucketPoolID = "";
    String pictureFileBucketRegion = "";

    try {
      _logEventService.logEvent(
        LogEventModule.videoUpload,
        action: LogEventActionVideoUpload.getSettings.eventName,
        orderID: request.orderID,
        raw: jsonEncode({"requestUID": uid}),
        level: LogEventLevel.info,
      );

      final AuthService authService = GetIt.I.get();
      final settings = await authService.getUserSettings();

      final videoStorage = settings.firstWhereOrNull((e) => e.key == "enterprise-storage");
      if (videoStorage != null) {
        videoFileBucketName = videoStorage.children?.firstWhereOrNull((e) => e.key == "bucket-name")?.value ?? "";
        videoFileBucketPoolID = videoStorage.children?.firstWhereOrNull((e) => e.key == "identity-pool-id")?.value ?? "";
        videoFileBucketRegion = videoStorage.children?.firstWhereOrNull((e) => e.key == "bucket-region")?.value ?? "";
      }

      // Picture Bucket
      final pictureFileBucketSetting = settings.firstWhereOrNull((e) => e.key == "enterprise-storage-files");
      if (pictureFileBucketSetting != null) {
        pictureFileBucketName = pictureFileBucketSetting.children?.firstWhereOrNull((e) => e.key == "bucket-name")?.value ?? "";
        pictureFileBucketPoolID = pictureFileBucketSetting.children?.firstWhereOrNull((e) => e.key == "identity-pool-id")?.value ?? "";
        pictureFileBucketRegion = pictureFileBucketSetting.children?.firstWhereOrNull((e) => e.key == "bucket-region")?.value ?? "";
      }

      _logEventService.logEvent(
        LogEventModule.videoUpload,
        action: LogEventActionVideoUpload.getSettings.eventName,
        orderID: request.orderID,
        raw: jsonEncode({
          "requestUID": uid,
          "videoFileBucketName": videoFileBucketName,
          "videoFileBucketPoolID": videoFileBucketPoolID,
          "videoFileBucketRegion": videoFileBucketRegion,
          "pictureFileBucketName": pictureFileBucketName,
          "pictureFileBucketPoolID": pictureFileBucketPoolID,
          "pictureFileBucketRegion": pictureFileBucketRegion,
        }),
        level: LogEventLevel.success,
      );
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoUpload,
        action: LogEventActionVideoUpload.getSettings.eventName,
        orderID: request.orderID,
        raw: jsonEncode({"requestUID": uid}),
        message: error.toString(),
        level: LogEventLevel.error,
      );

      if (error is CustomException) rethrow;
      throw CustomException(message: "Error getting bucket information");
    }

    // Video Thumbnail
    if (data.videoThumbnailURL.trim().isEmpty) {
      try {
        final thumbnailVideoPath = request.cameraResult?.video.thumbnailPath ?? "";

        _logEventService.logEvent(
          LogEventModule.videoUpload,
          action: LogEventActionVideoUpload.uploadVideoThumbnail.eventName,
          orderID: request.orderID,
          raw: jsonEncode({"requestUID": uid, "path": thumbnailVideoPath, "url": data.videoThumbnailURL}),
          level: LogEventLevel.info,
        );

        // Upload file
        data = await _updateDataByUid(
          uid,
          data.copyWith(
            statusIndex: OfflineEnqueueItemRepairOrderVideoUploadStatus.videoThumbnailUpload.index,
            statusData: "",
            progressVisible: false,
            videoURL: "",
            videoThumbnailUploadStartAt: DateTime.now(),
            videoThumbnailUploadEndAt: null,
          ),
        );

        // Validate file exists
        if (!File(thumbnailVideoPath).existsSync()) {
          throw CustomException(message: "Video thumbnail file not found");
        }

        // Upload file
        final videoThumbnailURL = await _fileBucketService.upload(
          thumbnailVideoPath,
          bucketName: pictureFileBucketName,
          region: pictureFileBucketRegion,
          poolID: pictureFileBucketPoolID,
          folder: "image",
        );

        data = await _updateDataByUid(
          uid,
          data.copyWith(
            videoThumbnailUploadEndAt: DateTime.now(),
            videoThumbnailURL: videoThumbnailURL,
          ),
        );

        _logEventService.logEvent(
          LogEventModule.videoUpload,
          action: LogEventActionVideoUpload.uploadVideoThumbnail.eventName,
          orderID: request.orderID,
          raw: jsonEncode({"requestUID": uid, "path": thumbnailVideoPath, "url": videoThumbnailURL}),
          level: LogEventLevel.success,
        );

        //Delete file
        CustomFileUtils.delete(thumbnailVideoPath);
      } catch (error) {
        _logEventService.logEvent(
          LogEventModule.videoUpload,
          action: LogEventActionVideoUpload.uploadVideoThumbnail.eventName,
          orderID: request.orderID,
          message: error.toString(),
          raw: jsonEncode({"requestUID": uid}),
          level: LogEventLevel.error,
        );

        if (error is CustomException) rethrow;
        throw CustomException(message: "Error uploading video thumbnail");
      }
    }

    // Encode video
    if (data.videoEncodedPath.trim().isEmpty) {
      try {
        final videoPath = request.cameraResult?.video.info.path ?? "";
        _logEventService.logEvent(
          LogEventModule.videoUpload,
          action: LogEventActionVideoUpload.encodeVideo.eventName,
          orderID: request.orderID,
          raw: jsonEncode({"requestUID": uid, "path": videoPath}),
          level: LogEventLevel.info,
        );

        data = await _updateDataByUid(
          uid,
          data.copyWith(
            statusIndex: OfflineEnqueueItemRepairOrderVideoUploadStatus.videoEncode.index,
            statusData: "",
            progressVisible: false,
            videoEncodeStartAt: DateTime.now(),
            videoEncodeEndAt: null,
          ),
        );

        // Validate video file
        if (!File(videoPath).existsSync()) {
          throw CustomException(message: "Video file not found");
        }

        // Encode video
        final encodedVideoPath = await CustomVideoUtils.encode(videoPath);
        data = await _updateDataByUid(
          uid,
          data.copyWith(
            videoEncodedPath: encodedVideoPath,
            videoEncodeEndAt: DateTime.now(),
          ),
        );

        _logEventService.logEvent(
          LogEventModule.videoUpload,
          action: LogEventActionVideoUpload.encodeVideo.eventName,
          orderID: request.orderID,
          raw: jsonEncode({"requestUID": uid, "path": videoPath, "encodedVideoPath": encodedVideoPath}),
          level: LogEventLevel.success,
        );
      } catch (error) {
        _logEventService.logEvent(
          LogEventModule.videoUpload,
          action: LogEventActionVideoUpload.encodeVideo.eventName,
          orderID: request.orderID,
          message: error.toString(),
          raw: jsonEncode({"requestUID": uid}),
          level: LogEventLevel.error,
        );

        if (error is CustomException) rethrow;
        throw CustomException(message: "Error encoding the video");
      }
    }

    // Upload video
    if (data.videoURL.trim().isEmpty) {
      try {
        _logEventService.logEvent(
          LogEventModule.videoUpload,
          action: LogEventActionVideoUpload.uploadVideo.eventName,
          orderID: request.orderID,
          raw: jsonEncode({"requestUID": uid, "path": data.videoEncodedPath}),
          level: LogEventLevel.info,
        );

        // Validate encoding video file
        if (!File(data.videoEncodedPath).existsSync()) {
          throw CustomException(message: "Encoded video file not found");
        }

        // Upload video
        data = await _updateDataByUid(
          uid,
          data.copyWith(
            statusIndex: OfflineEnqueueItemRepairOrderVideoUploadStatus.videoUpload.index,
            progressVisible: true,
            progress: 0.0,
            videoUploadStartAt: DateTime.now(),
            videoUploadEndAt: null,
          ),
        );

        final videoURL = await _fileBucketService.upload(
          data.videoEncodedPath,
          bucketName: videoFileBucketName,
          region: videoFileBucketRegion,
          poolID: videoFileBucketPoolID,
          onProgressChange: (p) async {
            await _updateDataByUid(uid, data.copyWith(progress: p));
          },
        );

        data = await _updateDataByUid(
          uid,
          data.copyWith(
            progress: 100.0,
            videoUploadEndAt: DateTime.now(),
            videoURL: videoURL,
          ),
        );

        _logEventService.logEvent(
          LogEventModule.videoUpload,
          action: LogEventActionVideoUpload.uploadVideo.eventName,
          orderID: request.orderID,
          raw: jsonEncode({"requestUID": uid, "path": data.videoEncodedPath, "url": videoURL}),
          level: LogEventLevel.success,
        );
      } catch (error) {
        _logEventService.logEvent(
          LogEventModule.videoUpload,
          action: LogEventActionVideoUpload.uploadVideo.eventName,
          orderID: request.orderID,
          message: error.toString(),
          raw: jsonEncode({"requestUID": uid}),
          level: LogEventLevel.error,
        );

        if (error is CustomException) rethrow;
        throw CustomException(message: "Error uploading the video");
      }
    }

    CustomFileUtils.delete(request.cameraResult?.video.info.path ?? "");
    CustomFileUtils.delete(data.videoEncodedPath);

    // Process images
    final pictures = request.cameraResult?.pictures ?? <CameraPictureFileModel>[];
    for (int i = 0; i < pictures.length; i++) {
      final picture = pictures[i];

      final url = data.picturesURL[picture.path]?.trim() ?? "";
      if (url.isEmpty) {
        try {
          _logEventService.logEvent(
            LogEventModule.videoUpload,
            action: LogEventActionVideoUpload.uploadPicture.eventName,
            orderID: request.orderID,
            raw: jsonEncode({"requestUID": uid, "pictureNumber": (i + 1), "path": picture.path}),
            level: LogEventLevel.info,
          );

          // Upload picture
          data = await _updateDataByUid(
            uid,
            data.copyWith(
              statusIndex: OfflineEnqueueItemRepairOrderVideoUploadStatus.pictureUpload.index,
              statusData: i.toString(),
              progressVisible: false,
              pictureUploadStartAt: Map<String, DateTime>.from(data.pictureUploadStartAt)..[picture.path] = DateTime.now(),
              pictureUploadEndAt: Map<String, DateTime>.from(data.pictureUploadEndAt)..remove(picture),
            ),
          );

          if (!File(picture.path).existsSync()) {
            throw CustomException(message: "Picture file not found");
          }

          final pictureUUID = const Uuid().v4();
          final pictureURL = await _fileBucketService.upload(
            picture.path,
            fileName: pictureUUID,
            bucketName: pictureFileBucketName,
            region: pictureFileBucketRegion,
            poolID: pictureFileBucketPoolID,
            folder: "image",
            onProgressChange: (p) async {
              await _updateDataByUid(uid, data.copyWith(progress: p));
            },
          );

          data = await _updateDataByUid(
            uid,
            data.copyWith(
              picturesUUIDs: Map<String, String>.from(data.picturesUUIDs)..[picture.path] = pictureUUID,
              picturesURL: Map<String, String>.from(data.picturesURL)..[picture.path] = pictureURL,
              pictureUploadEndAt: Map<String, DateTime>.from(data.pictureUploadEndAt)..[picture.path] = DateTime.now(),
            ),
          );

          _logEventService.logEvent(
            LogEventModule.videoUpload,
            action: LogEventActionVideoUpload.uploadPicture.eventName,
            orderID: request.orderID,
            raw: jsonEncode({"requestUID": uid, "pictureNumber": (i + 1), "path": picture.path, "url": pictureURL}),
            level: LogEventLevel.success,
          );
        } catch (error) {
          _logEventService.logEvent(
            LogEventModule.videoUpload,
            action: LogEventActionVideoUpload.uploadPicture.eventName,
            orderID: request.orderID,
            raw: jsonEncode({"requestUID": uid, "pictureNumber": (i + 1), "path": picture.path}),
            level: LogEventLevel.error,
          );

          if (error is CustomException) rethrow;
          throw CustomException(message: "Error uploading the picture Nº ${i + 1}) ");
        }
      }

      //Delete picture file
      CustomFileUtils.delete(picture.path);
    }

    // Upload
    try {
      _logEventService.logEvent(
        LogEventModule.videoUpload,
        action: LogEventActionVideoUpload.save.eventName,
        orderID: request.orderID,
        raw: jsonEncode({"requestUID": uid}),
        level: LogEventLevel.info,
      );

      data = await _updateDataByUid(
        uid,
        data.copyWith(
          statusIndex: OfflineEnqueueItemRepairOrderVideoUploadStatus.save.index,
          statusData: "",
          progressVisible: false,
        ),
      );

      final RepairOrderService repairOrderService = GetIt.I.get();
      final imagesDTO = <VideoUploadImageDTO>[];
      for (int i = 0; i < pictures.length; i++) {
        final picture = pictures[i];
        imagesDTO.add(VideoUploadImageDTO(
          name: "image_$i",
          fileId: data.picturesUUIDs[picture.path] ?? "",
          size: picture.size,
          url: picture.path,
          contentType: "image/png",
        ));
      }

      await repairOrderService.uploadVideo(
        orderID: request.orderID,
        videoUpload: VideoUploadDTO(
          videoDTO: VideoUploadVideoDTO(
            videoLink: data.videoURL,
            thumbnail: data.videoThumbnailURL,
            length: request.cameraResult?.video.info.size ?? 0,
            videoTag: request.videoTagID,
            videoType: request.videoTypeID,
            description: request.videoDescription,
          ),
          imageDTO: imagesDTO,
        ),
      );

      data = await _updateDataByUid(
        uid,
        data.copyWith(
          statusIndex: null,
          statusData: "",
          endAt: DateTime.now(),
        ),
      );

      _logEventService.logEvent(
        LogEventModule.videoUpload,
        action: LogEventActionVideoUpload.save.eventName,
        orderID: request.orderID,
        raw: jsonEncode({"requestUID": uid}),
        level: LogEventLevel.success,
      );
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoUpload,
        action: LogEventActionVideoUpload.save.eventName,
        orderID: request.orderID,
        raw: jsonEncode({"requestUID": uid}),
        level: LogEventLevel.error,
        message: error.toString(),
      );

      if (error is CustomException) rethrow;
      throw CustomException(message: "Error saving the video");
    }

    try {
      _eventBusService.emit(EventVideoUploadedModel(orderID: request.orderID));
    } catch (_) {}
  }

  @override
  Future<void> onDelete(String uid) async {
    final data = await _getDataByUid(uid);
    if (data == null) return;

    // Get the video upload request
    var request = await _repairOrderService.getVideoUploadRequestByUID(data.videoUploadRequestUID);
    if (request != null) {
      request.cameraResult?.deleteFiles();
    }
  }

  @override
  Future<void> onRetry(String uid) async {}
}
