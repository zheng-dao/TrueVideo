import 'dart:async';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/camera/camera_result.dart';
import 'package:truvideo_enterprise/model/camera/camera_video_file.dart';
import 'package:truvideo_enterprise/model/camera/video_info.dart';
import 'package:truvideo_enterprise/model/customer.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/order_status.dart';
import 'package:truvideo_enterprise/model/repair_order.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/model/tce_user.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/http/model/response.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/service/repair_order/dto/video_upload.dart';
import 'package:truvideo_enterprise/service/repair_order/dto/video_upload_video.dart';
import 'package:truvideo_enterprise/service/repair_order/index.dart';

import 'repair_order_test.mocks.dart';

@GenerateMocks([
  AuthService,
  HttpService,
  LocalDatabaseService,
  LogEventService,
  OfflineEnqueueService,
])
main() {
  setUp(
    () async {
      await GetIt.I.reset();
    },
  );

  group(
    'RepairOrderServiceImpl',
    () {
      late MockAuthService authService;
      late MockHttpService httpService;
      late MockLocalDatabaseService localDatabaseService;
      late MockLogEventService logEventService;
      late MockOfflineEnqueueService offlineEnqueueService;

      setUp(
        () {
          authService = MockAuthService();
          httpService = MockHttpService();
          localDatabaseService = MockLocalDatabaseService();
          logEventService = MockLogEventService();
          offlineEnqueueService = MockOfflineEnqueueService();

          GetIt.I.registerSingleton<AuthService>(authService);
          GetIt.I.registerSingleton<HttpService>(httpService);
          GetIt.I.registerSingleton<LocalDatabaseService>(localDatabaseService);
          GetIt.I.registerSingleton<LogEventService>(logEventService);
          GetIt.I
              .registerSingleton<OfflineEnqueueService>(offlineEnqueueService);
        },
      );

      test(
        'Should be initialized',
        () {
          // Given
          final sut = RepairOrderServiceImpl(baseURL: 'https://httpbin.org/');

          // When, then
          expect(sut, isNotNull);
          expect(sut, isA<RepairOrderServiceImpl>());
        },
      );

      group(
        '.getList()',
        () {
          group(
            'RepairOrderTypeFilter.all',
            () {
              test(
                'Should return a RepairOrderModel',
                () async {
                  // Given
                  const baseURL = 'https://httpbin.org/';
                  final sut = RepairOrderServiceImpl(baseURL: baseURL);
                  final httpResponseModel = HttpResponseModel(data: {
                    'totalResults': 20,
                    'currPage': 1,
                    'results': [
                      const RepairOrderModel(id: 1, jobServiceNumber: '123345')
                          .toJson()
                    ],
                  });
                  const expectedData = [
                    RepairOrderModel(id: 1, jobServiceNumber: '123345')
                  ];

                  // When
                  when(authService.token).thenReturn('foo');
                  when(authService.accountUid).thenReturn('boo');
                  when(httpService.get(
                    Uri.parse("$baseURL/api/v3/repair-order"),
                    headers: anyNamed('headers'),
                    params: anyNamed('params'),
                  )).thenAnswer((_) async => httpResponseModel);

                  final result = await sut.getList(
                    id: 1,
                  );

                  // Then
                  expect(result.data, expectedData);
                  expect(result.hasMore, true);
                  expect(result.page, 1);
                  expect(result.pageSize, 20);
                  expect(result.total, 20);
                },
              );

              test(
                'Should return null in case of parsing error',
                () async {
                  // Given
                  const baseURL = 'https://httpbin.org/';
                  final sut = RepairOrderServiceImpl(baseURL: baseURL);
                  const httpResponseModel = HttpResponseModel(data: {
                    'totalResults': 20,
                    'currPage': 1,
                    'results': ['String'],
                  });

                  // When
                  when(authService.token).thenReturn('foo');
                  when(authService.accountUid).thenReturn('boo');
                  when(httpService.get(
                    Uri.parse("$baseURL/api/v3/repair-order"),
                    headers: anyNamed('headers'),
                    params: anyNamed('params'),
                  )).thenAnswer((_) async => httpResponseModel);

                  final result = await sut.getList(id: 1);

                  // Then
                  expect(result.data, isEmpty);
                },
              );
            },
          );

          group(
            'RepairOrderTypeFilter.repairOrders',
            () {
              test(
                'Should return a RepairOrderModel',
                () async {
                  // Given
                  const baseURL = 'https://httpbin.org/';
                  final sut = RepairOrderServiceImpl(baseURL: baseURL);
                  final httpResponseModel = HttpResponseModel(data: {
                    'totalResults': 20,
                    'currPage': 1,
                    'results': [
                      const RepairOrderModel(id: 1, jobServiceNumber: '123345')
                          .toJson()
                    ],
                  });
                  const expectedData = [
                    RepairOrderModel(id: 1, jobServiceNumber: '123345')
                  ];

                  // When
                  when(authService.token).thenReturn('foo');
                  when(authService.accountUid).thenReturn('boo');
                  when(httpService.get(
                    Uri.parse("$baseURL/api/v3/repair-order"),
                    headers: anyNamed('headers'),
                    params: anyNamed('params'),
                  )).thenAnswer((_) async => httpResponseModel);

                  final result = await sut.getList(
                    id: 1,
                    type: RepairOrderTypeFilter.repairOrders,
                  );

                  // Then
                  expect(result.data, expectedData);
                  expect(result.hasMore, true);
                  expect(result.page, 1);
                  expect(result.pageSize, 20);
                  expect(result.total, 20);
                },
              );

              test(
                'Should return null in case of parsing error',
                () async {
                  // Given
                  const baseURL = 'https://httpbin.org/';
                  final sut = RepairOrderServiceImpl(baseURL: baseURL);
                  const httpResponseModel = HttpResponseModel(data: {
                    'totalResults': 20,
                    'currPage': 1,
                    'results': ['String'],
                  });

                  // When
                  when(authService.token).thenReturn('foo');
                  when(authService.accountUid).thenReturn('boo');
                  when(httpService.get(
                    Uri.parse("$baseURL/api/v3/repair-order"),
                    headers: anyNamed('headers'),
                    params: anyNamed('params'),
                  )).thenAnswer((_) async => httpResponseModel);

                  final result = await sut.getList(
                    id: 1,
                    type: RepairOrderTypeFilter.repairOrders,
                  );

                  // Then
                  expect(result.data, isEmpty);
                },
              );
            },
          );

          group(
            'RepairOrderTypeFilter.salesOrders',
            () {
              test(
                'Should return a RepairOrderModel',
                () async {
                  // Given
                  const baseURL = 'https://httpbin.org/';
                  final sut = RepairOrderServiceImpl(baseURL: baseURL);
                  final httpResponseModel = HttpResponseModel(data: {
                    'totalResults': 20,
                    'currPage': 1,
                    'results': [
                      const RepairOrderModel(id: 1, jobServiceNumber: '123345')
                          .toJson()
                    ],
                  });
                  const expectedData = [
                    RepairOrderModel(id: 1, jobServiceNumber: '123345')
                  ];

                  // When
                  when(authService.token).thenReturn('foo');
                  when(authService.accountUid).thenReturn('boo');
                  when(httpService.get(
                    Uri.parse("$baseURL/api/v3/repair-order"),
                    headers: anyNamed('headers'),
                    params: anyNamed('params'),
                  )).thenAnswer((_) async => httpResponseModel);

                  final result = await sut.getList(
                    id: 1,
                    type: RepairOrderTypeFilter.salesOrders,
                  );

                  // Then
                  expect(result.data, expectedData);
                  expect(result.hasMore, true);
                  expect(result.page, 1);
                  expect(result.pageSize, 20);
                  expect(result.total, 20);
                },
              );

              test(
                'Should return null in case of parsing error',
                () async {
                  // Given
                  const baseURL = 'https://httpbin.org/';
                  final sut = RepairOrderServiceImpl(baseURL: baseURL);
                  const httpResponseModel = HttpResponseModel(data: {
                    'totalResults': 20,
                    'currPage': 1,
                    'results': ['String'],
                  });

                  // When
                  when(authService.token).thenReturn('foo');
                  when(authService.accountUid).thenReturn('boo');
                  when(httpService.get(
                    Uri.parse("$baseURL/api/v3/repair-order"),
                    headers: anyNamed('headers'),
                    params: anyNamed('params'),
                  )).thenAnswer((_) async => httpResponseModel);

                  final result = await sut.getList(
                    id: 1,
                    type: RepairOrderTypeFilter.salesOrders,
                  );

                  // Then
                  expect(result.data, isEmpty);
                },
              );
            },
          );
        },
      );

      group(
        '.setCacheList()',
        () {
          test(
            'Should called .write',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairOrderModel = [
                RepairOrderModel(id: 1),
                RepairOrderModel(id: 2),
                RepairOrderModel(id: 3),
              ];

              //when
              when(authService.sub).thenReturn('foo');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => {});

              await sut.setCacheList(items: repairOrderModel);

              //Then
              verify(localDatabaseService.write(any, any, any)).called(1);
            },
          );
        },
      );

      group(
        '.updateCacheList()',
        () {
          test(
            'Should called .read()',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              final repairModel = RepairOrderModel(
                id: 1,
                createDate: DateTime.now(),
                customer: const CustomerModel(id: 1),
                jobServiceNumber: "foo",
                orderStatus: const OrderStatusModel(key: "duu", value: "fee"),
              );
              List<String> key = [
                'qqq',
                'www',
                'eee',
              ];

              // When
              when(authService.sub).thenReturn('qwe');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => [jsonEncode(repairModel)]);
              when(localDatabaseService.getAllKeys(any))
                  .thenAnswer((_) async => key);

              await sut.updateCacheList(repairModel);

              // Then

              verify(localDatabaseService.read(any, any)).called(3);
            },
          );
        },
      );

      group(
        '.getCachedList()',
        () {
          test(
            'Should called .read()',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn("foo");
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);

              await sut.getCachedList();
              // Then

              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test('Should return [] if data is null', () async {
            // Given
            const baseURL = 'https://httpbin.org/';
            final sut = RepairOrderServiceImpl(baseURL: baseURL);

            // When
            when(authService.sub).thenReturn("foo");
            when(localDatabaseService.read(any, any))
                .thenAnswer((_) async => null);
            when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');

            final result = await sut.getCachedList();

            // Then
            expect(result, []);
          });

          test(
            'Should return list RepairOrderModel if data is not null',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairModel = RepairOrderModel(
                id: 1,
                createDate: null,
                customer: CustomerModel(id: 1),
                jobServiceNumber: "foo",
                orderStatus: OrderStatusModel(key: "duu", value: "fee"),
              );

              // When
              when(authService.sub).thenReturn("foo");
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => [jsonEncode(repairModel)]);
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');

              final result = await sut.getCachedList();

              // Then
              expect(result, equals([repairModel]));
            },
          );

          test(
            'Should return [] if data is not null and have an error',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairModel = [];

              // When
              when(authService.sub).thenReturn("foo");
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => jsonEncode(repairModel));
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');

              final result = await sut.getCachedList();

              // Then
              expect(result, isEmpty);
            },
          );
        },
      );

      group(
        '.getDetail()',
        () {
          test(
            'Should called .get()',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.token).thenReturn("fofo");
              when(authService.accountUid).thenReturn('adad');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(authService.sub).thenReturn('coco');
              when(httpService.get(
                any,
                headers: anyNamed("headers"),
              )).thenAnswer((_) async => const HttpResponseModel(headers: {}));

              await sut.getDetail(1);

              // Then
              verify(httpService.get(
                any,
                headers: anyNamed("headers"),
              )).called(1);
            },
          );

          test(
            'Should return RepairOrderDetailModel if result.data is not null',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const httpResponseModel = HttpResponseModel(
                data: {
                  'id': 1,
                  'jobServiceNumber': 'jobServiceNumber',
                  'type': 'type',
                  'isForReview': false,
                },
              );
              const expectedData = RepairOrderDetailModel(
                id: 1,
                jobServiceNumber: 'jobServiceNumber',
                type: 'type',
                isForReview: false,
              );

              // When
              when(authService.token).thenReturn("fofo");
              when(authService.accountUid).thenReturn('adad');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(authService.sub).thenReturn('coco');
              when(httpService.get(
                any,
                headers: anyNamed("headers"),
              )).thenAnswer((_) async => httpResponseModel);

              final result = await sut.getDetail(1);

              // Then
              expect(result, equals(expectedData));
            },
          );

          test(
            'Should return null if occurs an error parsing',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const httpResponseModel = HttpResponseModel(
                data: {null},
              );

              // When
              when(authService.token).thenReturn("fofo");
              when(authService.accountUid).thenReturn('adad');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(authService.sub).thenReturn('coco');
              when(httpService.get(
                any,
                headers: anyNamed("headers"),
              )).thenAnswer((_) async => httpResponseModel);

              final result = await sut.getDetail(1);

              // Then
              expect(result, null);
            },
          );

          test(
            'Should return null if result.data is null',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const httpResponseModel = HttpResponseModel(
                data: null,
              );

              // When
              when(authService.token).thenReturn("fofo");
              when(authService.accountUid).thenReturn('adad');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(authService.sub).thenReturn('coco');
              when(httpService.get(
                any,
                headers: anyNamed("headers"),
              )).thenAnswer((_) async => httpResponseModel);

              final result = await sut.getDetail(1);

              // Then
              expect(result, null);
            },
          );
        },
      );

      group(
        '.getCachedDetail()',
        () {
          test(
            'Should called .read()',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => {});
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');

              await sut.getCachedDetail(1);

              // Then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test(
            'Return null if cached is null',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');

              final result = await sut.getCachedDetail(1);

              // Then
              expect(result, null);
            },
          );

          test(
            'Return null if cached is not null but an error parsing occurs',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('fofo');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'String');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');

              final result = await sut.getCachedDetail(1);

              // Then
              expect(result, null);
            },
          );
        },
      );

      group(
        '.addVideoUploadRequest()',
        () {
          test(
            'Return a RepairOrderUploadVideoRequestModel',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('sasa');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => {});

              final result = await sut.addVideoUploadRequest(
                orderID: 1,
                orderType: 'orderType',
                cameraResult: const CameraResultModel(
                  video:
                      CameraVideoFileModel(info: VideoInfoModel(path: 'path')),
                ),
              );

              // Then
              expect(result.uid, isA<String>());
              expect(result.creationDate, isA<DateTime>());
              expect(result.orderType, equals('orderType'));
            },
          );
        },
      );

      group(
        '.getVideoUploadRequests()',
        () {
          test(
            '.getAll() Should called',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('fo');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => []);

              await (sut.getVideoUploadRequests(orderID: 1));

              // Then
              verify(localDatabaseService.getAll(any)).called(1);
            },
          );

          test(
            'Return a [] if RepairOrderUploadVideoRequestModel empty',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('fo');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => []);

              final result = await (sut.getVideoUploadRequests(orderID: 1));

              // Then
              expect(result, []);
            },
          );

          test(
            'Return a RepairOrderUploadVideoRequestModel',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const expectedData = RepairOrderUploadVideoRequestModel(
                  uid: '123',
                  offlineEnqueueUID: 'as',
                  orderID: 1,
                  videoTagID: 'fofo');

              // When
              when(authService.sub).thenReturn('fo');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => [expectedData.toJson()]);

              final result = await (sut.getVideoUploadRequests(orderID: 1));

              // Then
              expect(result, [expectedData]);
            },
          );

          test('Should return null if info is not empty and have an error ',
              () async {
            // Given
            const baseURL = 'https://httpbin.org/';
            final sut = RepairOrderServiceImpl(baseURL: baseURL);

            // When
            when(authService.sub).thenReturn('fo');
            when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
            when(localDatabaseService.getAll(any))
                .thenAnswer((_) async => ['string]']);

            final result = await (sut.getVideoUploadRequests(orderID: 1));

            // Then
            expect(result, isEmpty);
          });
        },
      );

      group(
        '.streamVideoUploadRequests()',
        () {
          test(
            'should return null if model.orderID is different of orderID',
            () async {
              // Give
              List<RepairOrderUploadVideoRequestModel> results = [];
              final streamController =
                  StreamController<List<RepairOrderUploadVideoRequestModel>>();
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairsOrdersUpload = [
                RepairOrderUploadVideoRequestModel(orderID: 1),
              ];

              // When
              when(authService.sub).thenReturn('2');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');

              when(localDatabaseService.streamAll(any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamVideoUploadRequests(orderID: 2).listen((event) {
                results.addAll(event);
              });

              streamController.add(repairsOrdersUpload);

              await Future.delayed(const Duration(seconds: 5), () {
                streamController.close();
              });

              // Then
              expect(results, []);
            },
          );

          test(
            'should return null if an error parsing occurs',
            () async {
              // Give
              List<RepairOrderUploadVideoRequestModel> results = [];
              final streamController = StreamController<List<String>>();
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairsOrdersUpload = [
                'String',
              ];

              // When
              when(authService.sub).thenReturn('2');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');

              when(localDatabaseService.streamAll(any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamVideoUploadRequests(orderID: 2).listen((event) {
                results.addAll(event);
              });

              streamController.add(repairsOrdersUpload);

              await Future.delayed(const Duration(seconds: 5), () {
                streamController.close();
              });

              // Then
              expect(results, []);
            },
          );

          test(
            'should return RepairOrderUploadVideoRequestModel ',
            () async {
              // Give
              List<RepairOrderUploadVideoRequestModel> results = [];
              final streamController =
                  StreamController<List<RepairOrderUploadVideoRequestModel>>();
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairsOrdersUpload = [
                RepairOrderUploadVideoRequestModel(orderID: 1),
              ];

              // When
              when(authService.sub).thenReturn('2');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');

              when(localDatabaseService.streamAll(any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamVideoUploadRequests(orderID: 1).listen((event) {
                results.addAll(event);
              });

              streamController.add(repairsOrdersUpload);

              await Future.delayed(const Duration(seconds: 5), () {
                streamController.close();
              });

              // Then
              expect(results, repairsOrdersUpload);
            },
          );
        },
      );

      group(
        '.getVideoUploadRequestByUID()',
        () {
          test(
            '.read() Should called',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('as');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => {});

              await sut.getVideoUploadRequestByUID('1');

              // then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test(
            ' Should return RepairOrderUploadVideoRequestModel if data is not null ',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairOrderUploadVideoRequestModel =
                  RepairOrderUploadVideoRequestModel();

              // When
              when(authService.sub).thenReturn('as');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => repairOrderUploadVideoRequestModel);

              final result = await sut.getVideoUploadRequestByUID('1');

              // Then
              expect(result, equals(repairOrderUploadVideoRequestModel));
            },
          );

          test(
            'return null if data is not null but an error parsing occurs',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('as');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'string');

              final result = await sut.getVideoUploadRequestByUID('1');

              // Then
              expect(result, isNull);
            },
          );
        },
      );

      group(
        '.updateVideoUploadRequest()',
        () {
          test(
            '.write() Should called',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const model = RepairOrderUploadVideoRequestModel();

              // When
              when(authService.sub).thenReturn('12');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => {});

              await sut.updateVideoUploadRequest(model);

              // Then
              verify(localDatabaseService.write(any, any, any)).called(1);
            },
          );

          test(
            'Return a RepairOrderUploadVideoRequestModel',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const model = RepairOrderUploadVideoRequestModel(
                cameraResult: CameraResultModel(
                    video:
                        CameraVideoFileModel(info: VideoInfoModel(path: "as"))),
              );

              // When
              when(authService.sub).thenReturn('12');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => {});

              final result = await sut.updateVideoUploadRequest(model);

              // Then
              expect(result, model);
            },
          );
        },
      );

      group(
        '.streamVideoUploadRequestByUID()',
        () {
          test(
            'Should return RepairOrderUploadVideoRequestModel',
            () async {
              // Give
              List<RepairOrderUploadVideoRequestModel?> results = [];
              final streamController = StreamController();
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairOrderUploadVideo = [
                RepairOrderUploadVideoRequestModel(),
              ];

              // When
              when(authService.sub).thenReturn('asd');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamVideoUploadRequestByUID('12').listen((event) {
                results.add(event);
              });

              streamController
                  .add(const RepairOrderUploadVideoRequestModel().toJson());

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, repairOrderUploadVideo);
            },
          );

          test(
            'Should return null if an error parsing occurs',
            () async {
              // Give
              List<RepairOrderUploadVideoRequestModel?> results = [];
              final streamController =
                  StreamController<List<RepairOrderUploadVideoRequestModel>>();
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairOrderUploadVideo = [
                RepairOrderUploadVideoRequestModel(videoTagID: 'fofo'),
              ];

              // When
              when(authService.sub).thenReturn('asd');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamVideoUploadRequestByUID('12').listen((event) {
                results.add(event);
              });

              streamController.add(repairOrderUploadVideo);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, [isNull]);
            },
          );
        },
      );

      group(
        '.startVideoUploadRequest()',
        () {
          test(
            '.read() Should called',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const offlineEnqueue = OfflineEnqueueItemModel();

              // When
              when(authService.sub).thenReturn('as');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => {});
              when(offlineEnqueueService.enqueue(any))
                  .thenAnswer((_) async => offlineEnqueue);

              await sut.startVideoUploadRequest('uid');

              // Then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test(
            '.enqueue() Should called',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const offlineEnqueue = OfflineEnqueueItemModel();

              // When
              when(authService.sub).thenReturn('as');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => {});
              when(offlineEnqueueService.enqueue(any))
                  .thenAnswer((_) async => offlineEnqueue);

              await sut.startVideoUploadRequest('uid');

              // Then
              verify(offlineEnqueueService.enqueue(any)).called(1);
            },
          );

          test(
            '.getByUID() Should called',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const offlineEnqueue = OfflineEnqueueItemModel(statusIndex: 3);
              const repairOrderUploadVideoRequest =
                  RepairOrderUploadVideoRequestModel(
                offlineEnqueueUID: '123',
              );

              // When
              when(authService.sub).thenReturn('as');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => repairOrderUploadVideoRequest);
              when(offlineEnqueueService.enqueue(any))
                  .thenAnswer((_) async => offlineEnqueue);
              when(offlineEnqueueService.getByUID('123'))
                  .thenAnswer((_) async => offlineEnqueue);

              await sut.startVideoUploadRequest('uid');

              // Then
              verify(offlineEnqueueService.getByUID('123')).called(1);
            },
          );
        },
      );

      group(
        '.retryVideoUploadRequest()',
        () {
          test(
            '.read() Should called',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairOrderUploadVideoRequestModel =
                  RepairOrderUploadVideoRequestModel(
                      uid: 'uid', offlineEnqueueUID: 'uid');
              const offlineEnqueueItem = OfflineEnqueueItemModel(
                statusIndex: 3,
                uid: 'uid',
              );

              // When
              when(authService.sub).thenReturn('fofo');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => repairOrderUploadVideoRequestModel);
              when(offlineEnqueueService.getByUID('uid'))
                  .thenAnswer((_) async => offlineEnqueueItem);

              await sut.retryVideoUploadRequest('uid');

              // Then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test(
            '.retry() Should called',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairOrderUploadVideoRequestModel =
                  RepairOrderUploadVideoRequestModel(
                      uid: 'uid', offlineEnqueueUID: 'uid');
              const offlineEnqueueItem = OfflineEnqueueItemModel(
                uid: 'uid',
                statusIndex: 3,
              );

              // When
              when(authService.sub).thenReturn('fofo');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => repairOrderUploadVideoRequestModel);
              when(offlineEnqueueService.getByUID('uid'))
                  .thenAnswer((_) async => offlineEnqueueItem);

              await sut.retryVideoUploadRequest('uid');

              // Then
              verify(offlineEnqueueService.retry('uid')).called(1);
            },
          );

          test(
            'Should show CustomException if model is null',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When

              when(authService.sub).thenReturn('fofo');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);

              // Then
              expect(() => sut.retryVideoUploadRequest('123'),
                  throwsA(isA<CustomException>()));
            },
          );

          test(
            'Should show CustomException if offlineEnqueueUID is empty',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const repairOrderUploadVideoRequestModel =
                  RepairOrderUploadVideoRequestModel(
                      uid: 'uid', offlineEnqueueUID: '');
              const offlineEnqueueItem = OfflineEnqueueItemModel(
                uid: 'uid',
              );

              // When
              when(authService.sub).thenReturn('fofo');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => repairOrderUploadVideoRequestModel);
              when(offlineEnqueueService.getByUID('uid'))
                  .thenAnswer((_) async => offlineEnqueueItem);

              // Then
              expect(() => sut.retryVideoUploadRequest('123'),
                  throwsA(isA<CustomException>()));
            },
          );
        },
      );

      group(
        '.deleteVideoUploadRequest()',
        () {
          test(
            '.read() Should called',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('as');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => {});
              await sut.deleteVideoUploadRequest('uid');

              // Then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test(
            '.delete() Should called',
            () async {
              // Give
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const model = RepairOrderUploadVideoRequestModel(
                offlineEnqueueUID: '33',
              );
              const offlineEnqueueItem = OfflineEnqueueItemModel(
                uid: 'uid',
              );

              // When
              when(authService.sub).thenReturn('as');
              when(authService.getStoredDealerCode()).thenAnswer((_) => 'asda');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              when(offlineEnqueueService.getByUID('33'))
                  .thenAnswer((_) async => offlineEnqueueItem);
              await sut.deleteVideoUploadRequest('uid');

              // Then
              verify(offlineEnqueueService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.uploadVideo()',
        () {
          test(
            '.put() Should called',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.accountUid).thenReturn('asd');
              when(authService.token).thenReturn('aszx');
              when(httpService.put(any,
                      headers: anyNamed('headers'), data: anyNamed('data')))
                  .thenAnswer((_) async => const HttpResponseModel());
              await sut.uploadVideo(
                orderID: 1,
                videoUpload: const VideoUploadDTO(
                  videoDTO: VideoUploadVideoDTO(length: 30),
                ),
              );

              // Then
              verify(httpService.put(any,
                      headers: anyNamed('headers'), data: anyNamed('data')))
                  .called(1);
            },
          );
        },
      );

      group(
        '.getAdvisors()',
        () {
          test(
            '.get() Should called',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const expectedData = TCEUserModel(
                dealer: null,
                emailAddress: 'abc@123.com',
                firstName: 'abc',
                middleName: 'zxc',
                id: 1,
                mobileNumber: '1234567',
              );

              // When
              when(authService.accountUid).thenReturn('asd');
              when(authService.token).thenReturn('aszx');
              when(httpService.get(any, headers: anyNamed('headers')))
                  .thenAnswer((_) async =>
                      HttpResponseModel(data: [expectedData.toJson()]));

              await sut.getAdvisors();

              // Then
              verify(httpService.get(any, headers: anyNamed('headers')))
                  .called(1);
            },
          );

          test(
            'Should return TCEUserModel list',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              const expectedData = TCEUserModel(
                dealer: null,
                emailAddress: 'abc@123.com',
                firstName: 'abc',
                middleName: 'zxc',
                id: 1,
                mobileNumber: '1234567',
              );

              // When
              when(authService.accountUid).thenReturn('asd');
              when(authService.token).thenReturn('aszx');
              when(httpService.get(any, headers: anyNamed('headers')))
                  .thenAnswer((_) async =>
                      HttpResponseModel(data: [expectedData.toJson()]));

              final result = await sut.getAdvisors();

              // Then
              expect(result, [expectedData]);
            },
          );
        },
      );

      group(
        '.create()',
        () {
          test(
            '.post() Should called',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('fofo');
              when(authService.token).thenReturn('fufu');
              when(authService.accountUid).thenReturn('fafa');
              when(
                httpService.post(any,
                    headers: anyNamed('headers'),
                    params: anyNamed('params'),
                    data: anyNamed('data')),
              ).thenAnswer(
                  (_) async => const HttpResponseModel(data: {"id": 1}));

              await sut.create(
                orderType: 'SALES_ORDER',
                firstName: 'firstName',
                lastName: 'lastName',
                mobileNumber: 'mobileNumber',
                email: 'email',
                stockNo: 'stockNo',
                make: 'make',
                year: 'year',
                model: 'model',
                color: 'color',
              );

              // Then
              verify(httpService.post(any,
                      headers: anyNamed('headers'),
                      params: anyNamed('params'),
                      data: anyNamed('data')))
                  .called(1);
            },
          );

          test(
            'Pass correct parameters',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              final expectedData = {
                'orderType': 'SALES_ORDER',
                'customerDTO': {
                  'firstName': 'firstName',
                  'lastName': 'lastName',
                  'mobileNumber': 'mobileNumber',
                  'email': 'email'
                },
                'vehicleDTO': {
                  'stockNo': 'stockNo',
                  'make': 'make',
                  'model': 'model',
                  'year': 'year',
                  'color': 'color'
                }
              };

              // When
              when(authService.sub).thenReturn('fofo');
              when(authService.token).thenReturn('fufu');
              when(authService.accountUid).thenReturn('fafa');
              when(
                httpService.post(any,
                    headers: anyNamed('headers'),
                    params: anyNamed('params'),
                    data: anyNamed('data')),
              ).thenAnswer(
                  (_) async => const HttpResponseModel(data: {"id": 1}));

              await sut.create(
                orderType: 'SALES_ORDER',
                firstName: 'firstName',
                lastName: 'lastName',
                mobileNumber: 'mobileNumber',
                email: 'email',
                stockNo: 'stockNo',
                make: 'make',
                year: 'year',
                model: 'model',
                color: 'color',
              );

              // Then
              final captured = verify(httpService.post(captureAny,
                      headers: captureAnyNamed('headers'),
                      params: captureAnyNamed('params'),
                      data: captureAnyNamed('data')))
                  .captured;

              expect(captured[3], expectedData);
            },
          );

          test(
            'Should return id',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('fofo');
              when(authService.token).thenReturn('fufu');
              when(authService.accountUid).thenReturn('fafa');
              when(
                httpService.post(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenAnswer(
                  (_) async => const HttpResponseModel(data: {"id": 1}));

              final result = await sut.create();

              // Then
              expect(result, 1);
            },
          );
        },
      );

      group(
        '.update()',
        () {
          test(
            '.put() Should called',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('fofo');
              when(authService.token).thenReturn('fofu');
              when(authService.accountUid).thenReturn('fafa');
              when(httpService.put(
                any,
                params: anyNamed('params'),
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer((_) async => const HttpResponseModel());

              await sut.update(
                id: 1,
                orderType: 'SALES_ORDER',
                firstName: 'firstName',
                lastName: 'lastName',
                mobileNumber: 'mobileNumber',
                email: 'email',
                stockNo: 'stockNo',
                make: 'make',
                year: 'year',
                model: 'model',
                color: 'color',
              );
              // Then

              verify(httpService.put(captureAny,
                      params: captureAnyNamed('params'),
                      data: captureAnyNamed('data'),
                      headers: captureAnyNamed('headers')))
                  .called(1);
            },
          );
          test(
            'Pass correct parameters',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);
              final expectedData = {
                'customerDTO': {
                  'firstName': 'firstName',
                  'lastName': 'lastName',
                  'mobileNumber': 'mobileNumber',
                  'email': 'email'
                },
                'vehicleDTO': {
                  'stockNo': 'stockNo',
                  'make': 'make',
                  'model': 'model',
                  'year': 'year',
                  'color': 'color'
                }
              };

              // When
              when(authService.sub).thenReturn('fofo');
              when(authService.token).thenReturn('fofu');
              when(authService.accountUid).thenReturn('fafa');
              when(httpService.put(
                any,
                params: anyNamed('params'),
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer((_) async => const HttpResponseModel());

              await sut.update(
                id: 1,
                orderType: 'SALES_ORDER',
                firstName: 'firstName',
                lastName: 'lastName',
                mobileNumber: 'mobileNumber',
                email: 'email',
                stockNo: 'stockNo',
                make: 'make',
                year: 'year',
                model: 'model',
                color: 'color',
              );
              // Then

              final captured = verify(httpService.put(captureAny,
                      params: captureAnyNamed('params'),
                      data: captureAnyNamed('data'),
                      headers: captureAnyNamed('headers')))
                  .captured;

              expect(captured[2], expectedData);
            },
          );
        },
      );

      group(
        '.validateJobServiceNumber()',
        () {
          test(
            '.get() Should called',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.accountUid).thenReturn('fafa');
              when(authService.token).thenReturn('as');
              when(httpService.post(
                any,
                params: anyNamed('params'),
                headers: anyNamed('headers'),
                data: anyNamed('data'),
              )).thenAnswer((_) async => const HttpResponseModel(data: true));

              await sut.validateJobServiceNumber('jobServiceNumber');

              // Then
              verify(httpService.post(any,
                      params: anyNamed('params'),
                      headers: anyNamed('headers'),
                      data: anyNamed('data')))
                  .called(1);
            },
          );

          test(
            'Return true if data is equal to r',
            () async {
              // Given
              const baseURL = 'https://httpbin.org/';
              final sut = RepairOrderServiceImpl(baseURL: baseURL);

              // When
              when(authService.accountUid).thenReturn('fafa');
              when(authService.token).thenReturn('as');
              when(httpService.post(
                any,
                params: anyNamed('params'),
                headers: anyNamed('headers'),
                data: anyNamed('data'),
              )).thenAnswer((_) async => const HttpResponseModel(data: true));

              final result = await sut.validateJobServiceNumber('jobServiceNumber');

              // Then
              expect(result, true);
            },
          );
        },
      );
    },
  );
}
