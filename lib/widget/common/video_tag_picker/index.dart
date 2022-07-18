import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:truvideo_enterprise/core/router/sheet_container.dart';
import 'package:truvideo_enterprise/model/video_tag_model.dart';

import 'widget.dart';

BuildContext? _context;

class CustomVideoTagPicker {
  static set context(BuildContext? context) {
    _context = context;
  }
}

Future<VideoTagModel?> showCustomVideoTagPicker() async {
  if (_context == null) return null;
  final result = await Navigator.of(_context!).push(
    CupertinoModalBottomSheetRoute(
      builder: (context) => const ScreenVideoTagPicker(),
      containerBuilder: (context, _, child) => CupertinoBottomSheetContainer(child: child),
      expanded: true,
      elevation: 16.0,
      isDismissible: true,
      topRadius: kDefaultTopRadius,
      duration: const Duration(milliseconds: 300),
      settings: const RouteSettings(name: "/ScreenCustomVideoTagPicker"),
    ),
  );

  if (result == null || result is! VideoTagModel) return null;
  return result;
}
