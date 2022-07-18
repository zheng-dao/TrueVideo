enum LogEventActionLogin {
  accessBiometric,
  storeBiometric,
  deleteBiometric,
}

extension LogEventActionLoginEx on LogEventActionLogin {
  String get eventName {
    const prefix = "event_login";

    switch (this) {
      case LogEventActionLogin.accessBiometric:
        return "${prefix}_biometric_access";
      case LogEventActionLogin.storeBiometric:
        return "${prefix}_biometric_configure";
      case LogEventActionLogin.deleteBiometric:
        return "${prefix}_biometric_delete";
    }
  }
}
