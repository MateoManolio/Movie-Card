import '../../core/util/enums.dart';
import '../../core/util/data_state.dart';
import '../entity/cast.dart';
import '../entity/genre.dart';
import '../entity/movie.dart';

abstract class IMyRepository {
  Future<DataState<List<Movie>>> loadMoviesByType(
    Endpoint endpoint, [
    String? page,
  ]);
  Future<DataState<List<Genre>>> loadGenres();
  Future<DataState<List<Cast>>> loadCast(int? movieId);
  Future<DataState<List<Movie>>> searchMovies(String query);
}
