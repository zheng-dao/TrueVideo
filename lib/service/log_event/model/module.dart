enum LogEventModule {
  camera,
  videoEditor,
  videoUpload,
  settings,
  login,
  orders,
}

extension LogEventModuleEx on LogEventModule {
  String get eventName {
    switch (this) {
      case LogEventModule.camera:
        return "camera";
      case LogEventModule.videoEditor:
        return "video-editor";
      case LogEventModule.videoUpload:
        return "video-upload";
      case LogEventModule.settings:
        return "settings";
      case LogEventModule.login:
        return "login";
      case LogEventModule.orders:
        return "orders";
    }
  }
}
