import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/settings/font_size.dart';

main() {
  group(
    'SettingsFontSizeExtension',
    () {
      test('SettingsFontSize.big', () {
        // Given
        const sut = SettingsFontSize.big;

        // When Then

        expect(sut.scale, 1.5);
      });

      test('SettingsFontSize.medium', () {
        // Given
        const sut = SettingsFontSize.medium;

        // When Then

        expect(sut.scale, 1.0);
      });

      test('SettingsFontSize.big', () {
        // Given
        const sut = SettingsFontSize.small;

        // When Then

        expect(sut.scale, 0.8);
      });
    },
  );
}
