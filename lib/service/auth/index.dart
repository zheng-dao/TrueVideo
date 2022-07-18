import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/dealer_code_access_history.dart';
import 'package:truvideo_enterprise/model/dealer_info.dart';
import 'package:truvideo_enterprise/model/user_settings.dart';
import 'package:truvideo_enterprise/model/user.dart';
import 'package:truvideo_enterprise/model/user_login.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/device/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/local/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/push_notification/_interface.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';

class AuthServiceImpl implements AuthService {
  LocalService get _localService => GetIt.I.get();

  HttpService get _httpService => GetIt.I.get();

  LocalDatabaseService get _localDatabase => GetIt.I.get();

  ConnectivityService get _connectivityService => GetIt.I.get();

  DeviceService get _deviceService => GetIt.I.get();

  PushNotificationService get _pushNotificationService => GetIt.I.get();

  final String baseURL;
  final String securityToken;
  String? _token;

  @override
  Future<String?> get token async {
    final exp = tokenExpiration;
    if (exp != null && exp.difference(DateTime.now()).inHours < 24) {
      try {
        await refreshToken();
      } catch (error) {
        log("Error refreshing JWT token", error: error);
      }
    }

    return _token;
  }

  @override
  String? get applicationUid => _getValueFromToken(_token, "applicationUid");

  @override
  String? get accountUid => _getValueFromToken(_token, "accountUid");

  @override
  String? get deviceUid => _getValueFromToken(_token, "deviceUid");

  @override
  String? get displayName => _getValueFromToken(_token, "displayName");

  @override
  String? get groups => _getValueFromToken(_token, "groups");

  @override
  String? get sub => _getValueFromToken(_token, "sub");

  @override
  DateTime? get tokenExpiration {
    final token = _token;
    if (token == null || token.isEmpty) return null;
    final map = JwtDecoder.decode(token);
    if (!map.containsKey("exp")) return null;
    final value = map["exp"].toString().trim();
    if (value.trim().isEmpty) return null;
    return DateTime.fromMillisecondsSinceEpoch(int.parse(value) * 1000);
  }

  String? _getValueFromToken(String? token, String key) {
    if (token == null || token.isEmpty) return null;
    final map = JwtDecoder.decode(token);
    if (!map.containsKey(key)) return null;
    final value = map[key].toString().trim();
    if (value.trim().isEmpty) return null;
    return value;
  }

  AuthServiceImpl({
    required this.baseURL,
    required this.securityToken,
  });

  @override
  Future<UserModel?> getCachedLoggedUser() async {
    final token = _localService.readString("token");
    if (token.trim().isEmpty) return null;

    final cachedUser = await _localDatabase.read("logged-user", "data");
    if (cachedUser == null) return null;
    try {
      final model = UserModel.fromJson(jsonDecode(jsonEncode(cachedUser)));
      _token = token;
      return model;
    } catch (error, stack) {
      log("Error parsing cached user", error: error, stackTrace: stack);
      return null;
    }
  }

  @override
  Future<UserModel?> isLogin() async {
    final token = _localService.readString("token");
    if (token.trim().isEmpty) return null;

    try {
      final fcmToken = await _pushNotificationService.getToken();

      final data = await _httpService.get(
        Uri.parse("$baseURL/api/v3/registration/login"),
        headers: {
          "X-Authorization-Truvideo": token,
          "X-Authorization-fcm": fcmToken,
        },
        params: {
          "account-uid": _getValueFromToken(token, "accountUid"),
        },
      );

      UserModel? user;
      try {
        user = UserModel.fromJson(data.data as Map<String, dynamic>);
      } catch (error, stack) {
        log("Error parsing user model", error: error, stackTrace: stack);
      }

      if (user == null) {
        throw CustomException(message: "no user info");
      }

      _token = token;

      await _localService.storeString(user.publicUserUuid, DateTime.now().toString());
      await _localService.storeString("token", token);
      await _localService.storeString("user-uuid", user.publicUserUuid);
      await _localDatabase.write("logged-user", "data", user.toJson());
      await storeDealerCode(getStoredDealerCode());
      return user;
    } catch (error, stack) {
      log("Error checking IsLogin", error: error, stackTrace: stack);
      _token = null;
      await _localDatabase.delete("logged-user", "data");
      return null;
    }
  }

  @override
  Future<LoginResult> login({
    required String dealerCode,
    required String userUuid,
    required String pin,
    bool validateOnly = false,
  }) async {
    try {
      await _connectivityService.validateOnline();

      final device = await _deviceService.getInfo();
      final fcmToken = await _pushNotificationService.getToken();

      final response = await _httpService.post(
        Uri.parse("$baseURL/api/v3/registration/login"),
        headers: {
          "X-security-token": securityToken,
        },
        data: {
          "deviceId": kIsWeb ? "web_device_$userUuid" : device.id,
          "manufacturer": device.manufacturer,
          "model": device.model,
          "name": device.name,
          "latitude": 0,
          "longitude": 0,
          "dealerCode": dealerCode,
          "userUuid": userUuid,
          "pin": pin,
          "token": fcmToken,
        },
      );

      const headerKey = "x-authorization-truvideo";
      if (response.headers == null) {
        throw CustomException(message: "No header response. Header response: ${response.headers?.toString()}");
      }

      if (response.headers![headerKey] == null) {
        throw CustomException(message: "No response header key: '$headerKey'. Header response: ${response.headers?.toString()}");
      }

      final header = response.headers![headerKey]!;
      if (header.isEmpty) {
        throw CustomException(message: "Response header '$headerKey' is empty. Header response: ${response.headers?.toString()}");
      }

      String token = header[0];
      if (token.trim().isEmpty) {
        throw CustomException(message: "Response header '$headerKey' value is empty. Header response: ${response.headers?.toString()}");
      }

      if (!validateOnly) {
        await _localService.storeString(userUuid, DateTime.now().toString());
        await _localService.storeString("token", token);
        await _localService.storeString("user-uuid", userUuid);
        await _localService.storeString("user-pin-code", pin);
        await storeDealerCode(dealerCode);
        _token = token;
      }

      return LoginResult.success;
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      if (!validateOnly) {
        _token = null;
      }

      if (error is! DioError) throw CustomException(message: "$error");

      String message = "";
      if (error.response?.data != null && error.response?.data is Map) {
        message = error.response?.data?["message"].toString() ?? "";
      }

      switch (error.response?.statusCode) {
        case 400:
          {
            if (message == "Invalid Pin") {
              return LoginResult.invalidPin;
            }

            if (message.trim().isNotEmpty) {
              throw CustomException(message: error.response.toString());
            }
          }
          break;

        case 401:
          {
            return LoginResult.unauthorized;
          }

        case 404:
          {
            if (message == "User not found") {
              return LoginResult.userNotFound;
            }
          }
          break;
      }

      if (message.trim().isNotEmpty) {
        throw CustomException(message: message);
      }

      rethrow;
    }
  }

  @override
  DateTime? getLastAccessDate(String userUid) {
    try {
      final date = _localService.readString(userUid);
      if (date.trim().isEmpty) {
        return null;
      }

      return DateTime.parse(date);
    } catch (error, stack) {
      log("Error parsing last access date", error: error, stackTrace: stack);
      _localService.delete(userUid);
      return null;
    }
  }

  @override
  Future<void> deleteLastAccessDate(String userUid) async {
    await _localService.delete(userUid);
  }

  @override
  Future<void> logout() async {
    final token = _localService.readString("token");
    if (token.trim().isEmpty) return;

    await _localService.delete("token");
    await _localService.delete("user-uuid");
    await _localService.delete("user-pin-code");
    await _localDatabase.delete("logged-user", "data");

    try {
      await _httpService.get(
        Uri.parse("$baseURL/api/v3/registration/logout"),
        headers: {
          "X-Authorization-Truvideo": token,
        },
        params: {
          "account-uid": accountUid ?? "",
        },
      );
    } catch (error) {
      log("Error logout", error: error);
      showCustomDialog(title: "Error loggin out");
    }

    try {
      await _pushNotificationService.revokeToken();
    } catch (error) {
      log("Error revoke token", error: error);
    }
  }

  @override
  Future<DealerInfoModel?> getDealerInfo(String dealerCode) async {
    await _connectivityService.validateOnline();

    try {
      final response = await _httpService.get(
        Uri.parse("$baseURL/api/v3/registration/verify-dealer"),
        headers: {
          "X-security-token": securityToken,
        },
        params: {
          "dealer-code": dealerCode,
        },
      );
      return DealerInfoModel.fromJson(response.data as Map<String, dynamic>);
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);

      if (error is DioError) {
        switch (error.response?.statusCode) {
          case 404:
            {
              return null;
            }
        }
      }

      throw CustomException();
    }
  }

  @override
  Future<List<UserLoginModel>> getUsersForDealerCode(String dealerCode) async {
    await _connectivityService.validateOnline();

    try {
      final response = await _httpService.get(
        Uri.parse("$baseURL/api/v3/registration/users"),
        headers: {
          "X-security-token": securityToken,
        },
        params: {
          "dealer-code": dealerCode,
        },
      );

      return (response.data as List).map((e) => UserLoginModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      throw CustomException();
    }
  }

  @override
  Future<void> storeDealerCode(String dealerCode) async {
    await _localService.storeString("dealer-code", dealerCode);
    await _localDatabase.write(
      "dealer-codes",
      dealerCode,
      DealerCodeAccessHistoryModel(
        date: DateTime.now(),
        dealerCode: dealerCode,
      ).toJson(),
    );
  }

  @override
  Future<void> clearDealerCode() async {
    await _localService.delete("dealer-code");
  }

  @override
  String getStoredDealerCode() {
    return _localService.readString("dealer-code");
  }

  @override
  Future<UserLoginModel> create({
    required String dealerCode,
    required String publicDealerUuid,
    required String integrationId,
    required String mobileNumber,
    required String firstName,
    required String lastName,
    required String title,
    required String email,
    required String username,
    required String password,
    required String pin,
  }) async {
    await _connectivityService.validateOnline();

    try {
      final response = await _httpService.post(
        Uri.parse("$baseURL/api/v3/registration/register-user"),
        headers: {
          "X-security-token": securityToken,
        },
        params: {
          "dealer-code": dealerCode,
        },
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "pin": pin,
          "title": title,
          "publicDealerUuid": publicDealerUuid,
          "email": email,
          "username": username,
          "password": password,
          "mobileNumber": mobileNumber,
          "isPasswordEncoded": false,
          "integrationId": integrationId,
        },
      );

      return UserLoginModel.fromJson(response.data as Map<String, dynamic>);
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);

      if (error is DioError) {
        switch (error.response?.statusCode) {
          case 400:
            {
              throw CustomException(message: "${error.response}");
            }
        }
      }

      throw CustomException();
    }
  }

  @override
  Stream<List<DealerCodeAccessHistoryModel>> streamDealerCodesHistory() {
    return _localDatabase.streamAll("dealer-codes").map((event) {
      final items = event
          .map((e) {
            try {
              return DealerCodeAccessHistoryModel.fromJson(jsonDecode(jsonEncode(e)));
            } catch (error, stack) {
              log("Error parsing", error: error, stackTrace: stack);
              return null;
            }
          })
          .where((e) => e != null)
          .map((e) => e!)
          .toList();

      items.sort((a, b) => (b.date ?? DateTime.now()).compareTo(a.date ?? DateTime.now()));
      return items;
    });
  }

  @override
  Future<List<DealerCodeAccessHistoryModel>> getDealerCodesHistory() async {
    final data = await _localDatabase.getAll("dealer-codes");
    final items = data
        .map((e) {
          try {
            return DealerCodeAccessHistoryModel.fromJson(jsonDecode(jsonEncode(e)));
          } catch (error, stack) {
            log("Error parsing", error: error, stackTrace: stack);
            return null;
          }
        })
        .where((e) => e != null)
        .map((e) => e!)
        .toList();

    items.sort((a, b) => (b.date ?? DateTime.now()).compareTo(a.date ?? DateTime.now()));
    return items;
  }

  @override
  Future<void> validateUsernameEmail({required String email, required String username}) async {
    await _connectivityService.validateOnline();

    try {
      await _httpService.get(
        Uri.parse("$baseURL/api/v3/registration/check-user"),
        headers: {
          "X-security-token": securityToken,
        },
        params: {
          "username": username,
          "email": email,
        },
      );
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);

      if (error is DioError) {
        switch (error.response?.statusCode) {
          case 400:
            {
              throw CustomException(message: "${error.response}");
            }
        }
      }

      throw CustomException();
    }
  }

  @override
  Future<UserModel?> getMyProfile() async {
    final result = await _httpService.get(
      Uri.parse("$baseURL/api/v3/registration/user"),
      headers: {
        "X-Authorization-Truvideo": (await token),
      },
      params: {
        "account-uid": accountUid,
      },
    );

    log("User info ${result.data}");

    try {
      return UserModel.fromJson(result.data as Map<String, dynamic>);
    } catch (error) {
      log("Error parsing UserModel", error: error);
      return null;
    }
  }

  @override
  Future<List<UserSettingsModel>> getUserSettings() async {
    final response = await _httpService.get(
      Uri.parse("$baseURL/api/v3/registration/load-settings"),
      headers: {
        "X-Authorization-Truvideo": (await token),
      },
      params: {
        "account-uid": accountUid,
      },
    );

    final model = (response.data as List).map((e) => UserSettingsModel.fromJson(e as Map<String, dynamic>)).toList();

    await _localDatabase.write("user-settings", "settings", jsonEncode(model.map((e) => e.toJson()).toList()));

    return model;
  }

  @override
  Future<List<UserSettingsModel>?> getCachedUserSettings() async {
    final data = await _localDatabase.read("user-settings", "settings");
    if (data == null) {
      return null;
    }

    return (jsonDecode(data.toString()) as List<dynamic>)
        .map((e) {
          try {
            return UserSettingsModel.fromJson(e as Map<String, dynamic>);
          } catch (error) {
            log("Error parsing cached UserSettingsModel", error: error);
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  @override
  Future<void> refreshToken() async {
    final userUUID = _localService.readString("user-uuid");
    final pin = _localService.readString("user-pin-code");
    await login(dealerCode: getStoredDealerCode(), userUuid: userUUID, pin: pin);
  }
}
