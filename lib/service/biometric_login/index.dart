import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/biometric_login/_interface.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/local/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';

class BiometricLoginServiceImpl extends BiometricLoginService {
  LogEventService get _logEventService => GetIt.I.get();

  ConnectivityService get _connectivityService => GetIt.I.get();

  AuthService get _authService => GetIt.I.get();

  LocalService get _localService => GetIt.I.get();

  String _keyUserPinCode(String userUUID) => "user-pin-code-$userUUID";

  String _keyUserAskLinkPin(String userUUID) => "user-ask-link-pin-code-$userUUID";

  _clearPinCode(String userUUID) async {
    try {
      await _localService.delete(_keyUserPinCode(userUUID));
      await _localService.delete(_keyUserAskLinkPin(userUUID));
    } catch (_) {}
  }

  @override
  Future<String> read(String userUUID) async {
    _logEventService.logEvent(
      LogEventModule.login,
      action: LogEventActionLogin.accessBiometric.eventName,
      level: LogEventLevel.info,
      raw: jsonEncode({"userUUID": userUUID}),
    );

    try {
      final pin = _localService.readString(_keyUserPinCode(userUUID));
      if (pin.trim().isEmpty) {
        throw CustomException(message: "Biometric login not configured");
      }

      final auth = LocalAuthentication();
      final authenticated = await auth.authenticate(
        localizedReason: "Please authenticate",
        options: const AuthenticationOptions(stickyAuth: false),
      );
      if (!authenticated) {
        throw CustomException(message: "Error authenticating");
      }

      _logEventService.logEvent(
        LogEventModule.login,
        action: LogEventActionLogin.accessBiometric.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({"userUUID": userUUID}),
      );

      return pin;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.login,
        action: LogEventActionLogin.accessBiometric.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode({"userUUID": userUUID}),
      );

      rethrow;
    }
  }

  @override
  Future<void> delete(String userUUID) async {
    try {
      _logEventService.logEvent(
        LogEventModule.login,
        action: LogEventActionLogin.deleteBiometric.eventName,
        level: LogEventLevel.info,
        raw: jsonEncode({"userUUID": userUUID}),
      );

      await _clearPinCode(userUUID);

      _logEventService.logEvent(
        LogEventModule.login,
        action: LogEventActionLogin.deleteBiometric.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({"userUUID": userUUID}),
      );
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.login,
        action: LogEventActionLogin.deleteBiometric.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode({"userUUID": userUUID}),
      );
    }
  }

  @override
  Future<void> store({required String userUUID, required String dealerCode, required String pin}) async {
    try {
      _logEventService.logEvent(
        LogEventModule.login,
        action: LogEventActionLogin.storeBiometric.eventName,
        level: LogEventLevel.info,
        raw: jsonEncode(
          {
            "userUUID": userUUID,
            "dealerCode": dealerCode,
          },
        ),
      );

      await _connectivityService.validateOnline();
      final loginResult = await _authService.login(
        dealerCode: dealerCode,
        userUuid: userUUID,
        pin: pin,
        validateOnly: true,
      );

      switch (loginResult) {
        case LoginResult.success:
          break;
        case LoginResult.invalidPin:
          throw CustomException(message: "Invalid pin");
        case LoginResult.userNotFound:
          throw CustomException(message: "User not found");
        case LoginResult.unknownError:
          throw CustomException(message: "Unknown error");
        case LoginResult.unauthorized:
          throw CustomException(message: "User unauthorized");
      }

      final auth = LocalAuthentication();
      final authenticated = await auth.authenticate(
        localizedReason: "Please authenticate",
        options: const AuthenticationOptions(stickyAuth: false),
      );
      if (!authenticated) {
        throw CustomException(message: "Error authenticating");
      }

      await _localService.storeString(_keyUserPinCode(userUUID), pin);

      _logEventService.logEvent(
        LogEventModule.login,
        action: LogEventActionLogin.storeBiometric.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode(
          {
            "userUUID": userUUID,
            "dealerCode": dealerCode,
          },
        ),
      );
    } catch (error, stack) {
      log("Error storing pin", error: error, stackTrace: stack);

      _logEventService.logEvent(
        LogEventModule.login,
        action: LogEventActionLogin.storeBiometric.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode(
          {
            "userUUID": userUUID,
            "dealerCode": dealerCode,
          },
        ),
      );

      await _clearPinCode(userUUID);

      rethrow;
    }
  }

  @override
  bool getStatus(String userUUID) {
    final pin = _localService.readString(_keyUserPinCode(userUUID));
    if (pin.trim().isEmpty) return false;
    return true;
  }

  @override
  Stream<bool> streamStatus(String userUUID) {
    return _localService.streamString(_keyUserPinCode(userUUID)).map((pin) => pin.trim().isNotEmpty);
  }

  @override
  bool shouldAskLink(String userUUID) {
    final linked = getStatus(userUUID);
    if (linked) return false;

    final neverAsk = _localService.readBool(_keyUserAskLinkPin(userUUID));
    if (neverAsk) return false;

    return true;
  }

  @override
  Future<void> markNeverAskAgainLink(String userUUID) async {
    await _localService.storeBool(_keyUserAskLinkPin(userUUID), true);
  }
}
