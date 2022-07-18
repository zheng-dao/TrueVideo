import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/log_event/model/level.dart';
 
void main() {
  group(
    'LogEventLevel',
    () {
      test(
        'info',
        () {
          // Given
          const sut = LogEventLevel.info;
          List resultExpected = [
            'info',
            0,
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
        },
      );

      test(
        'warning',
        () {
          // Given
          const sut = LogEventLevel.warning;
          List resultExpected = [
            'warning',
            1,
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
        },
      );

      test(
        'error',
        () {
          // Given
          const sut = LogEventLevel.error;
          List resultExpected = [
            'error',
            2,
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
        },
      );

      test(
        'success',
        () {
          // Given
          const sut = LogEventLevel.success;
          List resultExpected = [
            'success',
            3,
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
        },
      );
    },
  );
}
