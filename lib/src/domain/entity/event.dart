import '../../core/util/enums.dart';

class Event<T> {
  final Status state;
  final T? data;
  final Exception? error;

  Event({
    required this.state,
    required this.data,
    required this.error,
  });

  factory Event.success(T data) => Event<T>(
        state: Status.success,
        data: data,
        error: null,
      );

  factory Event.error(Exception error) => Event<T>(
        state: Status.error,
        data: null,
        error: error,
      );

  factory Event.empty() => Event<T>(
        state: Status.empty,
        data: null,
        error: null,
      );

  factory Event.loading([T? data]) => Event<T>(
        state: Status.loading,
        data: data,
        error: null,
      );

  @override
  bool operator ==(Object other) {
    return other is Event && this.state == other.state;
  }
}
