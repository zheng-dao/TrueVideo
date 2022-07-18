enum OfflineEnqueueItemType {
  unknown,
  chat,
  repairOrderVideoUpload,
  log,
}

extension OfflineEnqueueItemTypeExtension on OfflineEnqueueItemType {
  String get name {
    switch (this) {
      case OfflineEnqueueItemType.chat:
        return "Chat";
      case OfflineEnqueueItemType.repairOrderVideoUpload:
        return "Repair order video upload";
      case OfflineEnqueueItemType.log:
        return "Logs";
      case OfflineEnqueueItemType.unknown:
        return "Unknown";
    }
  }

  String get eventKey {
    switch (this) {
      case OfflineEnqueueItemType.chat:
        return "chat";
      case OfflineEnqueueItemType.repairOrderVideoUpload:
        return "video-upload";
      case OfflineEnqueueItemType.log:
        return "event-log";
      case OfflineEnqueueItemType.unknown:
        return "unknown";
    }
  }
}
