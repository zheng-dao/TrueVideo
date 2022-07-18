import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/core/video.dart';
import 'package:truvideo_enterprise/model/camera/video_info.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/picture/_interface.dart';

class VideoEditorUtils {
  static LogEventService get _logEventService => GetIt.I.get();

  static PictureService get _pictureService => GetIt.I.get();

  static Future<String> rotateVideo(String path, double rotation, {int? orderID}) async {
    try {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoRotate.eventName,
        level: LogEventLevel.info,
        orderID: orderID,
        raw: jsonEncode({"path": path}),
      );

      final result = await CustomVideoUtils.rotate(path, rotation);

      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoRotate.eventName,
        level: LogEventLevel.success,
        orderID: orderID,
        raw: jsonEncode({"path": path, "result": result}),
      );

      return result;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoRotate.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        orderID: orderID,
        raw: jsonEncode({"path": path}),
      );
      rethrow;
    }
  }

  static Future<String> concatVideos(List<String> paths, {int? orderID}) async {
    try {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoConcat.eventName,
        level: LogEventLevel.info,
        orderID: orderID,
        raw: jsonEncode(paths),
      );

      final result = await CustomVideoUtils.concat(paths);

      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoConcat.eventName,
        level: LogEventLevel.success,
        orderID: orderID,
        raw: jsonEncode({"paths": paths, "result": result}),
      );

      return result;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoConcat.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        orderID: orderID,
        raw: jsonEncode(paths),
      );
      rethrow;
    }
  }

  static Future<VideoInfoModel> getVideoInfo(String path, {int? orderID}) async {
    try {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoInfo.eventName,
        level: LogEventLevel.info,
        orderID: orderID,
        raw: jsonEncode({"path": path}),
      );

      final resultVideoInfo = await CustomVideoUtils.getInfo(path);

      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoInfo.eventName,
        level: LogEventLevel.success,
        orderID: orderID,
        raw: jsonEncode(resultVideoInfo.toJson()),
      );

      return resultVideoInfo;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoInfo.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        orderID: orderID,
        raw: jsonEncode({"path": path}),
      );
      rethrow;
    }
  }

  static Future<String> getVideoThumbnail(String path, {int? orderID}) async {
    try {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoThumbnail.eventName,
        level: LogEventLevel.info,
        orderID: orderID,
        raw: jsonEncode({"path": path}),
      );

      final result = await CustomVideoUtils.getThumbnail(path);

      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoThumbnail.eventName,
        level: LogEventLevel.success,
        orderID: orderID,
        raw: jsonEncode({"path": path, "result": result}),
      );

      return result;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoThumbnail.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        orderID: orderID,
        raw: jsonEncode({"path": path}),
      );
      rethrow;
    }
  }

  static Future<String> trimVideo({
    required String path,
    required Duration videoDuration,
    Duration? startDuration,
    Duration? endDuration,
    int? orderID,
  }) async {
    // No trim needed
    if (startDuration == null && endDuration == null) {
      // no trim needed
      final resultPath = await CustomFileUtils.generateTempVideoPath(path.split(".").last);
      await File(resultPath).create(recursive: true);
      await File(path).copy(resultPath);
      return resultPath;
    }

    // Trim video
    final from = startDuration ?? Duration.zero;
    final to = endDuration ?? videoDuration;

    try {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoTrim.eventName,
        level: LogEventLevel.info,
        orderID: orderID,
        raw: jsonEncode({"path": path, "from": from, "to": to}),
      );

      final trimmed = await CustomVideoUtils.trim(path, from, to);

      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoTrim.eventName,
        level: LogEventLevel.success,
        orderID: orderID,
        raw: jsonEncode({"path": path, "from": from, "to": to, "result": trimmed}),
      );

      return trimmed;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.videoTrim.eventName,
        level: LogEventLevel.error,
        orderID: orderID,
        message: error.toString(),
        raw: jsonEncode({"path": path, "from": from, "to": to}),
      );
      rethrow;
    }
  }

  static Future<Size> getImageSize(String path, {int? orderID}) async {
    try {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.pictureSize.eventName,
        level: LogEventLevel.info,
        orderID: orderID,
        raw: jsonEncode({"path": path}),
      );

      final pictureSize = await _pictureService.getSize(path);

      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.pictureSize.eventName,
        level: LogEventLevel.success,
        orderID: orderID,
        raw: jsonEncode({
          "path": path,
          "result": {"x": pictureSize.width, "y": pictureSize.height}
        }),
      );

      return pictureSize;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.pictureSize.eventName,
        level: LogEventLevel.error,
        orderID: orderID,
        message: error.toString(),
        raw: jsonEncode({"path": path}),
      );

      rethrow;
    }
  }

  static Future<String> editImage({
    required String path,
    double rotation = 0.0,
    bool flipHorizontal = false,
    bool flipVertical = false,
    int? orderID,
  }) async {
    try {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.pictureEdit.eventName,
        level: LogEventLevel.info,
        orderID: orderID,
        raw: jsonEncode({"path": path, "rot": rotation, "flipH": flipHorizontal, "flipV": flipVertical}),
      );

      final edited = await _pictureService.edit(
        path,
        rotation: rotation,
        flipHorizontal: flipHorizontal,
        flipVertical: flipVertical,
      );

      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.pictureEdit.eventName,
        level: LogEventLevel.success,
        orderID: orderID,
        raw: jsonEncode({"path": path, "rot": rotation, "flipH": flipHorizontal, "flipV": flipVertical, "result": edited}),
      );

      return edited;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoEditor,
        action: LogEventActionVideoEditor.pictureEdit.eventName,
        level: LogEventLevel.error,
        orderID: orderID,
        message: error.toString(),
        raw: jsonEncode({"path": path, "rot": rotation, "flipH": flipHorizontal, "flipV": flipVertical}),
      );
      rethrow;
    }
  }
}
