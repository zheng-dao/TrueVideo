enum LogEventActionVideoUpload {
  create,
  edit,
  delete,
  start,
  retry,
  getSettings,
  uploadVideoThumbnail,
  encodeVideo,
  uploadVideo,
  uploadPicture,
  save,
  error,
}

extension LogEventActionVideoUploadEx on LogEventActionVideoUpload {
  String get eventName {
    const prefix = "event_video_upload";

    switch (this) {
      case LogEventActionVideoUpload.create:
        return "${prefix}_create";
      case LogEventActionVideoUpload.edit:
        return "${prefix}_edit";
      case LogEventActionVideoUpload.delete:
        return "${prefix}_delete";
      case LogEventActionVideoUpload.start:
        return "${prefix}_start";
      case LogEventActionVideoUpload.retry:
        return "${prefix}_retry";
      case LogEventActionVideoUpload.uploadVideoThumbnail:
        return "${prefix}_upload_video";
      case LogEventActionVideoUpload.encodeVideo:
        return "${prefix}_encode_video";
      case LogEventActionVideoUpload.uploadVideo:
        return "${prefix}_upload_video";
      case LogEventActionVideoUpload.uploadPicture:
        return "${prefix}_upload_picture";
      case LogEventActionVideoUpload.save:
        return "${prefix}_save";
      case LogEventActionVideoUpload.getSettings:
        return "${prefix}_get_settings";
      case LogEventActionVideoUpload.error:
        return "${prefix}_error";
    }
  }
}
