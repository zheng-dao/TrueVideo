import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/log_event/model/actions_video_upload.dart';

void main() {
  group(
    'LogEventActionVideoUpload',
    () {
      test(
        'create',
        () {
          // Given
          const sut = LogEventActionVideoUpload.create;
          List resultExpected = [
            'create',
            0,
            'event_video_upload_create',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'edit',
        () {
          // Given
          const sut = LogEventActionVideoUpload.edit;
          List resultExpected = [
            'edit',
            1,
            'event_video_upload_edit',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

        test(
        'delete',
        () {
          // Given
          const sut = LogEventActionVideoUpload.delete;
          List resultExpected = [
            'delete',
            2,
            'event_video_upload_delete',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'start',
        () {
          // Given
          const sut = LogEventActionVideoUpload.start;
          List resultExpected = [
            'start',
            3,
            'event_video_upload_start',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'retry',
        () {
          // Given
          const sut = LogEventActionVideoUpload.retry;
          List resultExpected = [
            'retry',
            4,
            'event_video_upload_retry',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'getSettings',
        () {
          // Given
          const sut = LogEventActionVideoUpload.getSettings;
          List resultExpected = [
            'getSettings',
            5,
            'event_video_upload_get_settings',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'uploadVideoThumbnail',
        () {
          // Given
          const sut = LogEventActionVideoUpload.uploadVideoThumbnail;
          List resultExpected = [
            'uploadVideoThumbnail',
            6,
            'event_video_upload_upload_video',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'encodeVideo',
        () {
          // Given
          const sut = LogEventActionVideoUpload.encodeVideo;
          List resultExpected = [
            'encodeVideo',
            7,
            'event_video_upload_encode_video',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'uploadVideo',
        () {
          // Given
          const sut = LogEventActionVideoUpload.uploadVideo;
          List resultExpected = [
            'uploadVideo',
            8,
            'event_video_upload_upload_video',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'uploadPicture',
        () {
          // Given
          const sut = LogEventActionVideoUpload.uploadPicture;
          List resultExpected = [
            'uploadPicture',
            9,
            'event_video_upload_upload_picture',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

       test(
        'save',
        () {
          // Given
          const sut = LogEventActionVideoUpload.save;
          List resultExpected = [
            'save',
            10,
            'event_video_upload_save',
          ];
 
          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'error',
        () {
          // Given
          const sut = LogEventActionVideoUpload.error;
          List resultExpected = [
            'error',
            11,
            'event_video_upload_error',
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
