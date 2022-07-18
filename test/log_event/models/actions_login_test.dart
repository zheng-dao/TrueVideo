import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/log_event/model/actions_login.dart';

void main() {
  group(
    'LogEventActionLogin',
    () {
      test(
        'accessBiometric',
        () {
          // Given
          const sut = LogEventActionLogin.accessBiometric;
          List resultExpected = [
            'event_login_biometric_access',
            0,
            'accessBiometric'
          ];

          // When, Then
          expect(sut.eventName, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.name, resultExpected[2]);
        },
      );

      test(
        'storeBiometric',
        () {
          // Given
          const sut = LogEventActionLogin.storeBiometric;
          List resultExpected = [
            'event_login_biometric_configure',
            1,
            'storeBiometric'
          ];

          // When, Then
          expect(sut.eventName, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.name, resultExpected[2]);
        },
      );

      test(
        'deleteBiometric',
        () {
          // Given
          const sut = LogEventActionLogin.deleteBiometric;
          List resultExpected = [
            'event_login_biometric_delete',
            2,
            'deleteBiometric'
          ];

          // When, Then
          expect(sut.eventName, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.name, resultExpected[2]);
        },
      );
    },
  );
}
