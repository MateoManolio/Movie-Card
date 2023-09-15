import 'package:flutter/material.dart';

import '../../core/util/enums.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movies_bloc.dart';
import '../widgets/loaders/last_seen_loader.dart';
import '../widgets/loaders/movies_loader.dart';
import '../widgets/menu/last_seen.dart';
import '../widgets/menu/movies.dart';
import '../widgets/shared/error_class.dart';

class MovieMenu extends StatefulWidget {
  MovieMenu({
    required this.moviesBloc,
    super.key,
  });

  final MoviesBloc moviesBloc;

  @override
  State<MovieMenu> createState() => _MovieMenuState();
}

class _MovieMenuState extends State<MovieMenu> {
  static const double endPadding = 100;
  static const String errorMessageLastSeen =
      'Error to bring the last seen movie';
  static const String errorMessage = 'Error to bring the movies';
  final MovieBloc _movieBloc = MovieBloc();

  @override
  void initState() {
    widget.moviesBloc.getMoviesByType(Endpoint.popular);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder<Event<Movie>>(
            initialData: Event<Movie>.success(
              _movieBloc.getMockMovie(),
            ),
            stream: _movieBloc.movieStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<Event<Movie>> snapshot,
            ) {
              switch (snapshot.data?.state) {
                case Status.loading:
                  return LastSeenLoader();
                case Status.empty:
                case Status.success:
                  return LastSeen(
                    movie: snapshot.data!.data!,
                    movieBloc: _movieBloc,
                  );
                case null:
                case Status.error:
                  return CustomError(
                    message: errorMessageLastSeen,
                  );
              }
            },
          ),
          StreamBuilder<Event<List<Movie>>>(
            stream: widget.moviesBloc.popularStream,
            initialData: Event<List<Movie>>.loading(),
            builder: (
              BuildContext context,
              AsyncSnapshot<Event<List<Movie>>> snapshot,
            ) {
              switch (snapshot.data?.state) {
                case Status.loading:
                  return MoviesLoader();
                case Status.empty:
                case Status.success:
                  return Movies(
                    movies: snapshot.data!.data!,
                    lastMovieBloc: _movieBloc,
                  );
                case null:
                case Status.error:
                  return CustomError(
                    message: errorMessage,
                  );
              }
            },
          ),
          const SizedBox(
            height: endPadding,
          ),
        ],
      ),
    );
  }
}
