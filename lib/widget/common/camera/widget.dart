import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/core/permission.dart';
import 'package:truvideo_enterprise/core/video.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:truvideo_enterprise/model/camera/video_session.dart';
import 'package:truvideo_enterprise/model/camera/video_session_file.dart';
import 'package:truvideo_enterprise/model/video_editor/request_picture.dart';
import 'package:truvideo_enterprise/model/video_editor/request_video.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/settings/_interface.dart';
import 'package:truvideo_enterprise/service/settings/camera_quality.dart';
import 'package:truvideo_enterprise/service/video_session/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/camera/panel_options_flash_mode.dart';
import 'package:truvideo_enterprise/widget/common/camera/panel_options_invalid_rotation.dart';
import 'package:truvideo_enterprise/widget/common/camera/panel_options_narrator_mode.dart';
import 'package:truvideo_enterprise/widget/common/camera/video_duration.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/gallery/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/video_editor/index.dart';
import 'package:truvideo_enterprise/widget/dialog/permission/index.dart';
import 'package:truvideo_enterprise/widget/mixin/accelerometer.dart';

import 'app_bar_buttons.dart';
import 'buttons.dart';
import 'capturing_picture.dart';
import 'panel_options_quality.dart';
import 'preview.dart';
import 'zoom.dart';

enum CustomCameraMode {
  photo,
  video,
}

enum CustomCameraPanelMode {
  normal,
  flash,
  quality,
  narratorMode,
  invalidRotation,
}

const double rotationPort = 0.0;
const double rotationPortInverted = math.pi;
const double rotationLandscape = math.pi * 0.5;
const double rotationLandscapeIos = -math.pi * 1.5;
const double rotationLandscapeInverted = -math.pi * 0.5;
const double rotationDelta = math.pi * 0.05;

class CustomCameraWidget extends StatefulHookConsumerWidget {
  final CustomCameraMode mode;
  final String videoSessionTag;
  final String videoSessionUID;
  final int? orderID;

  const CustomCameraWidget({
    Key? key,
    required this.mode,
    this.videoSessionTag = "",
    this.videoSessionUID = "",
    this.orderID,
  }) : super(key: key);

  @override
  ConsumerState<CustomCameraWidget> createState() => _CustomCameraWidgetState();
}

class _CustomCameraWidgetState extends ConsumerState<CustomCameraWidget> with WidgetsBindingObserver, TickerProviderStateMixin, AccelerometerMixin {
  LogEventService get _logEventService => GetIt.I.get();

  VideoSessionService get _videoSessionService => GetIt.I.get();

  String _videoSessionUID = "";

  CameraController? _controller;
  CameraDescription? _frontCamera;
  CameraDescription? _backCamera;

  double _minZoom = 0.0;
  double _maxZoom = 0.0;
  bool _recordingVideo = false;
  bool _recordingVideoPaused = false;
  bool _enabled = false;
  bool _closing = false;
  final _currentZoom = ValueNotifier(1.0);

  var _videos = <File>[];
  var _pictures = <File>[];
  var _picturesSelfie = <String, bool>{};

  var _currentRotation = AccelerometerRotationPosition.portrait;

  bool _zoomBarVisible = false;
  var _panelMode = CustomCameraPanelMode.normal;
  var _flashModes = <FlashMode>[];
  var _flashMode = FlashMode.off;
  bool _narratorMode = true;

  Timer? _videoDurationTimer;
  final _videoDuration = ValueNotifier<Duration>(Duration.zero);

  final _keyCapturingPicture = GlobalKey<CustomCameraCapturingPictureState>();
  final _keyPreviewContainer = GlobalKey();
  bool _pictureCounterVisible = true;
  bool _renderCamera = true;
  bool _firstTake = true;
  bool _isInit = false;

  @override
  void initState() {
    _showStatusBar(false);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
    super.initState();
  }

  @override
  void dispose() {
    _showStatusBar(true);
    _controller?.dispose().then((value) async {
      await CameraController.resetAudio();
    });

    _videoDurationTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _handleCameraLifecycle(state);
  }

  bool _handlingLifecycle = false;
  AppLifecycleState? _lastLifecycleState;

  _handleCameraLifecycle(AppLifecycleState state) async {
    if (!_isInit) return;

    if (_handlingLifecycle) {
      log("Busy handling an old lifecycle state");
      _lastLifecycleState = state;
      return;
    }

    _lastLifecycleState = null;
    _handlingLifecycle = true;

    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      setState(() => _renderCamera = false);
      await CustomWidgetUtils.wait();
      if (widget.mode == CustomCameraMode.video && _recordingVideo && !_recordingVideoPaused) {
        await _pauseVideoRecording();
      }

      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await _onNewCameraSelected(cameraController.description);
    }

    _handlingLifecycle = false;

    if (_lastLifecycleState != null) {
      log("Now i will handle the last state. $_lastLifecycleState");
      _handleCameraLifecycle(_lastLifecycleState!);
    }
  }

  _showStatusBar(bool show) {
    if (show || !Platform.isIOS) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  _init() async {
    final cameras = await _getAvailableCameras();
    final frontCamera = cameras?.firstWhereOrNull((e) => e.lensDirection == CameraLensDirection.front);
    final backCamera = cameras?.firstWhereOrNull((e) => e.lensDirection == CameraLensDirection.back);

    if (cameras == null || cameras.isEmpty || (frontCamera == null && backCamera == null)) {
      await showCustomDialogRetry(message: "No cameras available");
      _close();
      return;
    }

    _frontCamera = frontCamera;
    _backCamera = backCamera;

    final withPermission = await _askPermission();
    if (!withPermission) {
      _close();
      return;
    }

    if (widget.videoSessionUID.trim().isNotEmpty) {
      await _loadVideoSession();
    }

    _isInit = true;
    final currentCamera = _backCamera ?? _frontCamera;
    _onNewCameraSelected(currentCamera!);
  }

  Future<List<CameraDescription>?> _getAvailableCameras() async {
    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.listCameras.eventName,
      level: LogEventLevel.info,
      orderID: widget.orderID,
    );

    try {
      final cameras = await availableCameras();
      if (!mounted) return null;

      if (cameras.isEmpty) {
        throw CustomException(message: "No available cameras");
      }

      final data = {};
      for (var element in cameras) {
        data[element.name] = "${element.sensorOrientation} ${element.lensDirection}";
      }

      _logEventService.logEvent(
        LogEventModule.camera,
        message: "${cameras.length} available cameras",
        raw: jsonEncode(data),
        action: LogEventActionCamera.listCameras.eventName,
        level: LogEventLevel.success,
        orderID: widget.orderID,
      );
      return cameras;
    } catch (error) {
      log("Error getting cameras", error: error);
      if (!mounted) return null;

      // Log error
      _logEventService.logEvent(
        LogEventModule.camera,
        message: error.toString(),
        action: LogEventActionCamera.listCameras.eventName,
        level: LogEventLevel.error,
        orderID: widget.orderID,
      );
      return null;
    }
  }

  _loadVideoSession() async {
    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.resumeSession.eventName,
      message: "Video session UID: ${widget.videoSessionUID}",
      raw: jsonEncode({"videoSessionUID": widget.videoSessionUID}),
      level: LogEventLevel.info,
      orderID: widget.orderID,
    );

    try {
      final VideoSessionModel? videoSession = await _videoSessionService.getByUID(widget.videoSessionUID);
      if (!mounted) return;
      if (videoSession == null) {
        throw CustomException(message: "Error creating video session");
      }

      var duration = Duration.zero;
      for (var video in videoSession.videos) {
        try {
          final d = await CustomVideoUtils.getInfo(video.path);
          duration += Duration(milliseconds: d.durationMillis);
        } catch (error) {
          log("Error getting video duration", error: error);
        }
      }

      if (videoSession.videos.isNotEmpty) {
        _recordingVideo = true;
        _recordingVideoPaused = true;
      }

      _videoDuration.value = duration;
      _videos = videoSession.videos.map((e) => File(e.path)).toList();
      _pictures = videoSession.pictures.map((e) => File(e.path)).toList();
      for (var element in videoSession.pictures) {
        _picturesSelfie[element.path] = element.selfie;
      }
      _videoSessionUID = videoSession.uid;

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.resumeSession.eventName,
        message: "Videos: ${videoSession.videos.length}. Pictures: ${videoSession.pictures.length}",
        raw: jsonEncode(videoSession.toJson()),
        level: LogEventLevel.success,
        orderID: widget.orderID,
      );
    } catch (error) {
      log("Error loading video session");
      if (!mounted) return;

      final errorMessage = error is CustomException ? error.message ?? "" : "Something went wrong";
      await showCustomDialogRetry(
        message: errorMessage,
        cancelButtonVisible: false,
        retryButtonText: "Accept",
      );

      // Log
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.resumeSession.eventName,
        message: error.toString(),
        level: LogEventLevel.error,
        orderID: widget.orderID,
      );

      _close();
      return;
    }
  }

  Future<bool> _askPermission() async {
    var p = <Permission>[];

    switch (widget.mode) {
      case CustomCameraMode.photo:
        p = CustomPermissionUtils.photoCameraPermissions;
        break;
      case CustomCameraMode.video:
        p = CustomPermissionUtils.videoCameraPermissions;
        break;
    }

    return showCustomPermissionDialog(p);
  }

  Future<void> _onNewCameraSelected(CameraDescription cameraDescription) async {
    _currentZoom.value = 1.0;

    var flashModes = <FlashMode>[];
    switch (widget.mode) {
      case CustomCameraMode.photo:
        flashModes = [FlashMode.off, FlashMode.auto, FlashMode.always];
        break;
      case CustomCameraMode.video:
        flashModes = [FlashMode.off];
        if (cameraDescription.lensDirection == CameraLensDirection.back) {
          flashModes.add(FlashMode.torch);
        }
        break;
    }

    _setPanelModel(CustomCameraPanelMode.normal);

    setState(() {
      _renderCamera = false;
      _flashModes = flashModes;
    });

    await CustomWidgetUtils.wait();

    if (_controller != null) {
      final c = _controller;
      setState(() {
        _controller = null;
      });
      await c!.dispose();
    }

    await CustomWidgetUtils.wait();

    if (!mounted) return;

    dynamic cameraInfo;
    try {
      final SettingsService service = GetIt.I.get();
      final cameraQuality = await service.getCameraQuality();
      ResolutionPreset resolutionPreset;

      switch (cameraQuality) {
        case CameraQuality.low:
          resolutionPreset = ResolutionPreset.low;
          break;
        case CameraQuality.medium:
          resolutionPreset = ResolutionPreset.medium;
          break;
        case CameraQuality.high:
          resolutionPreset = ResolutionPreset.high;
          break;
      }

      bool isSelfie = cameraDescription.lensDirection == CameraLensDirection.front;
      final enableAudio = widget.mode == CustomCameraMode.video;
      final imageFormatGroup = Platform.isIOS ? ImageFormatGroup.bgra8888 : ImageFormatGroup.jpeg;
      cameraInfo = {
        "cameraName": cameraDescription.name,
        "cameraLensDirection": cameraDescription.lensDirection.name,
        "cameraSensorOrientation": cameraDescription.sensorOrientation.toString(),
        "isSelfie": isSelfie,
        "narratorMode": _narratorMode,
        "enableAudio": enableAudio,
        "imageFormatGroup": imageFormatGroup.name,
        "resolutionPreset": resolutionPreset.name,
      };

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.initCamera.eventName,
        level: LogEventLevel.info,
        raw: jsonEncode(cameraInfo),
        orderID: widget.orderID,
      );

      // Android Audio Source
      // 1 MIC
      // 5 CAMCORDER

      final CameraController controller = CameraController(
        cameraDescription,
        resolutionPreset,
        enableAudio: widget.mode == CustomCameraMode.video,
        imageFormatGroup: imageFormatGroup,
        androidAudioSource: _narratorMode ? 1 : 5,
        iosMicrophone: _narratorMode ? "Bottom" : (isSelfie ? "Bottom" : "Back"),
      );

      _controller = controller;

      // If the controller is updated then update the UI.
      controller.addListener(() {
        if (!mounted) return;
        setState(() {});

        if (controller.value.hasError) {
          _onCameraError(controller.value.errorDescription, cameraInfo: cameraInfo);
        }
      });

      await controller.initialize();
      await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
      final maxZoom = await controller.getMaxZoomLevel();
      final minZoom = await controller.getMinZoomLevel();

      if (widget.mode == CustomCameraMode.video) {
        await controller.prepareForVideoRecording();
      }
      await _setFlashMode(_flashMode);
      if (!mounted) return;
      setState(() {
        _maxZoom = maxZoom.clamp(0.0, 20.0);
        _minZoom = minZoom.clamp(0.0, 20.0);
        _renderCamera = true;
        _enabled = true;
      });

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.initCamera.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode(cameraInfo),
        orderID: widget.orderID,
      );
    } catch (error, stack) {
      log("Error initializing camera", error: error, stackTrace: stack);
      if (!mounted) return;
      _onCameraError(error, cameraInfo: cameraInfo);
    }
  }

  _askClose() async {
    if (!_enabled) return;

    final ask = _videos.isNotEmpty || _pictures.isNotEmpty || (_recordingVideo && !_recordingVideoPaused);
    if (!ask) {
      _close();
      return;
    }

    final close = await showCustomDialogRetry(
      title: "Exit",
      message: "Are you sure?",
      retryButtonText: "Yes",
      cancelButtonText: "No",
    );
    if (!close) return;

    _logEventService.logEvent(
      LogEventModule.settings,
      action: LogEventActionCamera.cancel.eventName,
      level: LogEventLevel.info,
    );

    _close();
  }

  _close() async {
    if (_closing) return;
    _closing = true;
    if (_recordingVideo && !_recordingVideoPaused) {
      await _pauseVideoRecording();
    }

    for (var video in _videos) {
      CustomFileUtils.delete(video.path);
    }

    for (var picture in _pictures) {
      CustomFileUtils.delete(picture.path);
    }

    if (_videoSessionUID.trim().isNotEmpty) {
      final VideoSessionService videoSessionService = GetIt.I.get();
      try {
        await videoSessionService.deleteByUID(_videoSessionUID);
      } catch (error) {
        log("Error deleting video session");
      }
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  _onCameraError(dynamic error, {dynamic cameraInfo}) async {
    if (!mounted) return;

    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.initCamera.eventName,
      level: LogEventLevel.error,
      message: error.toString(),
      raw: jsonEncode(cameraInfo),
      orderID: widget.orderID,
    );

    setState(() {
      _renderCamera = false;
      _enabled = false;
    });

    if (_frontCamera == null || _backCamera == null) {
      _close();
      return;
    }

    final retry = await showCustomDialogRetry();
    if (retry) {
      final camera = _controller?.description ?? _backCamera ?? _frontCamera;
      _onNewCameraSelected(camera!);
    } else {
      _close();
    }
  }

  @override
  onAccelerometerRotationChange(AccelerometerRotationPosition rotationPosition) {
    super.onAccelerometerRotationChange(rotationPosition);

    if (_currentRotation != rotationPosition) {
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.rotationChange.eventName,
        level: LogEventLevel.info,
        message: rotationPosition.name,
        orderID: widget.orderID,
      );

      setState(() {
        _currentRotation = rotationPosition;
      });
    }
  }

  bool get _isButtonsEnabled {
    if (!_isControllerReady) return false;
    if (!_enabled) return false;
    return true;
  }

  bool get _isControllerReady {
    if (_controller == null) return false;
    if (!_controller!.value.isInitialized) return false;
    return true;
  }

  bool get _isSelfieCamera {
    if (!_isControllerReady) return false;
    final c = _controller!.description;
    return c.lensDirection == CameraLensDirection.front;
  }

  _onChangeCameraPressed() async {
    if (!_isControllerReady) return;

    _setZoomBarVisible(false);

    if (_isSelfieCamera && _backCamera == null) return;
    if (!_isSelfieCamera && _frontCamera == null) return;

    final newCamera = _isSelfieCamera ? _backCamera : _frontCamera;
    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.switchCamera.eventName,
      level: LogEventLevel.info,
      raw: jsonEncode({
        "cameraName": newCamera?.name,
        "cameraLensDirection": newCamera?.lensDirection.name,
        "cameraSensorOrientation": newCamera?.sensorOrientation,
      }),
      orderID: widget.orderID,
    );

    bool resumeRecording = false;
    if (widget.mode == CustomCameraMode.video && _recordingVideo && !_recordingVideoPaused) {
      resumeRecording = true;
      await _pauseVideoRecording();
    }

    await _onNewCameraSelected(newCamera!);

    if (resumeRecording) {
      _startVideoRecording();
    }
  }

  _changeFocusPoint(Offset position) async {
    if (!_isControllerReady) return;

    _setZoomBarVisible(false);
    CameraController controller = _controller!;

    try {
      await Future.wait([
        controller.setExposurePoint(position),
        controller.setFocusPoint(position),
      ]);
    } catch (error) {
      log("Error changing focus point", error: error);
    }
  }

  _changeZoom(double value) async {
    if (!_isControllerReady) return;

    CameraController controller = _controller!;

    try {
      _currentZoom.value = value;
      await controller.setZoomLevel(value);
    } catch (error) {
      log("Error changing zoom", error: error);
    }
  }

  _onButtonCapturePressed() async {
    if (!_isControllerReady) return;
    _setZoomBarVisible(false);

    switch (widget.mode) {
      case CustomCameraMode.photo:
        break;
      case CustomCameraMode.video:
        if (_recordingVideo) {
          _stopVideoRecording();
        } else {
          _startVideoRecording();
        }

        break;
    }
  }

  _fixFirstBlackFrameOnIOS() async {
    if (!_isControllerReady) return;
    final CameraController controller = _controller!;

    if (_firstTake && Platform.isIOS) {
      _firstTake = false;
      try {
        await controller.startVideoRecording();
        await Future.delayed(const Duration(milliseconds: 500));
        final file = await controller.stopVideoRecording();
        File(file.path).deleteSync();
      } catch (_) {}
    }
  }

  _startVideoRecording() async {
    if (!_isControllerReady) return;
    final CameraController controller = _controller!;

    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.recordStart.eventName,
      level: LogEventLevel.info,
      orderID: widget.orderID,
    );

    try {
      setState(() {
        _recordingVideoPaused = false;
        _enabled = false;
      });

      if (!controller.value.isRecordingVideo) {
        await _fixFirstBlackFrameOnIOS();
        await controller.startVideoRecording();
        if (!mounted) return;
      }

      _startVideoDurationTimer();

      setState(() {
        _enabled = true;
        _recordingVideo = true;
      });

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordStart.eventName,
        level: LogEventLevel.success,
        orderID: widget.orderID,
      );
    } catch (error, stack) {
      log("Error starting video recording", error: error, stackTrace: stack);
      if (!mounted) return;

      setState(() {
        _enabled = true;
      });

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordStart.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        orderID: widget.orderID,
      );
    }
  }

  _stopVideoRecording() async {
    if (!_isControllerReady) return;

    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.recordFinish.eventName,
      level: LogEventLevel.info,
      orderID: widget.orderID,
    );

    final CameraController controller = _controller!;

    // Stop video recording
    bool recordingStopped = false;
    try {
      setState(() {
        _recordingVideoPaused = false;
        _recordingVideo = false;
        _enabled = false;
      });

      _stopVideoDurationTimer();

      // Stop video recording
      if (controller.value.isRecordingVideo) {
        try {
          final file = await controller.stopVideoRecording();
          await _addVideo(File(file.path), _isSelfieCamera);
        } catch (error) {
          log("Error stopping video recording", error: error);
        }
      }

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordFinish.eventName,
        level: LogEventLevel.success,
        orderID: widget.orderID,
      );
      recordingStopped = true;
    } catch (error) {
      log("Error stopping video recording", error: error);
      if (!mounted) return;

      recordingStopped = false;

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordFinish.eventName,
        level: LogEventLevel.success,
        message: error.toString(),
        orderID: widget.orderID,
      );
    }

    if (!recordingStopped) return;

    // Send video recorded to edit
    final videoRotation = Platform.isIOS ? 90.0 : 0.0;
    await CameraController.resetAudio();
    await _cancelCamera();
    _showStatusBar(true);

    // Send to edit
    final videoEdited = await showCustomVideoEditor(
      videos: _videos
          .map((e) => VideoEditorRequestVideoModel(
                path: e.path,
                rotation: videoRotation,
              ))
          .toList(),
      pictures: _pictures.map((e) {
        final selfie = _picturesSelfie[e.path] ?? false;
        final rot = selfie ? 90.0 : -90.0;
        final flip = Platform.isIOS ? selfie : false;
        return VideoEditorRequestPictureModel(
          path: e.path,
          rotation: rot,
          flipHorizontal: flip,
        );
      }).toList(),
    );

    // Delete current video session
    await _deleteVideoSession();

    // Delete videos
    for (var file in _videos) {
      CustomFileUtils.delete(file.path);
    }

    // Delete pictures
    for (var file in _pictures) {
      CustomFileUtils.delete(file.path);
    }

    // If the video was edited, close the camera
    if (videoEdited != null) {
      if (!mounted) return;
      Navigator.of(context).pop(videoEdited);
      return;
    }

    if (!mounted) return;

    // If the video wasn't edited, clear al the data
    _onNewCameraSelected(controller.description);
    _showStatusBar(false);
    _videos = [];
    _pictures = [];
    _picturesSelfie = {};
    _videoDuration.value = Duration.zero;
  }

  _deleteVideoSession() async {
    if (_videoSessionUID.trim().isEmpty) return;

    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.deleteSession.eventName,
      level: LogEventLevel.info,
      raw: _videoSessionUID,
      orderID: widget.orderID,
    );

    try {
      final VideoSessionService videoSessionService = GetIt.I.get();
      await videoSessionService.deleteByUID(_videoSessionUID, deleteFiles: false);
      _videoSessionUID = "";

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.deleteSession.eventName,
        level: LogEventLevel.success,
        raw: _videoSessionUID,
        orderID: widget.orderID,
      );
    } catch (error) {
      log("Error deleting video session");
      if (!mounted) return;

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.deleteSession.eventName,
        level: LogEventLevel.error,
        raw: _videoSessionUID,
        orderID: widget.orderID,
      );
    }
  }

  _onButtonCameraQualityPressed() {
    _setZoomBarVisible(false);
    _setPanelModel(CustomCameraPanelMode.quality);
  }

  _onButtonFlashModePressed() {
    _setPanelModel(CustomCameraPanelMode.flash);
    _setZoomBarVisible(false);
  }

  _onButtonInvalidRotationPressed() {
    _setPanelModel(CustomCameraPanelMode.invalidRotation);
    _setZoomBarVisible(false);
  }

  _onButtonNarratorModePressed() {
    _setPanelModel(CustomCameraPanelMode.narratorMode);
    _setZoomBarVisible(false);
  }

  _onButtonVideoRecordingPausePressed() async {
    if (!_isControllerReady) return;
    _setZoomBarVisible(false);

    if (_recordingVideoPaused) {
      await _resumeVideoRecording();
    } else {
      await _pauseVideoRecording();
    }
  }

  _resumeVideoRecording() async {
    if (!_isControllerReady) return;
    final CameraController controller = _controller!;
    _setZoomBarVisible(false);

    try {
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordResume.eventName,
        level: LogEventLevel.info,
        orderID: widget.orderID,
      );

      setState(() {
        _enabled = false;
        _recordingVideoPaused = true;
      });

      if (!controller.value.isRecordingVideo) {
        await controller.startVideoRecording();
      }

      _startVideoDurationTimer();

      setState(() {
        _enabled = true;
        _recordingVideoPaused = false;
      });

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordResume.eventName,
        level: LogEventLevel.success,
        orderID: widget.orderID,
      );
    } catch (error, stack) {
      log("Error resuming video recording", error: error, stackTrace: stack);
      if (!mounted) return;

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordResume.eventName,
        level: LogEventLevel.error,
        orderID: widget.orderID,
      );

      setState(() {
        _enabled = true;
      });
    }
  }

  _pauseVideoRecording() async {
    if (!_isControllerReady) return;
    final CameraController controller = _controller!;
    _setZoomBarVisible(false);

    try {
      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordPause.eventName,
        level: LogEventLevel.info,
        orderID: widget.orderID,
      );

      setState(() {
        _enabled = false;
        _recordingVideoPaused = false;
      });

      _stopVideoDurationTimer();

      if (controller.value.isRecordingVideo) {
        final result = await controller.stopVideoRecording();
        if (!mounted) return;
        await _addVideo(File(result.path), _isSelfieCamera);
      }

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordPause.eventName,
        level: LogEventLevel.success,
        orderID: widget.orderID,
      );

      setState(() {
        _enabled = true;
        _recordingVideoPaused = true;
      });
    } catch (error, stack) {
      log("Error pausing video recording", error: error, stackTrace: stack);
      if (!mounted) return;

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.recordPause.eventName,
        level: LogEventLevel.error,
        orderID: widget.orderID,
      );

      setState(() {
        _enabled = true;
      });
    }
  }

  _createVideoSession() async {
    if (_videoSessionUID.trim().isNotEmpty) return;

    try {
      final VideoSessionService videoSessionService = GetIt.I.get();
      final model = await videoSessionService.create(tag: widget.videoSessionTag, orderID: widget.orderID);
      _videoSessionUID = model.uid;
    } catch (error) {
      log("Error creating video session", error: error);
    }
  }

  _addVideo(File file, bool isSelfie) async {
    setState(() {
      _videos = [
        ..._videos,
        file,
      ];
    });

    await _createVideoSession();

    try {
      final VideoSessionService videoSessionService = GetIt.I.get();
      await videoSessionService.addVideo(
        _videoSessionUID,
        VideoSessionFileModel(
          path: file.path,
          selfie: isSelfie,
        ),
        orderID: widget.orderID,
      );
    } catch (error, stack) {
      log("Error adding video to video session $_videoSessionUID", error: error, stackTrace: stack);
    }
  }

  _addPicture(File file, bool isSelfie) async {
    setState(() {
      _pictures = [
        ..._pictures,
        file,
      ];
    });

    await _createVideoSession();

    try {
      final VideoSessionService videoSessionService = GetIt.I.get();
      await videoSessionService.addPicture(
        _videoSessionUID,
        VideoSessionFileModel(
          path: file.path,
          selfie: isSelfie,
        ),
        orderID: widget.orderID,
      );
    } catch (error, stack) {
      log("Error adding picture to video session $_videoSessionUID", error: error, stackTrace: stack);
    }
  }

  _takePicture() async {
    if (!_isControllerReady) return;

    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.takePicture.eventName,
      level: LogEventLevel.info,
      orderID: widget.orderID,
    );

    final CameraController controller = _controller!;
    _setZoomBarVisible(false);

    try {
      setState(() {
        _pictureCounterVisible = false;
        _enabled = false;
      });

      final rb = _keyPreviewContainer.currentContext?.findRenderObject() as RenderBox;

      _keyCapturingPicture.currentState?.showCapturing(
        size: rb.size,
        position: rb.localToGlobal(Offset.zero),
      );

      final stopwatch = Stopwatch()..start();

      bool resumeVideo = false;
      if (Platform.isAndroid && _recordingVideo && !_recordingVideoPaused) {
        await _pauseVideoRecording();
        resumeVideo = true;
      }

      XFile? picture;
      try {
        picture = await controller.takePicture();
      } catch (error, stack) {
        log("Error capturing image", error: error, stackTrace: stack);
      }

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.takePicture.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({"path": picture?.path}),
        orderID: widget.orderID,
      );

      if (resumeVideo) {
        await _resumeVideoRecording();
      }

      if (!mounted) return;

      stopwatch.stop();
      final t = stopwatch.elapsedMilliseconds;
      final d = (300 - t).clamp(0, 300);
      if (d != 0) {
        await Future.delayed(Duration(milliseconds: d));
        if (!mounted) return;
      }

      if (picture != null) {
        await _addPicture(File(picture.path), _isSelfieCamera);

        setState(() {
          _picturesSelfie = Map<String, bool>.from(_picturesSelfie)..[picture!.path] = _isSelfieCamera;
        });
      }

      setState(() {
        _enabled = true;
      });

      if (!mounted) return;
      _hideTakingPicture(path: picture?.path);
    } catch (error) {
      log("Error capturing a picture", error: error);
      if (!mounted) return;

      setState(() {
        _pictureCounterVisible = true;
        _enabled = true;
      });
      _hideTakingPicture();

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.takePicture.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        orderID: widget.orderID,
      );
    }
  }

  _hideTakingPicture({String? path}) async {
    await _keyCapturingPicture.currentState?.close(
      size: const Size(60, 60),
      position: Offset(
        16.0,
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 80.0 - (Platform.isAndroid ? 16.0 : 0.0),
      ),
      flipHorizontal: _isSelfieCamera,
      imageDataSource: path != null ? CustomImageDataSource.file(path, fit: BoxFit.cover) : null,
    );
    if (!mounted) return;
    setState(() {
      _pictureCounterVisible = true;
    });
  }

  _startVideoDurationTimer() {
    _videoDurationTimer?.cancel();
    _videoDurationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      _videoDuration.value = _videoDuration.value + const Duration(seconds: 1);
    });
  }

  _stopVideoDurationTimer() {
    _videoDurationTimer?.cancel();
  }

  _setFlashMode(FlashMode flashMode) async {
    if (!_isControllerReady) return;

    _setPanelModel(CustomCameraPanelMode.normal);

    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.changeFlashMode.eventName,
      level: LogEventLevel.info,
      raw: flashMode.name,
      orderID: widget.orderID,
    );

    final CameraController controller = _controller!;

    try {
      setState(() {
        _enabled = false;
      });
      await controller.setFlashMode(flashMode);
      setState(() {
        _enabled = true;
        _flashMode = flashMode;
      });

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.changeFlashMode.eventName,
        level: LogEventLevel.success,
        raw: flashMode.name,
        orderID: widget.orderID,
      );
    } catch (error) {
      log("Error setting flash mode", error: error);
      if (!mounted) return;

      _logEventService.logEvent(
        LogEventModule.camera,
        action: LogEventActionCamera.changeFlashMode.eventName,
        level: LogEventLevel.error,
        raw: flashMode.name,
        message: error.toString(),
        orderID: widget.orderID,
      );

      try {
        await controller.setFlashMode(FlashMode.off);
      } catch (_) {}

      setState(() {
        _enabled = true;
        _flashMode = FlashMode.off;
      });
    }
  }

  _setNarratorMode(bool narratorMode) async {
    if (!_isControllerReady) return;

    final CameraController controller = _controller!;

    _logEventService.logEvent(
      LogEventModule.camera,
      action: LogEventActionCamera.changeNarratorMode.eventName,
      level: LogEventLevel.info,
      raw: jsonEncode({"narratorMode": narratorMode}),
      orderID: widget.orderID,
    );

    setState(() {
      _narratorMode = narratorMode;
    });
    _setPanelModel(CustomCameraPanelMode.normal);
    _onNewCameraSelected(controller.description);
  }

  _setCameraQuality(CameraQuality cameraQuality) async {
    if (!_isControllerReady) return;

    final CameraController controller = _controller!;

    try {
      final SettingsService service = GetIt.I.get();
      await service.setCameraQuality(cameraQuality);
    } catch (error) {
      log("Error changing cameraQuality");
      return;
    }

    _setPanelModel(CustomCameraPanelMode.normal);
    _onNewCameraSelected(controller.description);
  }

  _setPanelModel(CustomCameraPanelMode mode) {
    if (_panelMode == mode) return;
    setState(() {
      _panelMode = mode;
    });
  }

  _setZoomBarVisible(bool visible) {
    if (_zoomBarVisible == visible) return;
    setState(() {
      _zoomBarVisible = visible;
    });
  }

  _cancelCamera() async {
    setState(() {
      _renderCamera = false;
    });
    await CustomWidgetUtils.wait();
    if (_isControllerReady) {
      final controller = _controller;
      if (controller != null) {
        await controller.dispose();
      }
    }
  }

  _pickFromGallery() async {
    CameraDescription? cameraDescription = _controller?.description;
    await _cancelCamera();

    _showStatusBar(true);

    final pickedFile = await showCustomGallery(sourceType: CustomGallerySourceType.videos);

    if (pickedFile != null) {
      // Send to edit
      final edited = await showCustomVideoEditor(
        videos: [
          VideoEditorRequestVideoModel(
            path: pickedFile.path,
          ),
        ],
        pictures: [],
      );

      if (edited == null) {
        _showStatusBar(false);
        pickedFile.deleteSync();
        return;
      }

      if (!mounted) return;
      Navigator.of(context).pop(edited);
      return;
    }

    _showStatusBar(false);
    if (cameraDescription != null) {
      _onNewCameraSelected(cameraDescription);
    }
  }

  Future<bool> _onWillPop() async {
    if (_panelMode != CustomCameraPanelMode.normal) {
      _setPanelModel(CustomCameraPanelMode.normal);
      return false;
    }

    if (_zoomBarVisible) {
      setState(() {
        _zoomBarVisible = false;
      });
      return false;
    }

    _askClose();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final validRotation = _currentRotation == AccelerometerRotationPosition.landscape;
    final panelInvalidRotationVisible = _panelMode == CustomCameraPanelMode.normal && !validRotation && !_recordingVideo;

    return Stack(
      children: [
        // Content
        Positioned.fill(
          child: CustomScaffold(
            backgroundColor: Colors.black,
            onWillPop: _onWillPop,
            appbar: CustomAppBar(
              iconsPadding: 0.0,
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              child: CustomCameraAppBarButtons(
                visible: !panelInvalidRotationVisible,
                enabled: _isButtonsEnabled,
                onButtonCameraQualityPressed: _onButtonCameraQualityPressed,
                currentFlashMode: _flashMode,
                flashModes: _flashModes,
                narratorMode: _narratorMode,
                onButtonFlashModePressed: _onButtonFlashModePressed,
                currentRotation: _currentRotation,
                onButtonInvalidRotationPressed: _onButtonInvalidRotationPressed,
                onButtonClosePressed: _askClose,
                onButtonNarratorModePressed: _onButtonNarratorModePressed,
                video: widget.mode == CustomCameraMode.video,
                recordingVideo: _recordingVideo,
                recordingVideoPaused: _recordingVideoPaused,
              ),
            ),
            body: Container(
              color: Colors.black,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    key: _keyPreviewContainer,
                    child: Stack(
                      children: [
                        // Preview
                        Positioned.fill(
                          child: CustomCameraPreview(
                            controller: _controller,
                            visible: _renderCamera,
                            onTap: _changeFocusPoint,
                            changeZoom: _changeZoom,
                            minZoom: _minZoom,
                            maxZoom: _maxZoom,
                            zoom: _currentZoom,
                            fullScreen: true,
                            recording: _recordingVideo,
                            recordingPaused: _recordingVideoPaused,
                          ),
                        ),

                        // Zoom
                        Center(
                          child: CustomAnimatedFadeVisibility(
                            visible: !panelInvalidRotationVisible,
                            child: Transform.translate(
                              offset: Offset(
                                -MediaQuery.of(context).size.width * 0.5 + (40 * 0.5) + 8.0,
                                0.0,
                              ),
                              child: Transform.rotate(
                                angle: math.pi / 2,
                                child: SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: CustomCameraZoomIndicator(
                                    height: 40,
                                    enabled: _isButtonsEnabled,
                                    zoom: _currentZoom,
                                    dragBarVisible: _zoomBarVisible,
                                    onChange: _changeZoom,
                                    maxZoom: _maxZoom,
                                    minZoom: _minZoom,
                                    onDragBarVisibleChange: (visible) {
                                      _setZoomBarVisible(visible);
                                      _setPanelModel(CustomCameraPanelMode.normal);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Video duration
                        Center(
                          child: CustomAnimatedFadeVisibility(
                            visible: !panelInvalidRotationVisible && _recordingVideo && widget.mode == CustomCameraMode.video,
                            child: Transform.translate(
                              offset: Offset(
                                (MediaQuery.of(context).size.width * 0.5) - (30.0 * 0.5) - 8.0,
                                0.0,
                              ),
                              child: Transform.rotate(
                                angle: math.pi / 2,
                                child: ValueListenableBuilder(
                                  valueListenable: _videoDuration,
                                  builder: (context, value, child) => IgnorePointer(
                                    ignoring: true,
                                    child: CustomCameraVideoDuration(
                                      duration: _videoDuration.value,
                                      recording: _recordingVideo,
                                      recordingPaused: _recordingVideoPaused,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom buttons
                  CustomCameraButtons(
                    visible: !panelInvalidRotationVisible,
                    enabled: _isButtonsEnabled,
                    onCapturePressed: _onButtonCapturePressed,
                    onChangeCameraPressed: _onChangeCameraPressed,
                    onQualityPressed: _onButtonCameraQualityPressed,
                    onVideoPausePressed: _onButtonVideoRecordingPausePressed,
                    video: widget.mode == CustomCameraMode.video,
                    recordingVideo: _recordingVideo,
                    recordingVideoPaused: _recordingVideoPaused,
                    onVideoTakePicturePressed: _takePicture,
                    picturesCount: _pictures.length,
                    picturesCountVisible: _pictureCounterVisible,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Capturing picture
        CustomCameraCapturingPicture(key: _keyCapturingPicture),

        // Panel quality
        CustomCameraPanelOptionsQuality(
          visible: _panelMode == CustomCameraPanelMode.quality,
          onChange: _setCameraQuality,
          close: () => _setPanelModel(CustomCameraPanelMode.normal),
        ),

        // Panel FlashMode
        CustomCameraPanelOptionsFlashMode(
          visible: _panelMode == CustomCameraPanelMode.flash,
          flashModes: _flashModes,
          flashMode: _flashMode,
          onChange: _setFlashMode,
          close: () => _setPanelModel(CustomCameraPanelMode.normal),
        ),

        // Panel Narrator Mode
        CustomCameraPanelOptionsNarratorMode(
          visible: _panelMode == CustomCameraPanelMode.narratorMode,
          narratorMode: _narratorMode,
          onChange: _setNarratorMode,
          close: () => _setPanelModel(CustomCameraPanelMode.normal),
        ),

        // Panel Invalid Rotation
        CustomCameraPanelOptionsInvalidRotation(
          visible: panelInvalidRotationVisible,
          currentRotation: _currentRotation,
          onButtonClosePressed: _close,
          onButtonGalleryPressed: _pickFromGallery,
        ),
      ],
    );
  }
}
