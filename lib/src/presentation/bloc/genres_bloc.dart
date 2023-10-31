import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';

class GenresBloc extends IBloc {
  final StreamController<Event<List<Genre>>> _genreStreamController =
      StreamController<Event<List<Genre>>>.broadcast();
  final IUseCase<Future<DataState<List<Genre>>>, Movie> fetchGenresUseCase;

  GenresBloc({
    required this.fetchGenresUseCase,
  });

  Future<void> fetchGenres(Movie movie) async {
    _genreStreamController.sink.add(Event<List<Genre>>.loading());
    final DataState<List<Genre>> genresForOneMovie =
        await fetchGenresUseCase.call(movie);
    genresForOneMovie is DataSuccess
        ? _genreStreamController.sink.add(
            Event<List<Genre>>.success(genresForOneMovie.data!),
          )
        : _genreStreamController.sink.add(
            Event<List<Genre>>.error(genresForOneMovie.error!),
          );
  }

  @override
  void dispose() {
    _genreStreamController.close();
  }

  @override
  Future<void> initialize() async {
    // nothing
  }

  Stream<Event<List<Genre>>> get stream => _genreStreamController.stream;
}
