import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/bottom_sheet/controller.dart';
import 'package:truvideo_enterprise/widget/common/bottom_sheet/widget.dart';

Future<void> showCustomBottomSheet(
  BuildContext context, {
  required Widget Function(BuildContext context, CustomBottomSheetController controller) builder,
  bool Function()? canClose,
  double bounce = 20.0,
  Curve curve = Curves.decelerate,
  bool dragEnabled = true,
  Duration duration = const Duration(milliseconds: 300),
  CustomBottomSheetController? controller,
}) async {
  await Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration.zero,
      opaque: false,
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) => CustomBottomSheet(
        controller: controller,
        builder: builder,
        canClose: canClose ?? () => true,
        close: () => Navigator.of(context).pop(),
        bounce: bounce,
        curve: curve,
        dragEnabled: dragEnabled,
        duration: duration,
      ),
    ),
  );
}
