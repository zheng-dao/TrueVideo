enum LogEventActionVideoEditor {
  videoRotate,
  videoConcat,
  videoInfo,
  videoTrim,
  videoThumbnail,
  pictureEdit,
  pictureSize,
}

extension LogEventActionVideoEditorEx on LogEventActionVideoEditor {
  String get eventName {
    const prefix = "event_video_editor";

    switch (this) {
      case LogEventActionVideoEditor.videoRotate:
        return "${prefix}_video_rotate";
      case LogEventActionVideoEditor.videoConcat:
        return "${prefix}_video_concat";
      case LogEventActionVideoEditor.videoInfo:
        return "${prefix}_video_info";
      case LogEventActionVideoEditor.videoThumbnail:
        return "${prefix}_video_thumbnail";
      case LogEventActionVideoEditor.pictureEdit:
        return "${prefix}_picture_edit";
      case LogEventActionVideoEditor.pictureSize:
        return "${prefix}_picture_size";
      case LogEventActionVideoEditor.videoTrim:
        return "${prefix}_video_trim";
    }
  }
}
