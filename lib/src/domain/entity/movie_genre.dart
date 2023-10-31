import 'package:floor/floor.dart';

import 'genre.dart';
import 'movie.dart';

@Entity(
  primaryKeys: <String>['genreId', 'movieId'],
  foreignKeys: <ForeignKey>[
    ForeignKey(
      childColumns: <String>['genreId'],
      parentColumns: <String>['id'],
      entity: Genre,
    ),
    ForeignKey(
      childColumns: <String>['movieId'],
      parentColumns: <String>['id'],
      entity: Movie,
    ),
  ],
)
class MovieGenre {
  final int genreId;
  final int movieId;

  MovieGenre({
    required this.genreId,
    required this.movieId,
  });
}
