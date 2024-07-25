import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/cast.dart';
import '../../domain/entity/event.dart';

class MovieDetailsBloc extends IBloc {
  final StreamController<Event<List<Cast>>> castStreamController =
      StreamController<Event<List<Cast>>>.broadcast();

  final IUseCase<Future<DataState<List<Cast>>>, int> loadCastUseCase;

  MovieDetailsBloc({
    required this.loadCastUseCase,
  });

  @override
  void dispose() {
    castStreamController.close();
  }

  @override
  Future<void> initialize() async {
    // nothing
  }

  void loadCast(int movieId) async {
    DataState<List<Cast>> cast = await loadCastUseCase.call(movieId);
    cast is DataSuccess
        ? castStreamController.sink.add(Event<List<Cast>>.success(cast.data!))
        : castStreamController.sink
            .addError(Event<List<Cast>>.error(cast.error!));
  }

  Stream<Event<List<Cast>>> get castStream => castStreamController.stream;
}
