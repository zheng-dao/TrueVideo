import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/phone_number.dart';
import 'package:truvideo_enterprise/model/phone_number_country.dart';
import 'package:truvideo_enterprise/service/device/index.dart';
import 'package:truvideo_enterprise/service/phone_number/_interface.dart';

class PhoneNumberServiceImpl extends PhoneNumberService {
  final String? _defaultCountryCode;
  final CountryManager _countryManager;
  final FlutterLibphonenumber _flutterLibphonenumber;
  final PlatformInfo _platformInfo;

  PhoneNumberServiceImpl({
    CountryManager? countryManager,
    String? defaultCountryCode,
    FlutterLibphonenumber? flutterLibphonenumber,
    PlatformInfo? platformInfo,
  })  : _countryManager = countryManager ?? CountryManager(),
        _defaultCountryCode = defaultCountryCode ?? WidgetsBinding.instance.window.locale.countryCode,
        _flutterLibphonenumber = flutterLibphonenumber ?? FlutterLibphonenumber(),
        _platformInfo = platformInfo ?? PlatformInfo();

  @override
  PhoneNumberCountryModel findCountryByIsoCode(String isoCode) {
    if (_platformInfo.isWeb) {
      return _parseCountry(const CountryWithPhoneCode.us());
    }

    final countries = _countryManager.countries.where((c) => c.countryCode == isoCode).toList();
    if (countries.isEmpty) {
      return _parseCountry(const CountryWithPhoneCode.us());
    }
    return _parseCountry(countries[0]);
  }

  @override
  Future<PhoneNumberModel> parse(String number, {String? isoCode}) async {
    if (_platformInfo.isWeb) {
      final c = _parseCountry(const CountryWithPhoneCode.us());
      return PhoneNumberModel(
        mobileNumber: true,
        number: number,
        country: c,
        e164: number,
        formattedInternationalNumber: number,
        formattedNationalNumber: number,
      );
    }

    if (number.trim().isEmpty) throw CustomException();

    final parsed = await _flutterLibphonenumber.parse(number, region: isoCode);
    final parsedDialCode = parsed["country_code"];
    final countries = _countryManager.countries.where((c) => c.phoneCode == parsedDialCode).toList();
    if (countries.isEmpty) throw CustomException();

    CountryWithPhoneCode country;
    if (isoCode == null) {
      country = _findCountryByDialCode(parsedDialCode);
    } else {
      country = countries.firstWhere((c) => c.countryCode == isoCode, orElse: () => _findCountryByDialCode(parsedDialCode));
    }

    log(parsed.toString());

    return PhoneNumberModel(
      country: _parseCountry(country),
      e164: parsed["e164"],
      formattedInternationalNumber: parsed["international"],
      formattedNationalNumber: parsed["national"],
      number: number,
      mobileNumber: parsed["type"] != "fixedLine",
    );
  }

  CountryWithPhoneCode _findCountryByDialCode(String dialCode) {
    final countries = _countryManager.countries.where((c) => c.phoneCode == dialCode).toList();
    if (countries.isEmpty) return const CountryWithPhoneCode.us();
    final c = countries[0];
    if (c.phoneCode == "1") return const CountryWithPhoneCode.us();
    return c;
  }

  PhoneNumberCountryModel _parseCountry(CountryWithPhoneCode country) => PhoneNumberCountryModel(
        countryCode: country.phoneCode,
        isoCode: country.countryCode,
        internationalInlineMask: country.phoneMaskFixedLineInternational,
        internationalMobileMask: country.phoneMaskMobileInternational,
        nationalInlineMask: country.phoneMaskFixedLineNational,
        nationalMobileMask: country.phoneMaskMobileNational,
        name: country.countryName ?? "",
      );

  @override
  List<PhoneNumberCountryModel> getAllCountries() {
    if (_platformInfo.isWeb) return [];

    final items = _countryManager.countries.map((e) => _parseCountry(e)).toList();
    items.sort((a, b) => a.name.toUpperCase().trim().compareTo(b.name.toUpperCase().trim()));
    return items;
  }

  @override
  PhoneNumberCountryModel findCurrentCountry() {
    if (_platformInfo.isWeb) {
      return _parseCountry(const CountryWithPhoneCode.us());
    }

    if (_defaultCountryCode == null) {
      return _parseCountry(const CountryWithPhoneCode.us());
    }
    return _parseCountry(_findCountryByDialCode(_defaultCountryCode!));
  }
}
