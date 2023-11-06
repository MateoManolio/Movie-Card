import 'package:floor/floor.dart';

@Entity(primaryKeys: <String>['genreId', 'movieId'])
class MovieGenre {
  final int genreId;
  final int movieId;

  MovieGenre({
    required this.genreId,
    required this.movieId,
  });
}
