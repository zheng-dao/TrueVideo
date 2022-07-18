enum LogEventLevel {
  info,
  warning,
  error,
  success,
}

extension LogEventLevelExtension on LogEventLevel {


  String get name {
    switch (this) {
      case LogEventLevel.info:
        return "info";
      case LogEventLevel.warning:
        return "warning";
      case LogEventLevel.error:
        return "error";
      case LogEventLevel.success:
        return "success";
    }
  }
}
