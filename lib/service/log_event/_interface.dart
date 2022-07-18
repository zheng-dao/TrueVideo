import 'package:truvideo_enterprise/service/log_event/model/level.dart';

import 'model/module.dart';

export 'model/module.dart';
export 'model/level.dart';
export 'model/actions_camera.dart';
export 'model/actions_settings.dart';
export 'model/actions_login.dart';
export 'model/actions_video_upload.dart';
export 'model/actions_video_editor.dart';
export 'model/actions_orders.dart';

abstract class LogEventService {
  Future<void> logScreen(String screenName);

  Future<void> logEvent(
    LogEventModule module, {
    String action = "",
    LogEventLevel? level,
    String message = "",
    String raw = "",
    int? orderID,
  });

  Future<void> processLog(
    LogEventModule module, {
    String action = "",
    LogEventLevel? level,
    String message = "",
    String raw = "",
    int? orderID,
  });

  Future<void> logEventError(Exception err, StackTrace? stackTrace);
}
