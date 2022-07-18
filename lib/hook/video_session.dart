import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/camera/video_session.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/video_session/_interface.dart';

AsyncSnapshot<VideoSessionModel?> useVideoSession(WidgetRef ref, String tag) {
  final AuthService authService = GetIt.I.get();
  final VideoSessionService videoSessionService = GetIt.I.get();
  return useStream(
    useMemoized(
      () => videoSessionService.streamByTag(tag),
      [authService.sub ?? "", tag],
    ),
  );
}
