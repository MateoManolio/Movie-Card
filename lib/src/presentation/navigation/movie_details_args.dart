import '../../domain/entity/movie.dart';

class MovieDetailsArguments {
  final Movie movie;
  final Function(Movie) setLastMovie;
  final Function(Movie) updateMovie;
  final String posterTag;
  final String backdropTag;

  MovieDetailsArguments({
    required this.movie,
    required this.setLastMovie,
    required this.updateMovie,
    required this.backdropTag,
    required this.posterTag,
  });
}
