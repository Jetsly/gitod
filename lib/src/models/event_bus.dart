import 'dart:async';

class EventBus {
  static EventBus _eventBus = new EventBus();
  static EventBus getInstance(){
    return EventBus._eventBus;
  }

  StreamController _streamController;

  /// Controller for the event bus stream.
  StreamController get streamController => _streamController;

  /// new event bus
  EventBus({bool sync: false}) {
    _streamController = new StreamController.broadcast(sync: sync);
  }

  ///Listener
  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  /// Fires a new event on the event bus with the specified [event].
  void fire(event) {
    streamController.add(event);
  }

  /// Destroy this [EventBus]. This is generally only in a testing context.
  void destroy() {
    _streamController.close();
  }
}
