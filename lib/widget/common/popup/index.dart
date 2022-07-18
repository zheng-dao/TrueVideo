import 'package:flutter/cupertino.dart';
import 'package:truvideo_enterprise/widget/common/popup/controller.dart';
import 'package:truvideo_enterprise/widget/common/popup/widget.dart';

BuildContext? _context;

class CustomPopup {
  static set context(BuildContext? context) {
    _context = context;
  }
}

Future<void> showCustomPopup({
  required Widget Function(BuildContext context, CustomPopupController controller) builder,
  double? left,
  double? right,
  double? top,
  double width = 200.0,
  CustomPopupController? controller,
}) async {
  final c = _context;
  if (c == null) return;
  await Navigator.of(c).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CustomPopupWidget(
        builder: builder,
        left: left,
        right: right,
        top: top,
        controller: controller,
        width: width,
        close: () => Navigator.of(context).pop(),
      ),
      opaque: false,
      transitionDuration: Duration.zero,
    ),
  );
}
