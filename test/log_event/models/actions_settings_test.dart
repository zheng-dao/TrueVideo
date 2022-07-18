import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/log_event/model/actions_settings.dart';

void main() {
  
  group(
    'LogEventActionSettings',
    () {
      test(
        'changeCameraQuality',
        () {
          // Given
          const sut = LogEventActionSettings.changeCameraQuality;
          List resultExpected = [
            'changeCameraQuality',
            0,
            'event_setting_change_camera_quality',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

       test(
        'changeCameraQualityError',
        () {
          // Given
          const sut = LogEventActionSettings.changeCameraQualityError;
          List resultExpected = [
            'changeCameraQualityError',
            1,
            'event_setting_change_camera_quality_error',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'changeCameraQualitySuccess',
        () {
          // Given
          const sut = LogEventActionSettings.changeCameraQualitySuccess;
          List resultExpected = [
            'changeCameraQualitySuccess',
            2,
            'event_setting_change_camera_quality_success',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );
    },
  );
}
