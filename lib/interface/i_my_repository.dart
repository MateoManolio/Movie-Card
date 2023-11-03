import '../shared/genre.dart';
import '../shared/movie.dart';

abstract class IMyRepository {
  Future<List<Movie>> loadMovies();

  Future<List<Genre>> loadGenres();
}
