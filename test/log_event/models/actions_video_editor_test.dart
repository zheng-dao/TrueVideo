import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/log_event/model/actions_video_editor.dart';

void main() {
  group(
    'LogEventActionVideoEditor',
    () {
      test(
        'videoRotate',
        () {
          // Given
          const sut = LogEventActionVideoEditor.videoRotate;
          List resultExpected = [
            'videoRotate',
            0,
            'event_video_editor_video_rotate',
          ];

          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'videoConcat',
        () {
          // Given
          const sut = LogEventActionVideoEditor.videoConcat;
          List resultExpected = [
            'videoConcat',
            1,
            'event_video_editor_video_concat',
          ];

          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'videoInfo',
        () {
          // Given
          const sut = LogEventActionVideoEditor.videoInfo;
          List resultExpected = [
            'videoInfo',
            2,
            'event_video_editor_video_info',
          ];

          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'videoThumbnail',
        () {
          // Given
          const sut = LogEventActionVideoEditor.videoThumbnail;
          List resultExpected = [
            'videoThumbnail',
            4,
            'event_video_editor_video_thumbnail',
          ];

          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

       test(
        'pictureEdit',
        () {
          // Given
          const sut = LogEventActionVideoEditor.pictureEdit;
          List resultExpected = [
            'pictureEdit',
            5,
            'event_video_editor_picture_edit',
          ];

          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

      test(
        'pictureSize',
        () {
          // Given
          const sut = LogEventActionVideoEditor.pictureSize;
          List resultExpected = [
            'pictureSize',
            6,
            'event_video_editor_picture_size',
          ];

          // When, Then
          expect(sut.name, resultExpected[0]);
          expect(sut.index, resultExpected[1]);
          expect(sut.eventName, resultExpected[2]);
        },
      );

       test(
        'videoTrim',
        () {
          // Given
          const sut = LogEventActionVideoEditor.videoTrim;
          List resultExpected = [
            'videoTrim',
            3,
            'event_video_editor_video_trim',
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
