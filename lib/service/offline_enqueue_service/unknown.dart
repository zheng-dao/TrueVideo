
import '_interface_item.dart';

class OfflineEnqueueUnknownServiceImpl extends OfflineEnqueueItemService {
  @override
  Future<void> onDelete(String uid) async {}

  @override
  Future<void> onDone(String uid) async {}

  @override
  Future<void> onError(String uid, error) async {}

  @override
  Future<void> onPending(String uid) async {}

  @override
  Future<void> onProcess(String uid) async {}

  @override
  Future<void> onRetry(String uid) async {}
}
