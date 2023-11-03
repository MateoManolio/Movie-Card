import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/bloc/i_bloc.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';

class MoviesBloc extends IBloc {
  final StreamController<Event<Movie>> _movieStreamController =
      StreamController<Event<Movie>>.broadcast();
  final StreamController<Event<List<Movie>>> popularStreamController =
      StreamController<Event<List<Movie>>>.broadcast();
  final StreamController<Event<List<Movie>>> nowPlayingStreamController =
      StreamController<Event<List<Movie>>>.broadcast();
  final StreamController<Event<List<Movie>>> upcomingStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  final IUseCase<Future<DataState<List<Movie>>>, Endpoint> getMoviesUseCase;
  final IUseCase<Future<Movie>, int> fetchFirstMovie;

  void getLastSeenMovie() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? movieId = prefs.getInt(lastMoviePreference);
    _movieStreamController.sink
        .add(Event<Movie>.success(await fetchFirstMovie.call(movieId!)));
  }

  void setLastMovie(Movie movie) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastMoviePreference, movie.id);
    _movieStreamController.sink.add(Event<Movie>.success(movie));
  }

  MoviesBloc({
    required this.fetchFirstMovie,
    required this.getMoviesUseCase,
  });

  @override
  void dispose() {
    _movieStreamController.close();
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
        DataState<List<Movie>> movies =
            await getMoviesUseCase.call(Endpoint.popular);
        updateStream(popularStreamController, movies);
      case Endpoint.nowPlaying:
        DataState<List<Movie>> movies =
            await getMoviesUseCase.call(Endpoint.nowPlaying);
        updateStream(nowPlayingStreamController, movies);
      case Endpoint.upcoming:
        DataState<List<Movie>> movies =
            await getMoviesUseCase.call(Endpoint.upcoming);
        updateStream(upcomingStreamController, movies);
    }
  }

  Stream<Event<List<Movie>>> get popularStream =>
      popularStreamController.stream;

  Stream<Event<List<Movie>>> get nowPlayingStream =>
      nowPlayingStreamController.stream;

  Stream<Event<List<Movie>>> get upcomingStream =>
      upcomingStreamController.stream;

  Stream<Event<Movie>> get movieStream => _movieStreamController.stream;

  @override
  Future<void> initialize() async {
    //nothing
  }
}
