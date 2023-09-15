import 'enums.dart';

class DataState<T> {
  late final Status state;
  final T? data;
  final Exception? error;

  DataState({
    required this.state,
    required this.data,
    required this.error,
  });
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({
    required T data,
  }) : super(
          state: Status.success,
          data: data,
          error: null,
        );
}

class DataFailure<T> extends DataState<T> {
  DataFailure({
    required Exception error,
  }) : super(
          state: Status.error,
          data: null,
          error: error,
        );
}
