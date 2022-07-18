import 'package:truvideo_enterprise/model/phone_number.dart';
import 'package:truvideo_enterprise/model/phone_number_country.dart';

abstract class PhoneNumberService {
  Future<PhoneNumberModel> parse(String number, {String? isoCode});

  PhoneNumberCountryModel findCurrentCountry();

  PhoneNumberCountryModel findCountryByIsoCode(String isoCode);

  List<PhoneNumberCountryModel> getAllCountries();

  // String get defaultMask;
  //
  // String get defaultIsoCode;
  //
  // String get defaultCountryCode;
}
