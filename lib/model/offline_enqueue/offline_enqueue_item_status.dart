import 'package:flutter/material.dart';

enum OfflineEnqueueItemStatus {
  pending,
  processing,
  done,
  error,
}

extension OfflineEnqueueItemStatusExtension on OfflineEnqueueItemStatus {
  String get name {
    switch (this) {
      case OfflineEnqueueItemStatus.pending:
        return "Pending";
      case OfflineEnqueueItemStatus.processing:
        return "Processing";
      case OfflineEnqueueItemStatus.done:
        return "Done";
      case OfflineEnqueueItemStatus.error:
        return "Error";
    }
  }

  Color get color {
    switch (this) {
      case OfflineEnqueueItemStatus.pending:
        return Colors.amber;
      case OfflineEnqueueItemStatus.processing:
        return Colors.orange;
      case OfflineEnqueueItemStatus.done:
        return Colors.green;
      case OfflineEnqueueItemStatus.error:
        return Colors.red;
    }
  }
}


