


import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/service/settings/camera_quality.dart';

main() {
   group(
    'SettingsFontSizeExtension',
    () {
      test('CameraQuality.low', () {
        // Given
        const sut = CameraQuality.low;

        // When Then

        expect(sut.icon, MdiIcons.qualityLow);
      });

      test('CameraQuality.medium', () {
        // Given
        const sut = CameraQuality.medium;

        // When Then

        expect(sut.icon, MdiIcons.qualityMedium);
      });

      test('CameraQuality.high', () {
        // Given
        const sut = CameraQuality.high;

        // When Then

        expect(sut.icon, MdiIcons.qualityHigh);
      });
    },
  );
  
}