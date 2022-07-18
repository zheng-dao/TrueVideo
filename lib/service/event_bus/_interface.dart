abstract class EventBusService {
  void emit(dynamic data);

  Stream<T> streamEvents<T>();
}
