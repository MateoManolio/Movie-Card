import '../../domain/entity/movie.dart';

class MovieDetailsArguments {
  final Movie movie;
  final Function(Movie) setLastMovie;

  MovieDetailsArguments({
    required this.movie,
    required this.setLastMovie,
  });
}
