import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/log_event/model/module.dart';
 
void main() {
  group(
    'LogEventModule',
    () {
      test(
        'camera',
        () {
          // Given
          const sut = LogEventModule.camera;
          List resultExpected = [
            'camera',
            0,
            'camera',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'videoEditor',
        () {
          // Given
          const sut = LogEventModule.videoEditor;
          List resultExpected = [
            'videoEditor',
            1,
            'video-editor',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'videoUpload',
        () {
          // Given
          const sut = LogEventModule.videoUpload;
          List resultExpected = [
            'videoUpload',
            2,
            'video-upload',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

       test(
        'settings',
        () {
          // Given
          const sut = LogEventModule.settings;
          List resultExpected = [
            'settings',
            3,
            'settings',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'login',
        () {
          // Given
          const sut = LogEventModule.login;
          List resultExpected = [
            'login',
            4,
            'login',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'orders',
        () {
          // Given
          const sut = LogEventModule.orders;
          List resultExpected = [
            'orders',
            5,
            'orders',
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
