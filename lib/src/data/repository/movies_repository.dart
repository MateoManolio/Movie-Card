import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/movie_model.dart';
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

  Future<DataState<List<Movie>>> getMoviesByType(Endpoint endpoint) async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      final DataState<List<Movie>> apiResponse =
      await repository.loadMoviesByType(endpoint);
      if (apiResponse.state == Status.success) {
        apiResponse.data?.forEach(
              (Movie movie) {
            database.movieDao.insertNewMovie(movie, endpoint);
          },
        );
      }
    }
    return DataSuccess<List<Movie>>(
      data: await database.movieDao.findMovieByType(endpoint),
    );
  }

Future<Movie> getMovieById(int? movieId) async {
  return await database.movieDao.findMovieById(movieId!) ?? MovieModel.mockMovie();
}


}
