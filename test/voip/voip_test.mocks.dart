// Mocks generated by Mockito 5.1.0 from annotations
// in truvideo_enterprise/test/voip/voip_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:truvideo_enterprise/model/dealer_code_access_history.dart'
    as _i8;
import 'package:truvideo_enterprise/model/dealer_info.dart' as _i7;
import 'package:truvideo_enterprise/model/user.dart' as _i6;
import 'package:truvideo_enterprise/model/user_login.dart' as _i2;
import 'package:truvideo_enterprise/model/user_settings.dart' as _i9;
import 'package:truvideo_enterprise/service/auth/_interface.dart' as _i4;
import 'package:truvideo_enterprise/service/http/_interface.dart' as _i10;
import 'package:truvideo_enterprise/service/http/model/response.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUserLoginModel_0 extends _i1.Fake implements _i2.UserLoginModel {}

class _FakeHttpResponseModel_1 extends _i1.Fake
    implements _i3.HttpResponseModel {}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i4.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i6.UserModel?> getCachedLoggedUser() =>
      (super.noSuchMethod(Invocation.method(#getCachedLoggedUser, []),
              returnValue: Future<_i6.UserModel?>.value())
          as _i5.Future<_i6.UserModel?>);
  @override
  _i5.Future<_i6.UserModel?> isLogin() =>
      (super.noSuchMethod(Invocation.method(#isLogin, []),
              returnValue: Future<_i6.UserModel?>.value())
          as _i5.Future<_i6.UserModel?>);
  @override
  _i5.Future<_i4.LoginResult> login(
          {String? dealerCode,
          String? userUuid,
          String? pin,
          bool? validateOnly = false}) =>
      (super.noSuchMethod(
              Invocation.method(#login, [], {
                #dealerCode: dealerCode,
                #userUuid: userUuid,
                #pin: pin,
                #validateOnly: validateOnly
              }),
              returnValue:
                  Future<_i4.LoginResult>.value(_i4.LoginResult.success))
          as _i5.Future<_i4.LoginResult>);
  @override
  _i5.Future<void> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<_i7.DealerInfoModel?> getDealerInfo(String? dealerCode) =>
      (super.noSuchMethod(Invocation.method(#getDealerInfo, [dealerCode]),
              returnValue: Future<_i7.DealerInfoModel?>.value())
          as _i5.Future<_i7.DealerInfoModel?>);
  @override
  _i5.Future<List<_i2.UserLoginModel>> getUsersForDealerCode(
          String? dealerCode) =>
      (super.noSuchMethod(
          Invocation.method(#getUsersForDealerCode, [dealerCode]),
          returnValue: Future<List<_i2.UserLoginModel>>.value(
              <_i2.UserLoginModel>[])) as _i5.Future<List<_i2.UserLoginModel>>);
  @override
  String getStoredDealerCode() =>
      (super.noSuchMethod(Invocation.method(#getStoredDealerCode, []),
          returnValue: '') as String);
  @override
  _i5.Future<void> storeDealerCode(String? dealerCode) =>
      (super.noSuchMethod(Invocation.method(#storeDealerCode, [dealerCode]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> clearDealerCode() =>
      (super.noSuchMethod(Invocation.method(#clearDealerCode, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> deleteLastAccessDate(String? userUid) =>
      (super.noSuchMethod(Invocation.method(#deleteLastAccessDate, [userUid]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  DateTime? getLastAccessDate(String? userUid) =>
      (super.noSuchMethod(Invocation.method(#getLastAccessDate, [userUid]))
          as DateTime?);
  @override
  _i5.Future<_i2.UserLoginModel> create(
          {String? dealerCode,
          String? firstName,
          String? lastName,
          String? pin,
          String? title,
          String? publicDealerUuid,
          String? email,
          String? username,
          String? password,
          String? mobileNumber,
          String? integrationId}) =>
      (super.noSuchMethod(
              Invocation.method(#create, [], {
                #dealerCode: dealerCode,
                #firstName: firstName,
                #lastName: lastName,
                #pin: pin,
                #title: title,
                #publicDealerUuid: publicDealerUuid,
                #email: email,
                #username: username,
                #password: password,
                #mobileNumber: mobileNumber,
                #integrationId: integrationId
              }),
              returnValue:
                  Future<_i2.UserLoginModel>.value(_FakeUserLoginModel_0()))
          as _i5.Future<_i2.UserLoginModel>);
  @override
  _i5.Stream<List<_i8.DealerCodeAccessHistoryModel>>
      streamDealerCodesHistory() =>
          (super.noSuchMethod(Invocation.method(#streamDealerCodesHistory, []),
                  returnValue:
                      Stream<List<_i8.DealerCodeAccessHistoryModel>>.empty())
              as _i5.Stream<List<_i8.DealerCodeAccessHistoryModel>>);
  @override
  _i5.Future<List<_i8.DealerCodeAccessHistoryModel>> getDealerCodesHistory() =>
      (super.noSuchMethod(Invocation.method(#getDealerCodesHistory, []),
              returnValue: Future<List<_i8.DealerCodeAccessHistoryModel>>.value(
                  <_i8.DealerCodeAccessHistoryModel>[]))
          as _i5.Future<List<_i8.DealerCodeAccessHistoryModel>>);
  @override
  _i5.Future<void> validateUsernameEmail({String? email, String? username}) =>
      (super.noSuchMethod(
          Invocation.method(
              #validateUsernameEmail, [], {#email: email, #username: username}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<_i6.UserModel?> getMyProfile() =>
      (super.noSuchMethod(Invocation.method(#getMyProfile, []),
              returnValue: Future<_i6.UserModel?>.value())
          as _i5.Future<_i6.UserModel?>);
  @override
  _i5.Future<List<_i9.UserSettingsModel>> getUserSettings() =>
      (super.noSuchMethod(Invocation.method(#getUserSettings, []),
              returnValue: Future<List<_i9.UserSettingsModel>>.value(
                  <_i9.UserSettingsModel>[]))
          as _i5.Future<List<_i9.UserSettingsModel>>);
  @override
  _i5.Future<List<_i9.UserSettingsModel>?> getCachedUserSettings() =>
      (super.noSuchMethod(Invocation.method(#getCachedUserSettings, []),
              returnValue: Future<List<_i9.UserSettingsModel>?>.value())
          as _i5.Future<List<_i9.UserSettingsModel>?>);
}

/// A class which mocks [HttpService].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpService extends _i1.Mock implements _i10.HttpService {
  MockHttpService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.HttpResponseModel> get(Uri? uri,
          {Map<String, dynamic>? headers = const {},
          Map<String, dynamic>? params = const {}}) =>
      (super.noSuchMethod(
          Invocation.method(#get, [uri], {#headers: headers, #params: params}),
          returnValue: Future<_i3.HttpResponseModel>.value(
              _FakeHttpResponseModel_1())) as _i5
          .Future<_i3.HttpResponseModel>);
  @override
  _i5.Future<_i3.HttpResponseModel> put(Uri? uri,
          {Map<String, dynamic>? headers = const {},
          Map<String, dynamic>? params = const {},
          dynamic data}) =>
      (super.noSuchMethod(
          Invocation.method(
              #put, [uri], {#headers: headers, #params: params, #data: data}),
          returnValue: Future<_i3.HttpResponseModel>.value(
              _FakeHttpResponseModel_1())) as _i5
          .Future<_i3.HttpResponseModel>);
  @override
  _i5.Future<_i3.HttpResponseModel> post(Uri? uri,
          {Map<String, dynamic>? headers = const {},
          Map<String, dynamic>? params = const {},
          dynamic data}) =>
      (super.noSuchMethod(
          Invocation.method(
              #post, [uri], {#headers: headers, #params: params, #data: data}),
          returnValue: Future<_i3.HttpResponseModel>.value(
              _FakeHttpResponseModel_1())) as _i5
          .Future<_i3.HttpResponseModel>);
  @override
  _i5.Future<_i3.HttpResponseModel> delete(Uri? uri,
          {Map<String, dynamic>? headers = const {},
          Map<String, dynamic>? params = const {}}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #delete, [uri], {#headers: headers, #params: params}),
              returnValue: Future<_i3.HttpResponseModel>.value(
                  _FakeHttpResponseModel_1()))
          as _i5.Future<_i3.HttpResponseModel>);
}
