import 'dart:ui';

import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/date/index.dart';

void main() {
  initializeDateFormatting();
  group(
    'dateTests',
    () {
      test(
        'Should be initialized',
        () {
          // Given
          const String locale = 'locale';
          final sut = DateServiceImpl(locale: locale);

          // When, Then
          expect(sut, isA<DateServiceImpl>());
        },
      );

      group(
        '.formatDate()',
        () {
          test(
            'Should return yMMMMd dateFormat',
            () {
              // Given
              final sut = DateServiceImpl(locale: window.locale.languageCode);
              final dateTime = DateTime(2022);

              // When
              final date = sut.formatDate(dateTime);

              // Then
              expect(date, equals('Jan 1, 2022'));
            },
          );
        },
      );

      group(
        '.formatDateTime()',
        () {
          test(
            'Should return yMMMMd hh:mm dateFormat ',
            () {
              // Given
              final sut = DateServiceImpl(locale: window.locale.languageCode);
              final dateTime = DateTime(2022);

              // When
              final date = sut.formatDateTime(dateTime);

              // Then
              expect(date, equals('Jan 1, 2022 00:00'));
            },
          );
        },
      );

      group(
        '.timeAgo()',
        () {
          test(
            'Should return in format String',
            () {
              // Given
              final sut = DateServiceImpl(locale: window.locale.languageCode);
              final dateTime = DateTime(2000);

              // When
              final date = sut.timeAgo(dateTime);

              // Then
              expect(date, equals('22 years ago'));
            },
          );
        },
      );

      group(
        'duration()',
        () {
          test(
            'should return hh:mm:ss duration format',
            () {
              // Given
              final sut = DateServiceImpl(locale: window.locale.languageCode);
              const time = Duration(hours: 12,minutes: 50,seconds: 10);

              // When
              final duration = sut.duration(time);

              // Then
              expect(duration, equals('12:50:10'));
            },
          );
        },
      );
    },
  );
}
