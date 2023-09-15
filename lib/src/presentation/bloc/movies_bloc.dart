import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/now_playing_usecase.dart';
import '../../domain/usecase/popular_movies_usecase.dart';
import '../../domain/usecase/upcoming_usecase.dart';

class MoviesBloc extends IBloc {
  final StreamController<Event<List<Movie>>> popularStreamController =
      StreamController<Event<List<Movie>>>.broadcast();
  final StreamController<Event<List<Movie>>> nowPlayingStreamController =
  StreamController<Event<List<Movie>>>.broadcast();
  final StreamController<Event<List<Movie>>> upcomingStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  final IUseCase<Future<DataState<List<Movie>>>, dynamic> _getPopularMovies;
  final IUseCase<Future<DataState<List<Movie>>>, dynamic> _getNowPlayingMovies;
  final IUseCase<Future<DataState<List<Movie>>>, dynamic> _getUpcomingMovies;

  MoviesBloc({
    IUseCase<Future<DataState<List<Movie>>>, dynamic>? getPopularMovies,
    IUseCase<Future<DataState<List<Movie>>>, dynamic>? getNowPlayingMovies,
    IUseCase<Future<DataState<List<Movie>>>, dynamic>? getUpcomingMovies,
  })  : _getPopularMovies = getPopularMovies ?? PopularMoviesUseCase(),
        _getNowPlayingMovies = getNowPlayingMovies ?? NowPlayingUseCase(),
        _getUpcomingMovies = getUpcomingMovies ?? UpcomingUseCase();

  @override
  void dispose() {
    popularStreamController.close();
    nowPlayingStreamController.close();
    upcomingStreamController.close();
  }

  void updateStream(
    StreamController<Event<List<Movie>>> streamController,
    DataState<List<Movie>> data,
  ) {
    if (data is DataSuccess) {
      streamController.add(
        data.data!.isNotEmpty
            ? Event<List<Movie>>.success(data.data!)
            : Event<List<Movie>>.empty(),
      );
    } else {
      streamController.addError(Event<List<Movie>>.error(data.error!));
    }
  }

  Future<void> getMoviesByType(Endpoint endpoint) async {
    switch (endpoint) {
      case Endpoint.popular:
        DataState<List<Movie>> movies = await _getPopularMovies.call();
        updateStream(popularStreamController, movies);
      case Endpoint.nowPlaying:
        DataState<List<Movie>> movies = await _getNowPlayingMovies.call();
        updateStream(nowPlayingStreamController, movies);
      case Endpoint.upcoming:
        DataState<List<Movie>> movies = await _getUpcomingMovies.call();
        updateStream(upcomingStreamController, movies);
    }
  }

  Stream<Event<List<Movie>>> get popularStream =>
      popularStreamController.stream;

  Stream<Event<List<Movie>>> get nowPlayingStream =>
      nowPlayingStreamController.stream;

  Stream<Event<List<Movie>>> get upcomingStream =>
      upcomingStreamController.stream;

  @override
  Future<void> initialize() async {
    //nothing
  }
}
