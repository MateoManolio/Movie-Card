import 'package:floor/floor.dart';

import '../../../../domain/entity/genre.dart';
import '../../../../domain/entity/movie.dart';
import '../../../../domain/entity/movie_genre.dart';

@dao
abstract class GenreDao {
  @Query('SELECT * FROM Genre')
  Future<List<Genre>> getAllGenres();

  @Query(
    'SELECT * FROM Genre g WHERE EXISTS( SELECT 1 FROM MovieGenre m WHERE m.genreId = g.id AND m.movieId = :movieId )',
  )
  Future<List<Genre>> getGenreByMovie(int movieId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGenre(Genre genre);

  @insert
  Future<void> insertMovieGenre(MovieGenre movieGenre);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateGenre(Genre genre);

  void insertGenreWithMovie(
    Genre genre,
    Movie movie,
  ) {
    insertGenre(genre);
    if (movie.genres.contains(genre.id)) {
      insertMovieGenre(
        MovieGenre(
          genreId: genre.id,
          movieId: movie.id,
        ),
      );
    }
  }
}
