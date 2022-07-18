import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/model/camera/video_session.dart';
import 'package:truvideo_enterprise/model/camera/video_session_file.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';

import '_interface.dart';

class VideoSessionServiceImpl implements VideoSessionService {
  LocalDatabaseService get _localDatabaseService => GetIt.I.get();

  LogEventService get _logEventService => GetIt.I.get();

  AuthService get _authService => GetIt.I.get();

  String _boxName(String userUID) => "video-sessions-$userUID";

  VideoSessionModel? _parse(dynamic data) {
    try {
      return VideoSessionModel.fromJson(jsonDecode(jsonEncode(data)));
    } catch (error, stack) {
      log("Error parsing VideoSessionModel", error: error, stackTrace: stack);
      return null;
    }
  }

  @override
  Future<VideoSessionModel> create({
    String tag = "",
    int? orderID,
  }) async {
    try {
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.createSession.eventName,
        level: LogEventLevel.info,
        raw: jsonEncode({"tag": tag}),
        orderID: orderID,
      );

      if (tag.trim().isNotEmpty) {
        final existing = await getByTag(tag);
        if (existing != null) {
          throw CustomException(message: "Duplicate TAG");
        }
      }

      final model = VideoSessionModel(
        uid: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        tag: tag,
      );

      await _localDatabaseService.write(_boxName(_authService.sub ?? ""), model.uid, model.toJson());

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.createSession.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({"videoSessionUID": model.uid, "tag": tag}),
        orderID: orderID,
      );

      return model;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.createSession.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode({"tag": tag}),
        orderID: orderID,
      );

      rethrow;
    }
  }

  @override
  Future<void> addVideo(String uid, VideoSessionFileModel file, {int? orderID}) async {
    try {
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.addVideoToSession.eventName,
        level: LogEventLevel.info,
        raw: jsonEncode({
          "videoSessionUID": uid,
          "file": file.path,
          "isSelfie": file.selfie,
        }),
        orderID: orderID,
      );

      var model = await getByUID(uid);
      if (model == null) throw CustomException(message: "Entity not found");
      model = model.copyWith(
        videos: [
          ...model.videos,
          file,
        ],
      );

      await _localDatabaseService.write(_boxName(_authService.sub ?? ""), model.uid, model.toJson());

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.addVideoToSession.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({
          "videoSessionUID": uid,
          "file": file.path,
          "isSelfie": file.selfie,
        }),
        orderID: orderID,
      );
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.addVideoToSession.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode({
          "videoSessionUID": uid,
          "file": file.path,
          "isSelfie": file.selfie,
        }),
        orderID: orderID,
      );

      rethrow;
    }
  }

  @override
  Future<void> addPicture(String uid, VideoSessionFileModel file, {int? orderID}) async {
    try {
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.addPictureToSession.eventName,
        level: LogEventLevel.info,
        raw: jsonEncode({
          "videoSessionUID": uid,
          "file": file.path,
          "isSelfie": file.selfie,
        }),
        orderID: orderID,
      );

      var model = await getByUID(uid);
      if (model == null) throw CustomException(message: "Entity not found");
      model = model.copyWith(
        pictures: [
          ...model.pictures,
          file,
        ],
      );

      await _localDatabaseService.write(_boxName(_authService.sub ?? ""), model.uid, model.toJson());

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.addPictureToSession.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({
          "videoSessionUID": uid,
          "file": file.path,
          "isSelfie": file.selfie,
        }),
        orderID: orderID,
      );
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.addPictureToSession.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode({
          "videoSessionUID": uid,
          "file": file.path,
          "isSelfie": file.selfie,
        }),
        orderID: orderID,
      );

      rethrow;
    }
  }

  @override
  Future<void> deleteByTag(String tag, {bool deleteFiles = true}) async {
    final model = await getByTag(tag);
    if (model == null) return;
    await deleteByUID(model.uid, deleteFiles: deleteFiles);
  }

  @override
  Future<void> deleteByUID(String uid, {bool deleteFiles = true}) async {
    final model = await getByUID(uid);
    if (model == null) return;

    if (deleteFiles) {
      for (var element in model.videos) {
        CustomFileUtils.delete(element.path);
      }

      for (var element in model.pictures) {
        CustomFileUtils.delete(element.path);
      }
    }

    await _localDatabaseService.delete(_boxName(_authService.sub ?? ""), uid);
  }

  @override
  Future<VideoSessionModel?> getByTag(String tag) async {
    final items = await getAll();
    return items.firstWhereOrNull((e) => e.tag == tag);
  }

  @override
  Future<VideoSessionModel?> getByUID(String uid) async {
    final data = await _localDatabaseService.read(_boxName(_authService.sub ?? ""), uid);
    if (data == null) return null;
    return _parse(data);
  }

  @override
  Future<List<VideoSessionModel>> getAll() async {
    final items = await _localDatabaseService.getAll(_boxName(_authService.sub ?? ""));
    return items.map(_parse).where((e) => e != null).map((e) => e!).toList();
  }

  @override
  Stream<List<VideoSessionModel>> streamAll() {
    return _localDatabaseService
        .streamAll(_boxName(_authService.sub ?? ""))
        .map((event) => event.map(_parse).where((e) => e != null).map((e) => e!).toList());
  }

  @override
  Stream<VideoSessionModel?> streamByTag(String tag) {
    return streamAll().map((event) => event.firstWhereOrNull((e) => e.tag == tag));
  }

  @override
  Stream<VideoSessionModel?> streamByUID(String uid) {
    return _localDatabaseService.streamByKey(_boxName(_authService.sub ?? ""), uid).map(_parse);
  }
}
