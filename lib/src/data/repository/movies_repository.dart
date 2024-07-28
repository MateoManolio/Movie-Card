import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_my_repository.dart';
import '../datasource/local/movie_database.dart';

class MovieRepository {
  final IMyRepository repository;
  final MovieDatabase database;

  MovieRepository({
    required this.repository,
    required this.database,
  });

  Future _updateDataBase(Endpoint endpoint, int? page) async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      final DataState<List<Movie>> apiResponse =
          await repository.loadMoviesByType(endpoint, page.toString());
      if (apiResponse.state == Status.success) {
        apiResponse.data?.forEach(
          (Movie movie) {
            database.movieDao.insertNewMovie(movie, endpoint, page ?? 1);
          },
        );
      }
    }
  }

  Future<DataState<List<Movie>>> getMoviesByType(
    Endpoint endpoint,
    int? page,
  ) async {
    List<Movie> movies =
        await database.movieDao.findMovieByType(endpoint, page ?? 1);

    unawaited(_updateDataBase(endpoint, page));

    if (movies.isEmpty) {
      return await repository.loadMoviesByType(endpoint, page.toString());
    }

    return DataSuccess<List<Movie>>(
      data: movies,
    );
  }

  Future<Movie?> getMovieById(int movieId) async {
    return await database.movieDao.findMovieById(movieId);
  }

  Future<DataState<List<Movie>>> getSavedMovies() async =>
      DataSuccess<List<Movie>>(data: await database.movieDao.findSavedMovies());

  Future<DataState<List<Movie>>> getLikedMovies() async =>
      DataSuccess<List<Movie>>(data: await database.movieDao.findLikedMovies());

  void updateMovie(Movie movie) {
    database.movieDao.updateMovie(movie);
  }
}
