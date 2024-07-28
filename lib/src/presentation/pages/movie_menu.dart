import 'package:flutter/material.dart';

import '../../core/util/enums.dart';
import '../../core/util/function_called_when_bottom_reached.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';
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

class _MovieMenuState extends State<MovieMenu>
    with AutomaticKeepAliveClientMixin, FunctionCallWhenBottomReached {
  late int _currentPage;

  static const double endPadding = 130;
  static const String errorMessageLastSeen =
      'Error to bring the last seen movie';
  static const String errorMessage = 'Error to bring the movies';

  Widget finalWidget = CircularProgressIndicator();

  @override
  void initState() {
    _currentPage = 1;
    super.initState();
    widget.moviesBloc.getLastSeenMovie();
    widget.moviesBloc.getMoviesByType(Endpoint.popular, _currentPage);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void onReachBottom() {
    _currentPage++;
    widget.moviesBloc.getMoviesByType(Endpoint.popular, _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    listenToScrollController();
    return SingleChildScrollView(
      controller: bottomReachedScrollController,
      child: Column(
        children: <Widget>[
          StreamBuilder<Event<Movie?>>(
            stream: widget.moviesBloc.movieStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<Event<Movie?>> snapshot,
            ) {
              switch (snapshot.data?.state) {
                case Status.loading:
                  return LastSeenLoader();
                case Status.empty:
                  return Container();
                case Status.success:
                  return LastSeen(
                    movie: snapshot.data!.data!,
                    setLastMovie: (Movie movie) =>
                        widget.moviesBloc.setLastMovie(movie),
                    updateMovie: (Movie movie) =>
                        widget.moviesBloc.updateMovie(movie),
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
                case Status.empty:
                  return MoviesLoader();
                case Status.success:
                  return Movies(
                    movies: snapshot.data!.data!,
                    setLastMovie: (Movie movie) =>
                        widget.moviesBloc.setLastMovie(movie),
                    updateMovie: (Movie movie) =>
                        widget.moviesBloc.updateMovie(movie),
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
            height: 20,
          ),
          finalWidget,
          const SizedBox(
            height: endPadding,
          ),
        ],
      ),
    );
  }
}
