import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/camera/camera_result.dart';
import 'package:truvideo_enterprise/model/video_editor/request_picture.dart';
import 'package:truvideo_enterprise/model/video_editor/request_video.dart';
import 'package:truvideo_enterprise/widget/common/video_editor/widget.dart';


BuildContext? _context;

class CustomVideoEditor {
  static set context(BuildContext? context) {
    _context = context;
  }
}

Future<CameraResultModel?> showCustomVideoEditor({
  required List<VideoEditorRequestVideoModel> videos,
  required List<VideoEditorRequestPictureModel> pictures,
}) async {
  if (_context == null) return null;
  final result = await Navigator.of(_context!).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: CustomVideoEditorScreen(
          videos: videos,
          pictures: pictures,
        ),
      ),
    ),
  );

  if (result == null || result is! CameraResultModel) return null;
  return result;
}
