import 'package:floor/floor.dart';

import '../../../../domain/entity/movie_category.dart';
import '../../../../core/util/enums.dart';
import '../../../../domain/entity/movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie')
  Future<List<Movie>> findAllMovies();

  @Query('SELECT * FROM Movie WHERE id = :id')
  Future<Movie?> findMovieById(int id);

  @Query('SELECT * FROM Movie m WHERE EXISTS( SELECT 1 FROM MovieCategory c WHERE m.id = c.movieId AND c.category = :type )')
  Future<List<Movie>> findMovieByType(Endpoint type);

  @Query('SELECT * FROM Movie WHERE saved = true')
  Future<List<Movie>> findSavedMovies();

  @Query('SELECT * FROM Movie WHERE liked = true')
  Future<List<Movie>> findLikedMovies();

  @insert
  Future<void> insertMovie(Movie movie);

  @insert
  Future<void> insertMovieCategory(MovieCategory movieCategory);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMovie(Movie movie);

  Future<void> insertNewMovie(Movie movie, Endpoint endpoint) async {
    await insertMovieCategory(
      MovieCategory(
        category: endpoint,
        movieId: movie.id,
      ),
    );
    await insertMovie(movie);
  }
}
