import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/log_event/model/actions_camera.dart';

void main() {
  group(
    'LogEventActionCameraExt',
    () {
      test(
        'initCamera',
        () {
          // Given
          const sut = LogEventActionCamera.initCamera;
          List resultExpect = [
            'event_camera_init',
            'initCamera',
            2,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'recordStart',
        () {
          // Given
          const sut = LogEventActionCamera.recordStart;
          List resultExpect = [
            'event_camera_record_start',
            'recordStart',
            4,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'recordPause',
        () {
          // Given
          const sut = LogEventActionCamera.recordPause;
          List resultExpect = [
            'event_camera_record_pause',
            'recordPause',
            5,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'recordResume',
        () {
          // Given
          const sut = LogEventActionCamera.recordResume;
          List resultExpect = [
            'event_camera_record_resume',
            'recordResume',
            6,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'recordFinish',
        () {
          // Given
          const sut = LogEventActionCamera.recordFinish;
          List resultExpect = [
            'event_camera_record_finish',
            'recordFinish',
            7,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'takePicture',
        () {
          // Given
          const sut = LogEventActionCamera.takePicture;
          List resultExpect = [
            'event_camera_take_picture',
            'takePicture',
            8,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'cancel',
        () {
          // Given
          const sut = LogEventActionCamera.cancel;
          List resultExpect = [
            'event_camera_cancel',
            'cancel',
            9,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'createSession',
        () {
          // Given
          const sut = LogEventActionCamera.createSession;
          List resultExpect = [
            'event_camera_session_create',
            'createSession',
            10,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'resumeSession',
        () {
          // Given
          const sut = LogEventActionCamera.resumeSession;
          List resultExpect = [
            'event_camera_session_resume',
            'resumeSession',
            11,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'deleteSession',
        () {
          // Given
          const sut = LogEventActionCamera.deleteSession;
          List resultExpect = [
            'event_camera_session_delete',
            'deleteSession',
            12,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'addVideoToSession',
        () {
          // Given
          const sut = LogEventActionCamera.addVideoToSession;
          List resultExpect = [
            'event_camera_session_add_video',
            'addVideoToSession',
            13,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'addPictureToSession',
        () {
          // Given
          const sut = LogEventActionCamera.addPictureToSession;
          List resultExpect = [
            'event_camera_session_add_picture',
            'addPictureToSession',
            14,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'switchCamera',
        () {
          // Given
          const sut = LogEventActionCamera.switchCamera;
          List resultExpect = [
            'event_camera_switch_camera',
            'switchCamera',
            15,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'changeFlashMode',
        () {
          // Given
          const sut = LogEventActionCamera.changeFlashMode;
          List resultExpect = [
            'event_camera_change_flash_mode',
            'changeFlashMode',
            16,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'listCameras',
        () {
          // Given
          const sut = LogEventActionCamera.listCameras;
          List resultExpect = [
            'event_camera_list_cameras',
            'listCameras',
            0,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'askPermission',
        () {
          // Given
          const sut = LogEventActionCamera.askPermission;
          List resultExpect = [
            'event_camera_ask_permission',
            'askPermission',
            1,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'rotationChange',
        () {
          // Given
          const sut = LogEventActionCamera.rotationChange;
          List resultExpect = [
            'event_camera_rotation_change',
            'rotationChange',
            3,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'changeFullScreen',
        () {
          // Given
          const sut = LogEventActionCamera.changeFullScreen;
          List resultExpect = [
            'event_camera_change_fullscreen',
            'changeFullScreen',
            17,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );

      test(
        'changeNarratorMode',
        () {
          // Given
          const sut = LogEventActionCamera.changeNarratorMode;
          List resultExpect = [
            'event_camera_change_narrator_mode',
            'changeNarratorMode',
            18,
          ];

          // When, Then
          expect(sut.eventName, resultExpect[0]);
          expect(sut.name, resultExpect[1]);
          expect(sut.index, resultExpect[2]);
        },
      );
    },
  );
}
