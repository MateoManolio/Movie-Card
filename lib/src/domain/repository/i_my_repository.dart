
import '../entity/genre.dart';
import '../entity/movie.dart';

abstract class IMyRepository {
  Future<List<Movie>> loadMovies();

  Future<List<Genre>> loadGenres();
}
