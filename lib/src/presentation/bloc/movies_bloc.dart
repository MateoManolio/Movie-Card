import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/bloc/i_bloc.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../core/util/debouncer.dart';
import '../../core/util/enums.dart';
import '../../core/util/movies_by_type_params.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';

class MoviesBloc extends IBloc {
  final StreamController<Event<Movie?>> _movieStreamController =
      StreamController<Event<Movie>>.broadcast();
  final StreamController<Event<List<Movie>>> popularStreamController =
      StreamController<Event<List<Movie>>>.broadcast();
  final StreamController<Event<List<Movie>>> nowPlayingStreamController =
      StreamController<Event<List<Movie>>>.broadcast();
  final StreamController<Event<List<Movie>>> upcomingStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  final IUseCase<Future<DataState<List<Movie>>>, MoviesByTypeParams>
      getMoviesUseCase;
  final IUseCase<Future<Movie?>, int> fetchFirstMovie;
  final IUseCase<void, Movie> updateMovieUseCase;

  final Debouncer debouncer = Debouncer(milliseconds: 1000);

  final List<Movie> _allMovies = <Movie>[];

  void getLastSeenMovie() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? movieId = prefs.getInt(lastMoviePreference);
    final Movie? movie =
        await fetchFirstMovie.call(movieId != null ? movieId : 0);

    _movieStreamController.sink.add(
      movie == null
          ? Event<Movie>.empty()
          : Event<Movie>.success(
              movie,
            ),
    );
  }

  void setLastMovie(Movie movie) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastMoviePreference, movie.id);
    _movieStreamController.sink.add(Event<Movie>.success(movie));
  }

  MoviesBloc({
    required this.fetchFirstMovie,
    required this.getMoviesUseCase,
    required this.updateMovieUseCase,
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

  void switchUpdateStream(Endpoint endpoint, DataState<List<Movie>> movies) {
    switch (endpoint) {
      case Endpoint.popular:
        updateStream(popularStreamController, movies);
      case Endpoint.nowPlaying:
        updateStream(nowPlayingStreamController, movies);
      case Endpoint.upcoming:
        updateStream(upcomingStreamController, movies);
    }
  }

  void _fetchMoviesByType(MoviesByTypeParams params) async {
    try {
      final DataState<List<Movie>> newMoviesData =
          await getMoviesUseCase.call(params);
      if (newMoviesData is DataSuccess) {
        final List<Movie> newMovies = newMoviesData.data!;
        _allMovies.addAll(newMovies);
        switchUpdateStream(
          params.endpoint,
          DataSuccess(data: _allMovies),
        );
      } else if (newMoviesData is DataFailure) {
        switchUpdateStream(
          params.endpoint,
          DataFailure(error: newMoviesData.error!),
        );
      }
    } catch (e) {
      switchUpdateStream(
        params.endpoint,
        DataFailure(error: Exception(e.toString())),
      );
    }
  }

  Future<void> getMoviesByType(Endpoint endpoint, int page) async {
    final MoviesByTypeParams params =
        MoviesByTypeParams(endpoint: endpoint, page: page);
    if (page == 1) {
      _fetchMoviesByType(params);
    } else {
      debouncer.run(() async {
        _fetchMoviesByType(params);
      });
    }
  }

  void updateMovie(Movie movie) => updateMovieUseCase.call(movie);

  Stream<Event<List<Movie>>> get popularStream =>
      popularStreamController.stream;

  Stream<Event<List<Movie>>> get nowPlayingStream =>
      nowPlayingStreamController.stream;

  Stream<Event<List<Movie>>> get upcomingStream =>
      upcomingStreamController.stream;

  Stream<Event<Movie?>> get movieStream => _movieStreamController.stream;

  @override
  Future<void> initialize() async {
    //nothing
  }
}
