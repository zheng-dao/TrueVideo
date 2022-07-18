enum LogEventActionSettings {
  changeCameraQuality,
  changeCameraQualityError,
  changeCameraQualitySuccess,
}

extension LogEventActionSettingsEx on LogEventActionSettings {
  String get eventName {
    const prefix = "event_setting";

    switch (this) {
      case LogEventActionSettings.changeCameraQuality:
        return "${prefix}_change_camera_quality";
      case LogEventActionSettings.changeCameraQualityError:
        return "${prefix}_change_camera_quality_error";
      case LogEventActionSettings.changeCameraQualitySuccess:
        return "${prefix}_change_camera_quality_success";
    }
  }
}
