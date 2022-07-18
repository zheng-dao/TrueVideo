import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/camera/camera_result.dart';
import 'package:truvideo_enterprise/model/camera/camera_video_file.dart';
import 'package:truvideo_enterprise/model/camera/video_info.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/model/user_settings.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/event_bus/_interface.dart';
import 'package:truvideo_enterprise/service/file_bucket/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/ro_video_upload.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';

import 'ro_video_upload_test.mocks.dart';

@GenerateMocks([
  AuthService,
  CameraResultModel,
  RepairOrderService,
  FileBucketService,
  LogEventService,
  EventBusService,
  OfflineEnqueueService,
  LocalDatabaseService,
])
void main() {
  group(
    'OfflineEnqueueVideoUploadServiceImpl',
    () {
      late MockAuthService authService;
      late MockRepairOrderService repairOrderService;
      late MockFileBucketService fileBucketService;
      late MockLogEventService logEventService;
      late MockEventBusService eventBusService;
      late MockOfflineEnqueueService offlineEnqueueService;
      late MockLocalDatabaseService localDatabaseService;
      late MockCameraResultModel cameraResultModel;

      setUp(
        () {
          authService = MockAuthService();
          repairOrderService = MockRepairOrderService();
          fileBucketService = MockFileBucketService();
          logEventService = MockLogEventService();
          eventBusService = MockEventBusService();
          offlineEnqueueService = MockOfflineEnqueueService();
          localDatabaseService = MockLocalDatabaseService();
          cameraResultModel = MockCameraResultModel();

          GetIt.I.registerSingleton<AuthService>(authService);
          GetIt.I.registerSingleton<RepairOrderService>(repairOrderService);
          GetIt.I.registerSingleton<FileBucketService>(fileBucketService);
          GetIt.I.registerSingleton<LogEventService>(logEventService);
          GetIt.I.registerSingleton<EventBusService>(eventBusService);
          GetIt.I
              .registerSingleton<OfflineEnqueueService>(offlineEnqueueService);
          GetIt.I.registerSingleton<LocalDatabaseService>(localDatabaseService);
        },
      );

      test(
        'Should be initialized',
        () {
          // Given
          final sut = OfflineEnqueueVideoUploadServiceImpl();

          // When, Then
          expect(sut, isNotNull);
          expect(sut, isA<OfflineEnqueueVideoUploadServiceImpl>());
        },
      );

      group(
        '.onDone()',
        () {
          test(
            'verify if getByUID is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel =
                  RepairOrderUploadVideoRequestModel(uid: 'uid');

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);

              await sut.onDone('uid');

              // Then
              verify(offlineEnqueueService.getByUID(any)).called(1);
            },
          );

          test(
            'verify if getVideoUploadRequestByUID is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => null);

              await sut.onDone('uid');

              // Then
              verify(repairOrderService.getVideoUploadRequestByUID(any))
                  .called(1);
            },
          );

          test(
            'verify if updateVideoUploadRequest is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => null);

              await sut.onDone('uid');

              // Then
              verify(repairOrderService.updateVideoUploadRequest(any))
                  .called(1);
            },
          );

          test(
            'verify if delete is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => null);

              await sut.onDone('uid');

              // Then
              verify(localDatabaseService.delete(any, any)).called(1);
            },
          );
        },
      );
      group(
        '.onError()',
        () {
          test(
            'verify if logEvent is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => null);

              await sut.onError('uid', 'error');

              // Then
              verify(logEventService.logEvent(
                any,
                action: anyNamed('action'),
                level: anyNamed('level'),
                message: anyNamed('message'),
                orderID: anyNamed('orderID'),
                raw: anyNamed('raw'),
              )).called(1);
            },
          );

          test(
            'verify if updateVideoUploadRequest is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => null);

              await sut.onError('uid', 'error');

              // Then
              verify(repairOrderService.updateVideoUploadRequest(any))
                  .called(1);
            },
          );

          test(
            'verify if getVideoUploadRequestByUID is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => null);

              await sut.onError('uid', 'error');

              // Then
              verify(repairOrderService.getVideoUploadRequestByUID(any))
                  .called(1);
            },
          );

          test(
            'verify if getByUID is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => null);

              await sut.onError('uid', 'error');

              // Then
              verify(offlineEnqueueService.getByUID(any)).called(1);
            },
          );
        },
      );

      group(
        '.onPending()',
        () {
          test(
            'verify if getByUID is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => null);

              await sut.onPending('uid');

              // Then
              verify(offlineEnqueueService.getByUID(any)).called(1);
            },
          );

          test(
            'verify if getVideoUploadRequestByUID is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => null);

              await sut.onPending('uid');

              // Then
              verify(repairOrderService.getVideoUploadRequestByUID(any))
                  .called(1);
            },
          );

          test(
            'verify if updateVideoUploadRequest is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => null);

              await sut.onPending('uid');

              // Then
              verify(repairOrderService.updateVideoUploadRequest(any))
                  .called(1);
            },
          );
        },
      );

      group(
        '.onProcess()',
        () {
          test(
            'Should return a CustomExcception if Video upload request not found',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                },
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => null);

              // Then
              expect(sut.onProcess('uid'), throwsA(isA<CustomException>()));
            },
          );

          test(
            'Verify if getVideoUploadRequestByUID is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                  'videoThumbnailURL': 'videoThumbnailURL',
                  'videoEncodedPath': 'videoEncodedPath',
                  'videoURL': 'videoURL',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );
              final request = RepairOrderUploadVideoRequestModel(
                offlineEnqueueStatus: OfflineEnqueueItemStatus.processing,
                updateDate: DateTime.now(),
              );
              const userSettingsModel = [
                UserSettingsModel(key: 'enterprise-storage', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ]),
                UserSettingsModel(key: 'enterprise-storage-files', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ])
              ];

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => request);
              when(authService.getUserSettings())
                  .thenAnswer((_) async => userSettingsModel);

              await sut.onProcess('uid');

              // Then
              verify(repairOrderService.getVideoUploadRequestByUID(any))
                  .called(1);
            },
          );

          test(
            'Verify if updateVideoUploadRequest is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                  'videoThumbnailURL': 'videoThumbnailURL',
                  'videoEncodedPath': 'videoEncodedPath',
                  'videoURL': 'videoURL',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );
              final request = RepairOrderUploadVideoRequestModel(
                offlineEnqueueStatus: OfflineEnqueueItemStatus.processing,
                updateDate: DateTime.now(),
              );
              const userSettingsModel = [
                UserSettingsModel(key: 'enterprise-storage', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ]),
                UserSettingsModel(key: 'enterprise-storage-files', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ])
              ];

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => request);
              when(authService.getUserSettings())
                  .thenAnswer((_) async => userSettingsModel);

              await sut.onProcess('uid');

              // Then
              verify(repairOrderService.updateVideoUploadRequest(any))
                  .called(1);
            },
          );

          test(
            'Verify if getUserSettings is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                  'videoThumbnailURL': 'videoThumbnailURL',
                  'videoEncodedPath': 'videoEncodedPath',
                  'videoURL': 'videoURL',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );
              final request = RepairOrderUploadVideoRequestModel(
                offlineEnqueueStatus: OfflineEnqueueItemStatus.processing,
                updateDate: DateTime.now(),
              );
              const userSettingsModel = [
                UserSettingsModel(key: 'enterprise-storage', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ]),
                UserSettingsModel(key: 'enterprise-storage-files', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ])
              ];

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => request);
              when(authService.getUserSettings())
                  .thenAnswer((_) async => userSettingsModel);

              await sut.onProcess('uid');

              // Then
              verify(authService.getUserSettings()).called(1);
            },
          );

          test(
            'Verify if getByUID is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                  'videoThumbnailURL': 'videoThumbnailURL',
                  'videoEncodedPath': 'videoEncodedPath',
                  'videoURL': 'videoURL',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );
              final request = RepairOrderUploadVideoRequestModel(
                offlineEnqueueStatus: OfflineEnqueueItemStatus.processing,
                updateDate: DateTime.now(),
              );
              const userSettingsModel = [
                UserSettingsModel(key: 'enterprise-storage', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ]),
                UserSettingsModel(key: 'enterprise-storage-files', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ])
              ];

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => request);
              when(authService.getUserSettings())
                  .thenAnswer((_) async => userSettingsModel);

              await sut.onProcess('uid');

              // Then
              verify(offlineEnqueueService.getByUID(any)).called(4);
            },
          );

          test(
            'Should return a CustomExcception because an error getting bucket information occurs',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoUrl': 'videoUrl',
                  'videoThumbnailURL': 'videoThumbnailURL',
                  'videoEncodedPath': 'videoEncodedPath',
                  'videoURL': 'videoURL',
                },
              );
              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );
              final request = RepairOrderUploadVideoRequestModel(
                offlineEnqueueStatus: OfflineEnqueueItemStatus.processing,
                updateDate: DateTime.now(),
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => request);

              // Then
              expect(sut.onProcess('uid'), throwsA(isA<CustomException>()));
            },
          );

          test(
            'Should return a CustomExcception Video thumbnail file not found ',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoEncodedPath': 'videoEncodedPath',
                  'videoURL': 'videoURL',
                },
              );

              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              final request = RepairOrderUploadVideoRequestModel(
                offlineEnqueueStatus: OfflineEnqueueItemStatus.processing,
                updateDate: DateTime.now(),
              );

              const userSettingsModel = [
                UserSettingsModel(key: 'enterprise-storage', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ]),
                UserSettingsModel(key: 'enterprise-storage-files', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ])
              ];

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => request);
              when(authService.getUserSettings())
                  .thenAnswer((_) async => userSettingsModel);

              // Then
              expect(sut.onProcess('uid'), throwsA(isA<CustomException>()));
            },
          );

          test(
            'Should return a CustomExcception if Video file not found',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'videoUploadRequestUID',
                  'videoThumbnailURL': 'videoThumbnailURL',
                  'videoURL': 'videoURL',
                },
              );

              const videoRequestModel = RepairOrderUploadVideoRequestModel(
                uid: 'uid',
                offlineEnqueueUID: 'offlineEnqueueUID',
              );

              final request = RepairOrderUploadVideoRequestModel(
                offlineEnqueueStatus: OfflineEnqueueItemStatus.processing,
                updateDate: DateTime.now(),
              );

              const userSettingsModel = [
                UserSettingsModel(key: 'enterprise-storage', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ]),
                UserSettingsModel(key: 'enterprise-storage-files', children: [
                  UserSettingsModel(key: 'bucket-name', value: 'bucket-name'),
                  UserSettingsModel(
                      key: 'identity-pool-id', value: 'identity-pool-id'),
                  UserSettingsModel(
                      key: 'bucket-region', value: 'bucket-region'),
                ])
              ];

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(repairOrderService.getVideoUploadRequestByUID(any))
                  .thenAnswer((_) async => videoRequestModel);
              when(repairOrderService.updateVideoUploadRequest(any))
                  .thenAnswer((_) async => request);
              when(authService.getUserSettings())
                  .thenAnswer((_) async => userSettingsModel);

              // Then
              expect(sut.onProcess('uid'), throwsA(isA<CustomException>()));
            },
          );
        },
      );

      group(
        '.onDelete()',
        () {
          test(
            'verify if getVideoUploadRequestByUID is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              const model = RepairOrderUploadVideoRequestModel();
              const offlineEnqueueItemModel = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'uid',
                  'videoThumbnailURL': 'videoThumbnailURL',
                  'videoURL': 'videoURL',
                },
              );

              // When
              when(offlineEnqueueService.getByUID('uid'))
                  .thenAnswer((_) async => offlineEnqueueItemModel);
              when(repairOrderService.getVideoUploadRequestByUID('uid'))
                  .thenAnswer((_) async => model);
              await sut.onDelete('uid');

              // Then
              verify(repairOrderService.getVideoUploadRequestByUID('uid'))
                  .called(1);
            },
          );

          test(
            'verify if deleteFiles is called',
            () async {
              // Given
              final sut = OfflineEnqueueVideoUploadServiceImpl();
              final model = RepairOrderUploadVideoRequestModel(
                cameraResult: cameraResultModel,
              );
              const offlineEnqueueItemModel = OfflineEnqueueItemModel(
                uid: 'uid',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'videoUploadRequestUID': 'uid',
                  'videoThumbnailURL': 'videoThumbnailURL',
                  'videoURL': 'videoURL',
                },
              );

              // When
              when(offlineEnqueueService.getByUID('uid'))
                  .thenAnswer((_) async => offlineEnqueueItemModel);
              when(repairOrderService.getVideoUploadRequestByUID('uid'))
                  .thenAnswer((_) async => model);
              when(cameraResultModel.deleteFiles()).thenAnswer((_) => null);
              await sut.onDelete('uid');

              // Then
              verify(cameraResultModel.deleteFiles()).called(1);
            },
          );
        },
      );
    },
  );
}
