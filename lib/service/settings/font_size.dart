enum SettingsFontSize {
  small,
  medium,
  big,
}

extension SettingsFontSizeExtension on SettingsFontSize {
  double get scale {
    switch (this) {
      case SettingsFontSize.small:
        return 0.8;
      case SettingsFontSize.medium:
        return 1.0;
      case SettingsFontSize.big:
        return 1.5;
    }
  }

  String get name {
    switch (this) {
      case SettingsFontSize.small:
        return "Small";
      case SettingsFontSize.medium:
        return "Medium";
      case SettingsFontSize.big:
        return "Large";
    }
  }
}
