import 'package:flutter/widgets.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/phone_number.dart';
import 'package:truvideo_enterprise/model/phone_number_country.dart';
import 'package:truvideo_enterprise/service/device/index.dart';
import 'package:truvideo_enterprise/service/phone_number/index.dart';

import 'phone_number_test.mocks.dart';

@GenerateMocks([
  CountryManager,
  FlutterLibphonenumber,
])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group(
    'PhoneNumberServiceImpltests',
    () {
      late MockCountryManager countryManager;
      late MockFlutterLibphonenumber flutterLibphonenumber;

      setUp(() {
        countryManager = MockCountryManager();
        flutterLibphonenumber = MockFlutterLibphonenumber();
      });
      test(
        'Should be initialized',
        () {
          // Given
          final sut = PhoneNumberServiceImpl(
              countryManager: countryManager,
              defaultCountryCode: 'country code');

          // When, Then
          expect(sut, isA<PhoneNumberServiceImpl>());
        },
      );

      group(
        '.findCountryByIsoCode()',
        () {
          test(
            'Should return a PhoneNumberCountryModel if is web',
            () {
              // Given
              final platformInfo = PlatformInfo(isWeb: true);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );
              const phoneNumberCountry = PhoneNumberCountryModel(
                isoCode: 'US',
                countryCode: '1',
                internationalMobileMask: '+0 000-000-0000',
                nationalMobileMask: '(000) 000-0000',
                internationalInlineMask: '+0 000-000-0000',
                nationalInlineMask: '(000) 000-0000',
                name: 'United States',
              );

              // When
              final result = sut.findCountryByIsoCode('isoCode');

              // Then
              expect(result, equals(phoneNumberCountry));
            },
          );

          test(
            'Should return a PhoneNumberCountryModel if countries is empty',
            () {
              // Given
              final platformInfo = PlatformInfo(isWeb: false);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );
              const phoneNumberCountry = PhoneNumberCountryModel(
                isoCode: 'US',
                countryCode: '1',
                internationalMobileMask: '+0 000-000-0000',
                nationalMobileMask: '(000) 000-0000',
                internationalInlineMask: '+0 000-000-0000',
                nationalInlineMask: '(000) 000-0000',
                name: 'United States',
              );

              // When
              when(countryManager.countries).thenReturn([]);

              final result = sut.findCountryByIsoCode('isoCode');

              // Then
              expect(result, equals(phoneNumberCountry));
            },
          );

          test(
            'Should return a PhoneNumberCountryModel if countries is not empty',
            () {
              // Given
              final platformInfo = PlatformInfo(isWeb: false);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );
              final countryWithPhoneCode = CountryWithPhoneCode(
                phoneCode: 'phoneCode',
                countryCode: 'isoCode',
                exampleNumberMobileNational: 'exampleNumberMobileNational',
                exampleNumberFixedLineNational:
                    'exampleNumberFixedLineNational',
                phoneMaskMobileNational: 'phoneMaskMobileNational',
                phoneMaskFixedLineNational: 'phoneMaskFixedLineNational',
                exampleNumberMobileInternational:
                    'exampleNumberMobileInternational',
                exampleNumberFixedLineInternational:
                    'exampleNumberFixedLineInternational',
                phoneMaskMobileInternational: 'phoneMaskMobileInternational',
                phoneMaskFixedLineInternational:
                    'phoneMaskFixedLineInternational',
                countryName: 'countryName',
              );

              const phoneNumberCountry = PhoneNumberCountryModel(
                isoCode: 'isoCode',
                countryCode: 'phoneCode',
                internationalMobileMask: 'phoneMaskMobileInternational',
                nationalMobileMask: 'phoneMaskMobileNational',
                internationalInlineMask: 'phoneMaskFixedLineInternational',
                nationalInlineMask: 'phoneMaskFixedLineNational',
                name: 'countryName',
              );

              // When
              when(countryManager.countries).thenReturn([countryWithPhoneCode]);

              final result = sut.findCountryByIsoCode('isoCode');

              // Then
              expect(result, equals(phoneNumberCountry));
            },
          );
        },
      );

      group(
        '.parse()',
        () {
          test(
            'Should return a PhoneNumberModel if id web',
            () async {
              // Given
              final platformInfo = PlatformInfo(isWeb: true);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );
              const phoneNumber = PhoneNumberModel(
                country: PhoneNumberCountryModel(
                  isoCode: 'US',
                  countryCode: '1',
                  internationalMobileMask: '+0 000-000-0000',
                  nationalMobileMask: '(000) 000-0000',
                  internationalInlineMask: '+0 000-000-0000',
                  nationalInlineMask: '(000) 000-0000',
                  name: 'United States',
                ),
                e164: '+0 000-000-0000',
                formattedInternationalNumber: '+0 000-000-0000',
                formattedNationalNumber: '+0 000-000-0000',
                number: '+0 000-000-0000',
                mobileNumber: true,
              );

              // When
              final result = await sut.parse('+0 000-000-0000');

              // Then
              expect(result, equals(phoneNumber));
            },
          );

          test(
            'Should throw exception if number is empty',
            () async {
              // Given
              final platformInfo = PlatformInfo(isWeb: false);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );

              // When, Then
              expect(
                  () async => sut.parse(''), throwsA(isA<CustomException>()));
            },
          );

          test(
            'Should throw exception if number have a blank space',
            () async {
              // Given
              final platformInfo = PlatformInfo(isWeb: false);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );

              // When, Then
              expect(
                () async => sut.parse(' '),
                throwsA(isA<CustomException>()),
              );
            },
          );

          test(
            'Should throw exception if countries is empty',
            () async {
              // Given
              final platformInfo = PlatformInfo(isWeb: false);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                flutterLibphonenumber: flutterLibphonenumber,
                platformInfo: platformInfo,
              );

              // When
              when(flutterLibphonenumber.parse(
                any,
                region: anyNamed('region'),
              )).thenAnswer((_) async => {
                    'country_code': 'phoneCode',
                    'e164': '+4930123123123',
                    'national': '030 123 123 123',
                    'type': 'mobile',
                    'international': '+49 30 123 123 123',
                    'national_number': '030123123123',
                  });

              when(countryManager.countries).thenReturn([]);

              // Then
              expect(
                () async => sut.parse('+0 000-000-0000'),
                throwsA(isA<CustomException>()),
              );
            },
          );

          test(
            'Should return a PhoneNumberModel if countries is not empty',
            () async {
              // Given
              final platformInfo = PlatformInfo(isWeb: false);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                flutterLibphonenumber: flutterLibphonenumber,
                platformInfo: platformInfo,
              );
              final countryWithPhoneCode = CountryWithPhoneCode(
                phoneCode: 'phoneCode',
                countryCode: 'isoCode',
                exampleNumberMobileNational: 'exampleNumberMobileNational',
                exampleNumberFixedLineNational:
                    'exampleNumberFixedLineNational',
                phoneMaskMobileNational: 'phoneMaskMobileNational',
                phoneMaskFixedLineNational: 'phoneMaskFixedLineNational',
                exampleNumberMobileInternational:
                    'exampleNumberMobileInternational',
                exampleNumberFixedLineInternational:
                    'exampleNumberFixedLineInternational',
                phoneMaskMobileInternational: 'phoneMaskMobileInternational',
                phoneMaskFixedLineInternational:
                    'phoneMaskFixedLineInternational',
                countryName: 'countryName',
              );
              const expectedData = PhoneNumberModel(
                country: PhoneNumberCountryModel(
                  isoCode: 'isoCode',
                  countryCode: 'phoneCode',
                  internationalMobileMask: 'phoneMaskMobileInternational',
                  nationalMobileMask: 'phoneMaskMobileNational',
                  internationalInlineMask: 'phoneMaskFixedLineInternational',
                  nationalInlineMask: 'phoneMaskFixedLineNational',
                  name: 'countryName',
                ),
                e164: '+4930123123123',
                formattedNationalNumber: '030 123 123 123',
                formattedInternationalNumber: '+49 30 123 123 123',
                number: '+0 000-000-0000',
                mobileNumber: true,
              );

              // When
              when(flutterLibphonenumber.parse(
                any,
                region: anyNamed('region'),
              )).thenAnswer((_) async => {
                    'country_code': 'phoneCode',
                    'e164': '+4930123123123',
                    'national': '030 123 123 123',
                    'type': 'mobile',
                    'international': '+49 30 123 123 123',
                    'national_number': '030123123123',
                  });

              when(countryManager.countries).thenReturn([countryWithPhoneCode]);

              final result =
                  await sut.parse('+0 000-000-0000', isoCode: 'isoCode');

              // Then
              expect(result, equals(expectedData));
            },
          );
        },
      );

      group(
        '.getAllCountries()',
        () {
          test(
            'Should retrun a list empty if is web',
            () {
              // Given
              final platformInfo = PlatformInfo(isWeb: true);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );

              // When
              final result = sut.getAllCountries();

              // Then
              expect(result, equals([]));
            },
          );

          test(
            'Should retrun a list of PhoneNumberCountryModel if is not web',
            () {
              // Given
              final platformInfo = PlatformInfo(isWeb: false);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );
              final countryWithPhoneCode = [
                CountryWithPhoneCode(
                  phoneCode: 'phoneCode',
                  countryCode: 'isoCode',
                  exampleNumberMobileNational: 'exampleNumberMobileNational',
                  exampleNumberFixedLineNational:
                      'exampleNumberFixedLineNational',
                  phoneMaskMobileNational: 'phoneMaskMobileNational',
                  phoneMaskFixedLineNational: 'phoneMaskFixedLineNational',
                  exampleNumberMobileInternational:
                      'exampleNumberMobileInternational',
                  exampleNumberFixedLineInternational:
                      'exampleNumberFixedLineInternational',
                  phoneMaskMobileInternational: 'phoneMaskMobileInternational',
                  phoneMaskFixedLineInternational:
                      'phoneMaskFixedLineInternational',
                  countryName: 'Peru',
                ),
                CountryWithPhoneCode(
                  phoneCode: 'phoneCode',
                  countryCode: 'isoCode',
                  exampleNumberMobileNational: 'exampleNumberMobileNational',
                  exampleNumberFixedLineNational:
                      'exampleNumberFixedLineNational',
                  phoneMaskMobileNational: 'phoneMaskMobileNational',
                  phoneMaskFixedLineNational: 'phoneMaskFixedLineNational',
                  exampleNumberMobileInternational:
                      'exampleNumberMobileInternational',
                  exampleNumberFixedLineInternational:
                      'exampleNumberFixedLineInternational',
                  phoneMaskMobileInternational: 'phoneMaskMobileInternational',
                  phoneMaskFixedLineInternational:
                      'phoneMaskFixedLineInternational',
                  countryName: 'Argentina',
                ),
              ];
              const phoneNumber = [
                PhoneNumberCountryModel(
                  isoCode: 'isoCode',
                  countryCode: 'phoneCode',
                  internationalMobileMask: 'phoneMaskMobileInternational',
                  nationalMobileMask: 'phoneMaskMobileNational',
                  internationalInlineMask: 'phoneMaskFixedLineInternational',
                  nationalInlineMask: 'phoneMaskFixedLineNational',
                  name: 'Argentina',
                ),
                PhoneNumberCountryModel(
                  isoCode: 'isoCode',
                  countryCode: 'phoneCode',
                  internationalMobileMask: 'phoneMaskMobileInternational',
                  nationalMobileMask: 'phoneMaskMobileNational',
                  internationalInlineMask: 'phoneMaskFixedLineInternational',
                  nationalInlineMask: 'phoneMaskFixedLineNational',
                  name: 'Peru',
                ),
              ];

              // When
              when(countryManager.countries).thenReturn(countryWithPhoneCode);
              final result = sut.getAllCountries();

              // Then

              expect(result, equals(phoneNumber));
            },
          );
        },
      );

      group(
        '.findCurrentCountry()',
        () {
          test(
            'Should retrun a PhoneNumberCountryModel if is web',
            () {
              // Given
              final platformInfo = PlatformInfo(isWeb: true);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );
              const phoneNumber = PhoneNumberCountryModel(
                isoCode: 'US',
                countryCode: '1',
                internationalMobileMask: '+0 000-000-0000',
                nationalMobileMask: '(000) 000-0000',
                internationalInlineMask: '+0 000-000-0000',
                nationalInlineMask: '(000) 000-0000',
                name: 'United States',
              );

              // When
              final result = sut.findCurrentCountry();

              // Then
              expect(result, equals(phoneNumber));
            },
          );

          test(
            'Should retrun a PhoneNumberCountryModel when country code is null',
            () {
              // Given
              final platformInfo = PlatformInfo(isWeb: false);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: null,
                platformInfo: platformInfo,
              );
              const phoneNumber = PhoneNumberCountryModel(
                isoCode: 'US',
                countryCode: '1',
                internationalMobileMask: '+0 000-000-0000',
                nationalMobileMask: '(000) 000-0000',
                internationalInlineMask: '+0 000-000-0000',
                nationalInlineMask: '(000) 000-0000',
                name: 'United States',
              );

              // When
              when(countryManager.countries).thenReturn([]);

              final result = sut.findCurrentCountry();

              // Then
              expect(result, equals(phoneNumber));
            },
          );

          test(
            'Should retrun a PhoneNumberCountryModel when have a country code',
            () {
              // Given
              final platformInfo = PlatformInfo(isWeb: false);
              final sut = PhoneNumberServiceImpl(
                countryManager: countryManager,
                defaultCountryCode: 'country code',
                platformInfo: platformInfo,
              );
              const phoneNumber = PhoneNumberCountryModel(
                isoCode: 'US',
                countryCode: '1',
                internationalMobileMask: '+0 000-000-0000',
                nationalMobileMask: '(000) 000-0000',
                internationalInlineMask: '+0 000-000-0000',
                nationalInlineMask: '(000) 000-0000',
                name: 'United States',
              );

              // When
              when(countryManager.countries).thenReturn([]);

              final result = sut.findCurrentCountry();

              // Then
              expect(result, equals(phoneNumber));
            },
          );
        },
      );
    },
  );
}
