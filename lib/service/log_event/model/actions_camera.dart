enum LogEventActionCamera {
  /// List cameras
  listCameras,
  initCamera,
  rotationChange,
  recordStart,
  recordPause,
  recordResume,
  recordFinish,
  takePicture,
  cancel,
  createSession,
  resumeSession,
  deleteSession,
  addVideoToSession,
  addPictureToSession,
  switchCamera,
  changeFlashMode,
  changeNarratorMode,
}

extension LogEventActionCameraExt on LogEventActionCamera {
  String get eventName {
    const prefix = "event_camera";
    switch (this) {
      case LogEventActionCamera.initCamera:
        return "${prefix}_init";
      case LogEventActionCamera.recordStart:
        return "${prefix}_record_start";
      case LogEventActionCamera.recordPause:
        return "${prefix}_record_pause";
      case LogEventActionCamera.recordResume:
        return "${prefix}_record_resume";
      case LogEventActionCamera.recordFinish:
        return "${prefix}_record_finish";
      case LogEventActionCamera.takePicture:
        return "${prefix}_take_picture";
      case LogEventActionCamera.cancel:
        return "${prefix}_cancel";
      case LogEventActionCamera.createSession:
        return "${prefix}_session_create";
      case LogEventActionCamera.resumeSession:
        return "${prefix}_session_resume";
      case LogEventActionCamera.deleteSession:
        return "${prefix}_session_delete";
      case LogEventActionCamera.addVideoToSession:
        return "${prefix}_session_add_video";
      case LogEventActionCamera.addPictureToSession:
        return "${prefix}_session_add_picture";
      case LogEventActionCamera.switchCamera:
        return "${prefix}_switch_camera";
      case LogEventActionCamera.changeFlashMode:
        return "${prefix}_change_flash_mode";
      case LogEventActionCamera.listCameras:
        return "${prefix}_list_cameras";
      case LogEventActionCamera.rotationChange:
        return "${prefix}_rotation_change";
      case LogEventActionCamera.changeNarratorMode:
        return "${prefix}_change_narrator_mode";
    }
  }
}
