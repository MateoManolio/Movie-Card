import '../bloc/movie_bloc.dart';
import '../../domain/entity/movie.dart';

class MovieDetailsArguments {
  final Movie movie;
  final MovieBloc bloc;

  MovieDetailsArguments({
    required this.movie,
    required this.bloc,
  });
}
