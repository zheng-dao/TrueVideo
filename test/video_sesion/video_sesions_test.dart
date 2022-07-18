import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/camera/video_session.dart';
import 'package:truvideo_enterprise/model/camera/video_session_file.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/video_session/index.dart';

import 'video_sesions_test.mocks.dart';

@GenerateMocks([
  LocalDatabaseService,
  AuthService,
  LogEventService,
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
      late MockLogEventService logEventService;

      setUp(() {
        authService = MockAuthService();
        localDatabaseService = MockLocalDatabaseService();
        logEventService = MockLogEventService();

        GetIt.I.registerSingleton<LocalDatabaseService>(localDatabaseService);
        GetIt.I.registerSingleton<AuthService>(authService);
        GetIt.I.registerSingleton<LogEventService>(logEventService);
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
            ' Should return a VideoSessionModel',
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
                  .thenAnswer((_) async => [const VideoSessionFileModel()]);
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => model);

              final result = await sut.create(tag: 'stringTag');
              print(result);

              // Then
              expect(result.uid, isA<String>());
              expect(result.createdAt, isA<DateTime>());
              expect(result.tag, isA<String>());
              expect(result.videos, isA<List>());

            },
          );
        },
      );
    },
  );
}
