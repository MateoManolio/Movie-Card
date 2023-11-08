import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/bloc/i_bloc.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';

class SavedMoviesBloc extends IBloc {
  final StreamController<Event<List<Movie>>> _savedStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  final IUseCase<Future<DataState<List<Movie>>>, dynamic>
      fetchSavedMoviesUseCase;
  final IUseCase<Future<DataState<List<Movie>>>, dynamic>
      fetchLikedMoviesUseCase;

  SavedMoviesBloc({
    required this.fetchSavedMoviesUseCase,
    required this.fetchLikedMoviesUseCase,
  });

  Future<Option> get option async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? lastOption = prefs.getInt(lastOptionSelected);
    return Option.values.elementAt(lastOption ?? 0);
  }

  void setOption(Option option) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastOptionSelected, option.index);
  }

  @override
  void dispose() {
    _savedStreamController.close();
  }

  Future<void> getSavedMovies() async {
    final DataState<List<Movie>> movies = await fetchSavedMoviesUseCase.call();
    if (movies is DataSuccess) {
      _savedStreamController.add(
        movies.data!.isNotEmpty
            ? Event<List<Movie>>.success(movies.data!)
            : Event<List<Movie>>.empty(),
      );
    } else {
      _savedStreamController.addError(Event<List<Movie>>.error(movies.error!));
    }
  }

  Future<void> getLikedMovies() async {
    final DataState<List<Movie>> movies = await fetchLikedMoviesUseCase.call();
    if (movies is DataSuccess) {
      _savedStreamController.add(
        movies.data!.isNotEmpty
            ? Event<List<Movie>>.success(movies.data!)
            : Event<List<Movie>>.empty(),
      );
    } else {
      _savedStreamController.addError(Event<List<Movie>>.error(movies.error!));
    }
  }

  Stream<Event<List<Movie>>> get stream => _savedStreamController.stream;

  @override
  Future<void> initialize() async {
    // nothing
  }
}
