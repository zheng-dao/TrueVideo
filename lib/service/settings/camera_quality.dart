import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum CameraQuality {
  low,
  medium,
  high,
}

extension CameraQualityExtension on CameraQuality {
  IconData get icon {
    switch (this) {
      case CameraQuality.low:
        return MdiIcons.qualityLow;
      case CameraQuality.medium:
        return MdiIcons.qualityMedium;
      case CameraQuality.high:
        return MdiIcons.qualityHigh;
    }
  }

  String get name {
    switch (this) {
      case CameraQuality.low:
        return "Low";
      case CameraQuality.medium:
        return "Medium";
      case CameraQuality.high:
        return "High";
    }
  }
}
