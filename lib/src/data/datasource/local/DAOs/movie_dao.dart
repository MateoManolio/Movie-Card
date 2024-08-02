import 'package:floor/floor.dart';

import '../../../../domain/entity/movie_category.dart';
import '../../../../core/util/enums.dart';
import '../../../../domain/entity/movie.dart';

@dao
abstract class MovieDao {
  @Query(
    'SELECT * FROM Movie m where EXISTS( SELECT 1 FROM MovieCategory c WHERE m.id = c.movieId AND c.page = :page)',
  )
  Future<List<Movie>> findAllMoviesPage(int page);

  @Query('SELECT * FROM Movie WHERE id = :id')
  Future<Movie?> findMovieById(int id);

  @Query(
    'SELECT * FROM Movie m WHERE EXISTS( SELECT 1 FROM MovieCategory c WHERE m.id = c.movieId AND c.category = :type AND c.page = :page)',
  )
  Future<List<Movie>> findMovieByType(Endpoint type, int page);

  @Query('SELECT * FROM Movie WHERE saved = true')
  Future<List<Movie>> findSavedMovies();

  @Query('SELECT * FROM Movie WHERE liked = true')
  Future<List<Movie>> findLikedMovies();

  @Query('SELECT * FROM Movie WHERE title LIKE :title')
  Future<List<Movie>> searchMovies(String title);

  @insert
  Future<void> insertMovie(Movie movie);

  @insert
  Future<void> insertMovieCategory(MovieCategory movieCategory);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMovie(Movie movie);

  Future<void> insertNewMovie(Movie movie, Endpoint endpoint, int page) async {
    await insertMovieCategory(
      MovieCategory(
        category: endpoint,
        movieId: movie.id,
        page: page,
      ),
    );
    await insertMovie(movie);
  }
}
