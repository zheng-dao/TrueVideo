import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';

import 'widget.dart';

BuildContext? _context;

class CustomImageViewer {
  static set context(BuildContext? context) {
    _context = context;
  }
}

Future<void> showCustomImageViewer(
  List<CustomImageDataSource> images, {
  int initialIndex = 0,
  String Function(int index)? heroTagBuilder,
  double Function(int index)? aspectRatioBuilder,
  List<Widget> Function(CustomImageDataSource image)? appBarActionBuilder,
  Duration duration = const Duration(milliseconds: 500),
  bool fromBoxFitCover = false,
}) async {
  if (_context == null) return;
  await Navigator.of(_context!).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: CustomImageViewerWidget(
          images: images,
          initialIndex: initialIndex,
          heroTagBuilder: heroTagBuilder,
          appBarActionBuilder: appBarActionBuilder,
          aspectRationBuilder: aspectRatioBuilder,
          fromBoxFitCover: fromBoxFitCover,
        ),
      ),
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    ),
  );
}
