import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:truvideo_enterprise/core/router/sheet_container.dart';
import 'package:truvideo_enterprise/model/video_type_model.dart';

import 'widget.dart';

BuildContext? _context;

class CustomVideoTypePicker {
  static set context(BuildContext? context) {
    _context = context;
  }
}

Future<VideoTypeModel?> showCustomVideoTypePicker() async {
  if (_context == null) return null;
  final result = await Navigator.of(_context!).push(
    CupertinoModalBottomSheetRoute(
      builder: (context) => const ScreenCustomVideoTypePicker(),
      containerBuilder: (context, _, child) => CupertinoBottomSheetContainer(child: child),
      expanded: true,
      elevation: 16.0,
      isDismissible: true,
      topRadius: kDefaultTopRadius,
      duration: const Duration(milliseconds: 300),
      settings: const RouteSettings(name: "/ScreenCustomVideoTypePicker"),
    ),
  );

  if (result == null || result is! VideoTypeModel) return null;
  return result;
}
