import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/camera/video_session.dart';
import 'package:truvideo_enterprise/model/camera/video_session_file.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/video_session/index.dart';

import 'video_session_test.mocks.dart';

@GenerateMocks([
  LocalDatabaseService,
  AuthService,
])
main() {
  setUp(
    () async {
      await GetIt.I.reset();
    },
  );
  group(
    'VideoSessionServiceImpl',
    () {
      late MockLocalDatabaseService localDatabaseService;
      late MockAuthService authService;

      setUp(() {
        authService = MockAuthService();
        localDatabaseService = MockLocalDatabaseService();

        GetIt.I.registerSingleton<LocalDatabaseService>(localDatabaseService);
        GetIt.I.registerSingleton<AuthService>(authService);
      });

      test(
        'Should be initialized',
        () {
          // Given
          final sut = VideoSessionServiceImpl();

          // When, Then
          expect(sut, isNotNull);
          expect(sut, isA<VideoSessionServiceImpl>());
        },
      );

      group(
        '.create()',
        () {
          test(
            'Return a CustomException if tag is not empty and existing is not null',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              const model = [VideoSessionModel(tag: 'stringTag')];

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => model);

              // Then
              expect(() => sut.create(tag: 'stringTag'),
                  throwsA(isA<CustomException>()));
            },
          );

          test(
            'Return a CustomException if tag is not empty and existing is not null',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              final model = VideoSessionModel(
                uid: DateTime.now().millisecondsSinceEpoch.toString(),
                createdAt: DateTime.now(),
                tag: 'tag',
              );

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => []);
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => model);

              final result = await sut.create(tag: 'stringTag');

              // Then
              expect(result.createdAt, isA<DateTime>());
              expect(result.tag, equals('stringTag'));
              expect(result, isNotNull);
            },
          );
        },
      );

      group(
        '.addVideo()',
        () {
          test(
            '.read() Should called',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              final model = VideoSessionModel(
                uid: DateTime.now().millisecondsSinceEpoch.toString(),
                createdAt: DateTime.now(),
                tag: 'tag',
              );
              const file = VideoSessionFileModel(
                path: 'fofo',
                selfie: true,
              );

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              await sut.addVideo('uid', file);

              // Then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test(
            '.write() Should called',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              final model = VideoSessionModel(
                uid: DateTime.now().millisecondsSinceEpoch.toString(),
                createdAt: DateTime.now(),
                tag: 'tag',
              );
              const file = VideoSessionFileModel(
                path: 'fofo',
                selfie: true,
              );

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => '');
              await sut.addVideo('uid', file);

              // Then
              verify(localDatabaseService.write(any, any, any)).called(1);
            },
          );

          test(
            'Should return a CustomException if model is null',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              const file = VideoSessionFileModel(
                path: 'fofo',
                selfie: true,
              );

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);

              // Then
              expect(() => sut.addVideo('uid', file),
                  throwsA(isA<CustomException>()));
            },
          );
        },
      );

      group(
        '.addPicture()',
        () {
          test(
            'Return a CustomException if model is null',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              const file = VideoSessionFileModel(
                path: 'fofo',
                selfie: true,
              );

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);

              // Then
              expect(() => sut.addPicture('uid', file),
                  throwsA(isA<CustomException>()));
            },
          );

          test(
            '.write() Should called',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              const file = VideoSessionFileModel(
                path: 'fofo',
                selfie: true,
              );
              final model = VideoSessionModel(
                uid: DateTime.now().millisecondsSinceEpoch.toString(),
                createdAt: DateTime.now(),
                tag: 'tag',
              );

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => 'string');

              await sut.addPicture('uid', file);

              // Then
              verify(localDatabaseService.write(any, any, any)).called(1);
            },
          );
        },
      );

      group(
        '.deleteByTag()',
        () {
          test(
            '.getAll() Should called',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              const model = {
                'tag': 'tag',
                'uid': 'uid',
              };
               final model1 = VideoSessionModel(
                uid: DateTime.now().millisecondsSinceEpoch.toString(),
                createdAt: DateTime.now(),
                tag: 'tag',
              );

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => [model]);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              await sut.deleteByTag('tag', deleteFiles: true);

              // Then
              verify(localDatabaseService.getAll(any)).called(1);
            },
          );
        },
      );

      group(
        '.deleteByUID()',
        () {
          test(
            '.read() should be called',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => '');

              await sut.deleteByUID('uid');

              // Then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test(
            '.delete() should be called',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              final model = VideoSessionModel(
                uid: DateTime.now().millisecondsSinceEpoch.toString(),
                createdAt: DateTime.now(),
                tag: 'tag',
              );

              // When
              when(authService.sub).thenReturn('asd');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              when(localDatabaseService.delete(any, any))
                  .thenAnswer((_) async => '');

              await sut.deleteByUID('uid');

              // Then
              verify(localDatabaseService.delete(any, any)).called(1);
            },
          );
        },
      );

      group(
        '.getByTag()',
        () {
          test(
            'Should retur VideoSessionModel',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              const tag = 'tag';
              final model = [
                VideoSessionModel(
                  uid: DateTime.now().millisecondsSinceEpoch.toString(),
                  createdAt: DateTime.now(),
                  tag: 'tag',
                )
              ];

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => model);
              final result = await sut.getByTag(tag);

              // Then
              expect(result?.createdAt, isA<DateTime>());
              expect(result?.tag, equals('tag'));
              expect(result, isNotNull);
            },
          );

          test(
            '.getAll() Should be called',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              const tag = 'tag';
              final model = [
                VideoSessionModel(
                  uid: DateTime.now().millisecondsSinceEpoch.toString(),
                  createdAt: DateTime.now(),
                  tag: 'tag',
                )
              ];

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => model);
              await sut.getByTag(tag);

              // Then
              verify(localDatabaseService.getAll(any)).called(1);
            },
          );
        },
      );

      group(
        '.getByUID()',
        () {
          test(
            'Should return VideoSessionModel',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              final model = VideoSessionModel(
                uid: DateTime.now().millisecondsSinceEpoch.toString(),
                createdAt: DateTime.now(),
                tag: 'tag',
              );

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              final result = await sut.getByUID('uid');

              // then
              expect(result?.createdAt, isA<DateTime>());
              expect(result?.tag, equals('tag'));
              expect(result, isNotNull);
            },
          );

          test(
            '.read() Should be called',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              final model = VideoSessionModel(
                uid: DateTime.now().millisecondsSinceEpoch.toString(),
                createdAt: DateTime.now(),
                tag: 'tag',
              );

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              await sut.getByUID('uid');

              // Then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );
        },
      );

      group(
        '.getAll()',
        () {
          test(
            '.getAll() should be called',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => []);

              await sut.getAll();

              // Then
              verify(localDatabaseService.getAll(any)).called(1);
            },
          );

          test(
            'Should return List VideoSessionModel',
            () async {
              // Given
              final sut = VideoSessionServiceImpl();
              const model = [VideoSessionModel(tag: 'stringTag')];

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => model);

              final result = await sut.getAll();

              // Then
              expect(result, model);
            },
          );
        },
      );

      group(
        '.streamAll()',
        () {
          test(
            'StreamAll should be called',
            () async {
              // Given
              List<VideoSessionModel> results = [];
              final sut = VideoSessionServiceImpl();
              final streamController =
                  StreamController<List<VideoSessionModel>>();
              const videoSession = [VideoSessionModel(tag: 'stringTag')];

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.streamAll(any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamAll().listen((event) {
                results.addAll(event);
              });

              streamController.add(videoSession);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, equals(videoSession));
            },
          );
        },
      );

      group(
        'streamByTag',
        () {
          test(
            'Should return List VideoSessionModel',
            () async {
              // Given
              List<VideoSessionModel> results = [];
              final sut = VideoSessionServiceImpl();
              final streamController =
                  StreamController<List<VideoSessionModel>>();
              const videoSession = [
                VideoSessionModel(uid: '123', tag: 'stringTag'),
                VideoSessionModel(uid: '456', tag: 'tag'),
                VideoSessionModel(uid: '789', tag: 'String'),
              ];

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.streamAll(any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamByTag('stringTag').listen((event) {
                results.addAll(videoSession);
              });

              streamController.add(videoSession);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, equals(videoSession));
            },
          );
        },
      );
      group(
        '.streamByUID()',
        () {
          test(
            '....',
            () async {
              // Given
              List<VideoSessionModel> results = [];
              final sut = VideoSessionServiceImpl();
              final streamController =
                  StreamController<List<VideoSessionModel>>();
              const videoSession = [
                VideoSessionModel(uid: '123', tag: 'stringTag')
              ];

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamByUID('stringTag').listen((event) {
                results.addAll(videoSession);
              });

              streamController.add(videoSession);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, videoSession);
            },
          );
        },
      );
    },
  );
}
