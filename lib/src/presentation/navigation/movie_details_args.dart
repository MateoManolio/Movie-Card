import '../../domain/entity/movie.dart';

class MovieDetailsArguments {
  final Movie movie;
  final Function(Movie) setLastMovie;
  final String posterTag;
  final String backdropTag;

  MovieDetailsArguments({
    required this.movie,
    required this.setLastMovie,
    required this.backdropTag,
    required this.posterTag,
  });
}
