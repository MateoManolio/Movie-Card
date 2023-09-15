import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/cast.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/load_cast_usecase.dart';

class CastBloc extends IBloc {

  final StreamController<Event<List<Cast>>> castStreamController =
  StreamController<Event<List<Cast>>>.broadcast();

  final IUseCase<Future<DataState<List<Cast>>>, Movie> _loadCast;

  CastBloc({
    IUseCase<Future<DataState<List<Cast>>>, Movie>? loadCast,
  })  :  _loadCast = loadCast ?? LoadCastUseCase();


  void loadCast(Movie movie) async {
    DataState<List<Cast>> cast = await _loadCast.call(movie);
    cast is DataSuccess
        ? castStreamController.sink.add(Event<List<Cast>>.success(cast.data!))
        : castStreamController.sink
        .addError(Event<List<Cast>>.error(cast.error!));
  }

  @override
  void dispose() {
    castStreamController.close();
  }

  @override
  Future<void> initialize() async {
    // nothing
  }

  Stream<Event<List<Cast>>> get castStream => castStreamController.stream;
}
