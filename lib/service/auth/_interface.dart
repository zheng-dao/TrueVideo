import 'package:truvideo_enterprise/model/dealer_code_access_history.dart';
import 'package:truvideo_enterprise/model/dealer_info.dart';
import 'package:truvideo_enterprise/model/user_settings.dart';
import 'package:truvideo_enterprise/model/user.dart';
import 'package:truvideo_enterprise/model/user_login.dart';

enum LoginResult {
  success,
  invalidPin,
  userNotFound,
  unknownError,
  unauthorized,
}

abstract class AuthService {
  Future<UserModel?> getCachedLoggedUser();

  Future<UserModel?> isLogin();

  Future<String?> get token;

  String? get applicationUid;

  String? get accountUid;

  String? get deviceUid;

  String? get displayName;

  String? get groups;

  String? get sub;

  DateTime? get tokenExpiration;

  Future<LoginResult> login({
    required String dealerCode,
    required String userUuid,
    required String pin,
    bool validateOnly = false,
  });

  Future<void> refreshToken();

  Future<void> logout();

  Future<DealerInfoModel?> getDealerInfo(String dealerCode);

  Future<List<UserLoginModel>> getUsersForDealerCode(String dealerCode);

  String getStoredDealerCode();

  Future<void> storeDealerCode(String dealerCode);

  Future<void> clearDealerCode();

  Future<void> deleteLastAccessDate(String userUid);

  DateTime? getLastAccessDate(String userUid);

  Future<UserLoginModel> create({
    required String dealerCode,
    required String firstName,
    required String lastName,
    required String pin,
    required String title,
    required String publicDealerUuid,
    required String email,
    required String username,
    required String password,
    required String mobileNumber,
    required String integrationId,
  });

  Stream<List<DealerCodeAccessHistoryModel>> streamDealerCodesHistory();

  Future<List<DealerCodeAccessHistoryModel>> getDealerCodesHistory();

  Future<void> validateUsernameEmail({required String email, required String username});

  Future<UserModel?> getMyProfile();

  Future<List<UserSettingsModel>> getUserSettings();

  Future<List<UserSettingsModel>?> getCachedUserSettings();
}
