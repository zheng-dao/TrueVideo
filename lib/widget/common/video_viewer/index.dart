import 'package:flutter/cupertino.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/video_player/model/data.dart';
import 'package:truvideo_enterprise/widget/common/video_viewer/widget.dart';

BuildContext? _context;

class CustomVideoViewer {
  static set context(BuildContext? context) {
    _context = context;
  }
}

Future<void> showCustomVideoViewer(
  CustomVideoPlayerDataSource source, {
  CustomImageDataSource? thumbnail,
  String thumbnailHeroTag = "",
  double? aspectRatio,
  bool fromBoxFitCover = false,
  Duration duration = const Duration(milliseconds: 500),
}) async {
  if (_context == null) return;

  await Navigator.of(_context!).push(
    PageRouteBuilder(
      opaque: true,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: CustomVideoViewerWidget(
          source: source,
          thumbnail: thumbnail,
          thumbnailHeroTag: thumbnailHeroTag,
          aspectRatio: aspectRatio,
          fromBoxFitCover: fromBoxFitCover,
        ),
      ),
    ),
  );
}
