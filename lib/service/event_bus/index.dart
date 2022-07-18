import 'package:event_bus/event_bus.dart';
import 'package:truvideo_enterprise/service/event_bus/_interface.dart';

class EventBusServiceImpl extends EventBusService {
  final _eventBus = EventBus();

  @override
  void emit(data) {
    _eventBus.fire(data);
  }

  @override
  Stream<T> streamEvents<T>() {
    return _eventBus.on<T>();
  }
}
