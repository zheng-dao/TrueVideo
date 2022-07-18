// Mocks generated by Mockito 5.1.0 from annotations
// in truvideo_enterprise/test/phone_number/phone_number_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:flutter_libphonenumber/flutter_libphonenumber.dart' as _i2;
import 'package:flutter_libphonenumber/src/phone_number_type.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [CountryManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockCountryManager extends _i1.Mock implements _i2.CountryManager {
  MockCountryManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i2.CountryWithPhoneCode> get countries =>
      (super.noSuchMethod(Invocation.getter(#countries),
              returnValue: <_i2.CountryWithPhoneCode>[])
          as List<_i2.CountryWithPhoneCode>);
  @override
  _i3.Future<void> loadCountries(
          {Map<String, _i2.CountryWithPhoneCode>? overrides = const {}}) =>
      (super.noSuchMethod(
          Invocation.method(#loadCountries, [], {#overrides: overrides}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}

/// A class which mocks [FlutterLibphonenumber].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterLibphonenumber extends _i1.Mock
    implements _i2.FlutterLibphonenumber {
  MockFlutterLibphonenumber() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> init(
          {Map<String, _i2.CountryWithPhoneCode>? overrides = const {}}) =>
      (super.noSuchMethod(Invocation.method(#init, [], {#overrides: overrides}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<Map<String, _i2.CountryWithPhoneCode>> getAllSupportedRegions() =>
      (super.noSuchMethod(Invocation.method(#getAllSupportedRegions, []),
              returnValue: Future<Map<String, _i2.CountryWithPhoneCode>>.value(
                  <String, _i2.CountryWithPhoneCode>{}))
          as _i3.Future<Map<String, _i2.CountryWithPhoneCode>>);
  @override
  _i3.Future<Map<String, String>> format(String? phone, String? region) =>
      (super.noSuchMethod(Invocation.method(#format, [phone, region]),
              returnValue:
                  Future<Map<String, String>>.value(<String, String>{}))
          as _i3.Future<Map<String, String>>);
  @override
  _i3.Future<Map<String, dynamic>> parse(String? phone, {String? region}) =>
      (super.noSuchMethod(Invocation.method(#parse, [phone], {#region: region}),
              returnValue:
                  Future<Map<String, dynamic>>.value(<String, dynamic>{}))
          as _i3.Future<Map<String, dynamic>>);
  @override
  String formatNumberSync(String? number,
          {_i2.CountryWithPhoneCode? country,
          _i4.PhoneNumberType? phoneNumberType = _i4.PhoneNumberType.mobile,
          _i2.PhoneNumberFormat? phoneNumberFormat =
              _i2.PhoneNumberFormat.international,
          bool? removeCountryCodeFromResult = false,
          bool? inputContainsCountryCode = true}) =>
      (super.noSuchMethod(
          Invocation.method(#formatNumberSync, [
            number
          ], {
            #country: country,
            #phoneNumberType: phoneNumberType,
            #phoneNumberFormat: phoneNumberFormat,
            #removeCountryCodeFromResult: removeCountryCodeFromResult,
            #inputContainsCountryCode: inputContainsCountryCode
          }),
          returnValue: '') as String);
  @override
  _i3.Future<_i2.FormatPhoneResult?> getFormattedParseResult(
          String? phoneNumber, _i2.CountryWithPhoneCode? country,
          {_i4.PhoneNumberType? phoneNumberType = _i4.PhoneNumberType.mobile,
          _i2.PhoneNumberFormat? phoneNumberFormat =
              _i2.PhoneNumberFormat.international}) =>
      (super.noSuchMethod(
              Invocation.method(#getFormattedParseResult, [
                phoneNumber,
                country
              ], {
                #phoneNumberType: phoneNumberType,
                #phoneNumberFormat: phoneNumberFormat
              }),
              returnValue: Future<_i2.FormatPhoneResult?>.value())
          as _i3.Future<_i2.FormatPhoneResult?>);
}
