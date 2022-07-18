import 'dart:async';

import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:truvideo_enterprise/service/local/index.dart';

import 'local_test.mocks.dart';

bool defaultValue() => false;
bool getValue() => true;

String defaultStringValue() => 'foo';
String getStringValue() => 'bar';

@GenerateMocks(
  [
    StreamingSharedPreferences,
  ],
  customMocks: [
    MockSpec<Preference>(
      fallbackGenerators: {
        #defaultValue: defaultValue,
        #getValue: getValue,
      },
    ),
    MockSpec<Preference>(
      as: #MockStringPreference,
      fallbackGenerators: {
        #defaultValue: defaultStringValue,
        #getValue: getStringValue
      },
    ),
  ],
)
void main() {
  group(
    'LocalServiceImplTests',
    () {
      late MockStreamingSharedPreferences sharedPreferences;

      setUp(() {
        sharedPreferences = MockStreamingSharedPreferences();
      });

      test(
        'Should be initialized',
        () {
          // Given
          final sut = LocalServiceImpl(
            sharedPreferences: sharedPreferences,
          );

          // When, Then
          expect(sut, isA<LocalServiceImpl>());
        },
      );

      group(
        '.delete()',
        () {
          test(
            'Check that remove is called',
            () async {
              // Given
              final sut = LocalServiceImpl(
                sharedPreferences: sharedPreferences,
              );

              // When
              when(
                sharedPreferences.remove(any),
              ).thenAnswer((_) async => true);

              await sut.delete('key');

              // Then
              verify(sharedPreferences.remove(any)).called(1);
            },
          );
        },
      );

      group(
        '.readBool()',
        () {
          test(
            'Should return a bool',
            () {
              // Given
              final preference = MockPreference<bool>();
              final sut = LocalServiceImpl(
                sharedPreferences: sharedPreferences,
              );

              // When
              when(sharedPreferences.getBool(
                any,
                defaultValue: anyNamed('defaultValue'),
              )).thenAnswer((_) => preference);

              when(preference.getValue()).thenAnswer((_) => false);

              sut.readBool('foo', defaultValue: true);

              final verifyOrders = verifyInOrder([
                sharedPreferences.getBool(
                  captureAny,
                  defaultValue: captureAnyNamed('defaultValue'),
                ),
                preference.getValue(),
              ]).captured;

              // Then
              expect(verifyOrders[0][1], equals(true));
            },
          );
        },
      );

      group(
        '.storeBool()',
        () {
          test(
            'Check that setBool is called',
            () async {
              // Given
              final sut = LocalServiceImpl(
                sharedPreferences: sharedPreferences,
              );

              // When
              when(
                sharedPreferences.setBool(any, any),
              ).thenAnswer((_) async => true);

              await sut.storeBool('key', true);

              // Then
              verify(sharedPreferences.setBool(
                any,
                any,
              )).called(1);
            },
          );
        },
      );

      group(
        '.readString()',
        () {
          test(
            'Should return a String',
            () {
              // Given
              final preference = MockStringPreference<String>();

              final sut = LocalServiceImpl(
                sharedPreferences: sharedPreferences,
              );

              // When
              when(sharedPreferences.getString(
                any,
                defaultValue: anyNamed('defaultValue'),
              )).thenAnswer((_) => preference);

              when(preference.getValue()).thenAnswer((_) => 'foo');

              sut.readString('bar', defaultValue: 'value');

              final verifyOrders = verifyInOrder([
                sharedPreferences.getString(
                  captureAny,
                  defaultValue: captureAnyNamed('defaultValue'),
                ),
                preference.getValue(),
              ]).captured;

              // Then
              expect(
                verifyOrders[0],
                equals(['bar', 'value']),
              );
            },
          );
        },
      );

      group(
        '.storeString()',
        () {
          test(
            'Check that setString is called',
            () async {
              // Given
              final sut = LocalServiceImpl(
                sharedPreferences: sharedPreferences,
              );

              // When
              when(
                sharedPreferences.setString(any, any),
              ).thenAnswer((_) async => true);

              await sut.storeString('key', 'value');

              // Then
              verify(sharedPreferences.setString(
                any,
                any,
              )).called(1);
            },
          );
        },
      );

      group(
        '.streamBool()',
        () {
          test(
            'Should return a Bool when accesing the value',
            () async {
              // Given
              final results = [];
              final preference = MockPreference<bool>();
              final streamController = StreamController<bool>();
              final sut = LocalServiceImpl(
                sharedPreferences: sharedPreferences,
              );

              // When
              when(sharedPreferences.getBool(any, defaultValue: true))
                  .thenAnswer((_) => preference);

              when(
                preference.asBroadcastStream(),
              ).thenAnswer((_) => streamController.stream);

              sut.streamBool('foo', defaultValue: true).listen((event) {
                results.add(event);
              });

              streamController.add(true);
              streamController.add(false);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, equals([true, false]));
            },
          );
        },
      );

      group(
        '.streamString()',
        () {
          test(
            'Should return a String when accesing the value',
            () async {
              // Given
              final results = [];
              final streamController = StreamController<String>();
              final preference = MockStringPreference<String>();
              final sut = LocalServiceImpl(
                sharedPreferences: sharedPreferences,
              );

              // When
              when(
                sharedPreferences.getString(
                  any,
                  defaultValue: anyNamed('defaultValue'),
                ),
              ).thenAnswer((_) => preference);

              when(
                preference.asBroadcastStream(),
              ).thenAnswer((_) => streamController.stream);

              sut.streamString('bar').listen((event) {
                results.add(event);
              });

              streamController.add('foo');
              streamController.add('bar');

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, equals(['foo', 'bar']));
            },
          );
        },
      );
    },
  );
}
