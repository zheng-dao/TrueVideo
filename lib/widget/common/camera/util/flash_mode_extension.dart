import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

extension FlashModeExtension on FlashMode {
  IconData get icon {
    switch (this) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.torch:
        return Icons.flash_on;
    }
  }

  String get name {
    switch (this) {
      case FlashMode.off:
        return "Off";
      case FlashMode.auto:
        return "Auto";
      case FlashMode.always:
        return "Always";
      case FlashMode.torch:
        return "Torch";
    }
  }
}
