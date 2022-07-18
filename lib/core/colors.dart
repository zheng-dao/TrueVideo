import 'package:flutter/material.dart';

class CustomColorsUtils {
  static Color get backgroundColor => Colors.white;

  static Color contrast(BuildContext context, Color color) {
    return color.contrast(context);
  }

  static Color get accent => const Color(0xFF3684D9);

  static Color get textFieldBorder => const Color(0xFFAEB7C3);

  static Color get textFieldFocusedBorder => const Color(0xFF3684D9);

  static LinearGradient get gradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF739FDD),
          Color(0xFF4C82D3),
        ],
      );

  static LinearGradient get deleteGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.red.shade400,
          Colors.red.shade700,
        ],
      );

  static Color get divider => Colors.grey.shade200;

  static Color get statusActive => const Color(0xFF16DE98);

  static Color get statusNew => const Color(0xFF16DE98);

  static Color get statusSent => const Color(0xFF6D7E91);

  static Color get statusRejected => const Color(0xFF6D7E91);

  static Color get statusPending => const Color(0xFFE9C91D);

  static Color get statusCancel => const Color(0xFFF33060);

  static Color get statusComplete => const Color(0xFFE9C91D);

  //  const Color(0xFF3684D9);

  static Color get delete => const Color(0xFFF33060);

  static Color get messageBubbleMe => const Color(0xFFC6DCF5);

  static Color get messageBubbleOther => Colors.white;

  static Color get chatBackground => const Color(0xFFEBF1F7);

  static Color get card => Colors.white;

  static Color get callBackground => const Color(0xFF2E445E);

  static Color get callButton => const Color(0x1118254D);

  static Color get callParticipantColor => const Color(0xFF6D7E91);

  static Color get checklistRed => const Color(0xFFDF4463);

  static Color get checklistGreen => const Color(0xFF67DB9D);

  static Color get checklistYellow => const Color(0xFFE9C91D);

  static Color get checklistGrey => const Color(0xFF6D7E91);

  static Color get cameraButtonBorderColor => Colors.white.withOpacity(0.4);

  static Color get cameraButtonFillColor => Colors.black.withOpacity(0.4);

  static Color get cameraPanelBackground => Colors.black.withOpacity(0.6);

  static Color get cameraCaptureButtonVideoColor => Colors.red;

  static Color get cameraCaptureButtonPictureColor => Colors.white;

  static Color get cameraCaptureButtonBorderColor => Colors.white;

  static Color get textLabel => const Color(0xFF2E445E);

  static Color get textDescription => const Color(0xFF6D7E91);

  static Color get rippleColor => Colors.black.withOpacity(0.1);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ColorExtension on Color {
  bool get isDark {
    return computeLuminance() > 0.5;
  }

  Color contrast(BuildContext context) {
    if (opacity == 0.0 || this == Colors.transparent) return Theme.of(context).colorScheme.background.contrast(context);
    return computeLuminance() < 0.5 ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.9);
  }

  String get hex {
    return '#'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}'
        '${alpha.toRadixString(16).padLeft(2, '0')}';
  }
}
