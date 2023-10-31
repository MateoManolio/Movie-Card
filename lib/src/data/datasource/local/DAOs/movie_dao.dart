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

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertMovie(Movie movie);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertMovieCategory(MovieCategory movieCategory);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMovie(Movie movie);

  void insertNewMovie(Movie movie, Endpoint endpoint) {
    insertMovie(movie);
    insertMovieCategory(
      MovieCategory(
        category: endpoint,
        movieId: movie.id,
      ),
    );
  }
}
