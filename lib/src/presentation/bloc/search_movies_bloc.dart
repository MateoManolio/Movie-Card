import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';

class SearchMoviesBloc extends IBloc {
  final StreamController<Event<List<Movie>>> _searchStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  final StreamController<Event<List<Movie>>> _searchAllMoviesStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  final IUseCase<Future<DataState<List<Movie>>>, String> searchMoviesUseCase;

  final IUseCase<Future<DataState<List<Movie>>>, int?>
      fetchAllMoviesMoviesUseCase;

  SearchMoviesBloc({
    required this.searchMoviesUseCase,
    required this.fetchAllMoviesMoviesUseCase,
  });

  Stream<Event<List<Movie>>> get searchStream => _searchStreamController.stream;

  Stream<Event<List<Movie>>> get searchAllMoviesStream =>
      _searchAllMoviesStreamController.stream;

  Future<void> searchMovies(String query) async {
    final DataState<List<Movie>> movies = await searchMoviesUseCase.call(query);
    if (movies is DataSuccess) {
      movies.data!.sort((Movie a, Movie b) => b.score.compareTo(a.score));
      _searchStreamController.add(
        movies.data!.isNotEmpty
            ? Event<List<Movie>>.success(movies.data!)
            : Event<List<Movie>>.empty(),
      );
    } else {
      _searchStreamController.addError(Event<List<Movie>>.error(movies.error!));
    }
  }

  Future<void> fetchAllMovies() async {
    final DataState<List<Movie>> movies =
        await fetchAllMoviesMoviesUseCase.call(1);
    if (movies is DataSuccess) {
      _searchAllMoviesStreamController.add(
        movies.data!.isNotEmpty
            ? Event<List<Movie>>.success(movies.data!)
            : Event<List<Movie>>.empty(),
      );
    } else {
      _searchStreamController.addError(Event<List<Movie>>.error(movies.error!));
    }
  }

  @override
  void dispose() {
    _searchStreamController.close();
  }

  @override
  Future<void> initialize() async => null;
}
