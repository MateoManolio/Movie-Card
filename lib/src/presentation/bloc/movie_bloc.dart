import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/cast.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/fetch_last_seen_movie_usecase.dart';
import '../../domain/usecase/load_cast_usecase.dart';

class MovieBloc extends IBloc {
  final StreamController<Event<Movie>> _movieStreamController =
      StreamController<Event<Movie>>.broadcast();

  final IUseCase<Movie, dynamic> _fetchFirstMovie;

  MovieBloc({
    IUseCase<Movie, dynamic>? fetchFirstMovie,
  })  : _fetchFirstMovie = fetchFirstMovie ?? FetchLastSeenMovieUseCase();

  Movie getMockMovie() {
    return _fetchFirstMovie.call();
  }

  void setLastMovie(Movie movie) {
    _movieStreamController.sink.add(Event<Movie>.success(movie));
  }

  @override
  void dispose() {
    _movieStreamController.close();
  }

  @override
  Future<void> initialize() async {
    // nothing
  }

  Stream<Event<Movie>> get movieStream => _movieStreamController.stream;
}
