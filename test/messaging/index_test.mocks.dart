// Mocks generated by Mockito 5.1.0 from annotations
// in truvideo_enterprise/test/messaging/index_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:truvideo_enterprise/model/dealer_code_access_history.dart'
    as _i11;
import 'package:truvideo_enterprise/model/dealer_info.dart' as _i10;
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart'
    as _i4;
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart'
    as _i15;
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart'
    as _i14;
import 'package:truvideo_enterprise/model/user.dart' as _i9;
import 'package:truvideo_enterprise/model/user_login.dart' as _i3;
import 'package:truvideo_enterprise/model/user_settings.dart' as _i12;
import 'package:truvideo_enterprise/service/auth/_interface.dart' as _i8;
import 'package:truvideo_enterprise/service/http/_interface.dart' as _i7;
import 'package:truvideo_enterprise/service/http/model/response.dart' as _i2;
import 'package:truvideo_enterprise/service/local_db/_interface.dart' as _i5;
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart'
    as _i13;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeHttpResponseModel_0 extends _i1.Fake
    implements _i2.HttpResponseModel {}

class _FakeUserLoginModel_1 extends _i1.Fake implements _i3.UserLoginModel {}

class _FakeOfflineEnqueueItemModel_2 extends _i1.Fake
    implements _i4.OfflineEnqueueItemModel {}

/// A class which mocks [LocalDatabaseService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDatabaseService extends _i1.Mock
    implements _i5.LocalDatabaseService {
  MockLocalDatabaseService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<void> open(String? name) =>
      (super.noSuchMethod(Invocation.method(#open, [name]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> close(String? name) =>
      (super.noSuchMethod(Invocation.method(#close, [name]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> write(String? boxName, String? key, dynamic value) =>
      (super.noSuchMethod(Invocation.method(#write, [boxName, key, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<dynamic> read(String? boxName, String? key) =>
      (super.noSuchMethod(Invocation.method(#read, [boxName, key]),
          returnValue: Future<dynamic>.value()) as _i6.Future<dynamic>);
  @override
  _i6.Future<List<dynamic>> getAll(String? boxName) =>
      (super.noSuchMethod(Invocation.method(#getAll, [boxName]),
              returnValue: Future<List<dynamic>>.value(<dynamic>[]))
          as _i6.Future<List<dynamic>>);
  @override
  _i6.Future<List<String>> getAllKeys(String? boxName) =>
      (super.noSuchMethod(Invocation.method(#getAllKeys, [boxName]),
              returnValue: Future<List<String>>.value(<String>[]))
          as _i6.Future<List<String>>);
  @override
  _i6.Stream<List<dynamic>> streamAll(String? boxName) => (super.noSuchMethod(
      Invocation.method(#streamAll, [boxName]),
      returnValue: Stream<List<dynamic>>.empty()) as _i6.Stream<List<dynamic>>);
  @override
  _i6.Stream<dynamic> streamByKey(String? boxName, String? key) =>
      (super.noSuchMethod(Invocation.method(#streamByKey, [boxName, key]),
          returnValue: Stream<dynamic>.empty()) as _i6.Stream<dynamic>);
  @override
  _i6.Future<void> delete(String? boxName, String? key) =>
      (super.noSuchMethod(Invocation.method(#delete, [boxName, key]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteAll(String? boxName) =>
      (super.noSuchMethod(Invocation.method(#deleteAll, [boxName]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
}

/// A class which mocks [HttpService].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpService extends _i1.Mock implements _i7.HttpService {
  MockHttpService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.HttpResponseModel> get(Uri? uri,
          {Map<String, dynamic>? headers = const {},
          Map<String, dynamic>? params = const {}}) =>
      (super.noSuchMethod(
          Invocation.method(#get, [uri], {#headers: headers, #params: params}),
          returnValue: Future<_i2.HttpResponseModel>.value(
              _FakeHttpResponseModel_0())) as _i6
          .Future<_i2.HttpResponseModel>);
  @override
  _i6.Future<_i2.HttpResponseModel> put(Uri? uri,
          {Map<String, dynamic>? headers = const {},
          Map<String, dynamic>? params = const {},
          dynamic data}) =>
      (super.noSuchMethod(
          Invocation.method(
              #put, [uri], {#headers: headers, #params: params, #data: data}),
          returnValue: Future<_i2.HttpResponseModel>.value(
              _FakeHttpResponseModel_0())) as _i6
          .Future<_i2.HttpResponseModel>);
  @override
  _i6.Future<_i2.HttpResponseModel> post(Uri? uri,
          {Map<String, dynamic>? headers = const {},
          Map<String, dynamic>? params = const {},
          dynamic data}) =>
      (super.noSuchMethod(
          Invocation.method(
              #post, [uri], {#headers: headers, #params: params, #data: data}),
          returnValue: Future<_i2.HttpResponseModel>.value(
              _FakeHttpResponseModel_0())) as _i6
          .Future<_i2.HttpResponseModel>);
  @override
  _i6.Future<_i2.HttpResponseModel> delete(Uri? uri,
          {Map<String, dynamic>? headers = const {},
          Map<String, dynamic>? params = const {}}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #delete, [uri], {#headers: headers, #params: params}),
              returnValue: Future<_i2.HttpResponseModel>.value(
                  _FakeHttpResponseModel_0()))
          as _i6.Future<_i2.HttpResponseModel>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i8.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i9.UserModel?> getCachedLoggedUser() =>
      (super.noSuchMethod(Invocation.method(#getCachedLoggedUser, []),
              returnValue: Future<_i9.UserModel?>.value())
          as _i6.Future<_i9.UserModel?>);
  @override
  _i6.Future<_i9.UserModel?> isLogin() =>
      (super.noSuchMethod(Invocation.method(#isLogin, []),
              returnValue: Future<_i9.UserModel?>.value())
          as _i6.Future<_i9.UserModel?>);
  @override
  _i6.Future<_i8.LoginResult> login(
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
                  Future<_i8.LoginResult>.value(_i8.LoginResult.success))
          as _i6.Future<_i8.LoginResult>);
  @override
  _i6.Future<void> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<_i10.DealerInfoModel?> getDealerInfo(String? dealerCode) =>
      (super.noSuchMethod(Invocation.method(#getDealerInfo, [dealerCode]),
              returnValue: Future<_i10.DealerInfoModel?>.value())
          as _i6.Future<_i10.DealerInfoModel?>);
  @override
  _i6.Future<List<_i3.UserLoginModel>> getUsersForDealerCode(
          String? dealerCode) =>
      (super.noSuchMethod(
          Invocation.method(#getUsersForDealerCode, [dealerCode]),
          returnValue: Future<List<_i3.UserLoginModel>>.value(
              <_i3.UserLoginModel>[])) as _i6.Future<List<_i3.UserLoginModel>>);
  @override
  String getStoredDealerCode() =>
      (super.noSuchMethod(Invocation.method(#getStoredDealerCode, []),
          returnValue: '') as String);
  @override
  _i6.Future<void> storeDealerCode(String? dealerCode) =>
      (super.noSuchMethod(Invocation.method(#storeDealerCode, [dealerCode]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> clearDealerCode() =>
      (super.noSuchMethod(Invocation.method(#clearDealerCode, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteLastAccessDate(String? userUid) =>
      (super.noSuchMethod(Invocation.method(#deleteLastAccessDate, [userUid]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  DateTime? getLastAccessDate(String? userUid) =>
      (super.noSuchMethod(Invocation.method(#getLastAccessDate, [userUid]))
          as DateTime?);
  @override
  _i6.Future<_i3.UserLoginModel> create(
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
                  Future<_i3.UserLoginModel>.value(_FakeUserLoginModel_1()))
          as _i6.Future<_i3.UserLoginModel>);
  @override
  _i6.Stream<List<_i11.DealerCodeAccessHistoryModel>>
      streamDealerCodesHistory() =>
          (super.noSuchMethod(Invocation.method(#streamDealerCodesHistory, []),
                  returnValue:
                      Stream<List<_i11.DealerCodeAccessHistoryModel>>.empty())
              as _i6.Stream<List<_i11.DealerCodeAccessHistoryModel>>);
  @override
  _i6.Future<List<_i11.DealerCodeAccessHistoryModel>> getDealerCodesHistory() =>
      (super.noSuchMethod(Invocation.method(#getDealerCodesHistory, []),
          returnValue: Future<List<_i11.DealerCodeAccessHistoryModel>>.value(
              <_i11.DealerCodeAccessHistoryModel>[])) as _i6
          .Future<List<_i11.DealerCodeAccessHistoryModel>>);
  @override
  _i6.Future<void> validateUsernameEmail({String? email, String? username}) =>
      (super.noSuchMethod(
          Invocation.method(
              #validateUsernameEmail, [], {#email: email, #username: username}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<_i9.UserModel?> getMyProfile() =>
      (super.noSuchMethod(Invocation.method(#getMyProfile, []),
              returnValue: Future<_i9.UserModel?>.value())
          as _i6.Future<_i9.UserModel?>);
  @override
  _i6.Future<List<_i12.UserSettingsModel>> getUserSettings() =>
      (super.noSuchMethod(Invocation.method(#getUserSettings, []),
              returnValue: Future<List<_i12.UserSettingsModel>>.value(
                  <_i12.UserSettingsModel>[]))
          as _i6.Future<List<_i12.UserSettingsModel>>);
  @override
  _i6.Future<List<_i12.UserSettingsModel>?> getCachedUserSettings() =>
      (super.noSuchMethod(Invocation.method(#getCachedUserSettings, []),
              returnValue: Future<List<_i12.UserSettingsModel>?>.value())
          as _i6.Future<List<_i12.UserSettingsModel>?>);
}

/// A class which mocks [OfflineEnqueueService].
///
/// See the documentation for Mockito's code generation for more information.
class MockOfflineEnqueueService extends _i1.Mock
    implements _i13.OfflineEnqueueService {
  MockOfflineEnqueueService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<void> startService() =>
      (super.noSuchMethod(Invocation.method(#startService, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<_i4.OfflineEnqueueItemModel?> getByUID(String? uid) =>
      (super.noSuchMethod(Invocation.method(#getByUID, [uid]),
              returnValue: Future<_i4.OfflineEnqueueItemModel?>.value())
          as _i6.Future<_i4.OfflineEnqueueItemModel?>);
  @override
  _i6.Future<_i4.OfflineEnqueueItemModel> enqueue(
          _i4.OfflineEnqueueItemModel? model) =>
      (super.noSuchMethod(Invocation.method(#enqueue, [model]),
              returnValue: Future<_i4.OfflineEnqueueItemModel>.value(
                  _FakeOfflineEnqueueItemModel_2()))
          as _i6.Future<_i4.OfflineEnqueueItemModel>);
  @override
  _i6.Future<void> update(_i4.OfflineEnqueueItemModel? model) =>
      (super.noSuchMethod(Invocation.method(#update, [model]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> delete(String? uid) =>
      (super.noSuchMethod(Invocation.method(#delete, [uid]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> retry(String? uid) =>
      (super.noSuchMethod(Invocation.method(#retry, [uid]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Stream<_i4.OfflineEnqueueItemModel?> streamByUID(String? uid) =>
      (super.noSuchMethod(Invocation.method(#streamByUID, [uid]),
              returnValue: Stream<_i4.OfflineEnqueueItemModel?>.empty())
          as _i6.Stream<_i4.OfflineEnqueueItemModel?>);
  @override
  _i6.Stream<List<_i4.OfflineEnqueueItemModel>> stream(
          {List<_i14.OfflineEnqueueItemType>? type = const [],
          List<_i15.OfflineEnqueueItemStatus>? status = const []}) =>
      (super.noSuchMethod(
              Invocation.method(#stream, [], {#type: type, #status: status}),
              returnValue: Stream<List<_i4.OfflineEnqueueItemModel>>.empty())
          as _i6.Stream<List<_i4.OfflineEnqueueItemModel>>);
  @override
  _i6.Future<List<_i4.OfflineEnqueueItemModel>> getAll(
          {List<_i14.OfflineEnqueueItemType>? type = const [],
          List<_i15.OfflineEnqueueItemStatus>? status = const []}) =>
      (super.noSuchMethod(
              Invocation.method(#getAll, [], {#type: type, #status: status}),
              returnValue: Future<List<_i4.OfflineEnqueueItemModel>>.value(
                  <_i4.OfflineEnqueueItemModel>[]))
          as _i6.Future<List<_i4.OfflineEnqueueItemModel>>);
}
