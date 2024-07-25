import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_my_repository.dart';
import '../datasource/local/movie_database.dart';

class GenreRepository {
  final IMyRepository repository;
  final MovieDatabase database;

  GenreRepository({
    required this.repository,
    required this.database,
  });

  Future<DataState<List<Genre>>> loadGenres() async {
    return await repository.loadGenres();
  }

  Future _updateDataBase(Movie movie) async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      final DataState<List<Genre>> apiResponse = await loadGenres();
      if (apiResponse.state == Status.success) {
        apiResponse.data?.forEach(
          (Genre genre) => database.genreDao.insertGenreWithMovie(
            genre,
            movie,
          ),
        );
      }
    }
  }

  Future<DataState<List<Genre>>> getGenreForMovie(Movie movie) async {
    List<Genre> genres = await database.genreDao.getGenreByMovie(movie.id);

    if (genres.isEmpty) {
      await _updateDataBase(movie);
      genres = await database.genreDao.getGenreByMovie(movie.id);
    } else {
      unawaited(_updateDataBase(movie));
    }
    return DataSuccess<List<Genre>>(
      data: genres,
    );
  }
}
