import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart';

abstract class OfflineEnqueueService {
  Future<void> startService();

  Future<OfflineEnqueueItemModel?> getByUID(String uid);

  Future<OfflineEnqueueItemModel> enqueue(OfflineEnqueueItemModel model);

  Future<void> update(OfflineEnqueueItemModel model);

  Future<void> delete(String uid);

  Future<void> retry(String uid);

  Stream<OfflineEnqueueItemModel?> streamByUID(String uid);

  Stream<List<OfflineEnqueueItemModel>> stream({
    List<OfflineEnqueueItemType> type = const <OfflineEnqueueItemType>[],
    List<OfflineEnqueueItemStatus> status = const <OfflineEnqueueItemStatus>[],
  });

  Future<List<OfflineEnqueueItemModel>> getAll({
    List<OfflineEnqueueItemType> type = const <OfflineEnqueueItemType>[],
    List<OfflineEnqueueItemStatus> status = const <OfflineEnqueueItemStatus>[],
  });
}
