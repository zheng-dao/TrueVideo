
abstract class OfflineEnqueueItemService {
  Future<void> onPending(String uid);

  Future<void> onProcess(String uid);

  Future<void> onDone(String uid);

  Future<void> onError(String uid, dynamic error);

  Future<void> onRetry(String uid);

  Future<void> onDelete(String uid);
}
