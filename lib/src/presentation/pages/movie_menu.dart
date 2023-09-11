import 'package:flutter/material.dart';
import '../../data/repository/my_local_repository.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_my_repository.dart';
import '../widgets/menu/header.dart';
import '../widgets/menu/last_seen.dart';
import '../widgets/menu/movies.dart';
import '../widgets/shared/error_class.dart';

class MovieMenu extends StatefulWidget {
  MovieMenu({
    required this.lastMovie,
    super.key,
  });

  static const String routeName = "/menu";
  Movie lastMovie;

  @override
  State<MovieMenu> createState() => _MovieMenuState();
}

class _MovieMenuState extends State<MovieMenu> {
  final IMyRepository repository = MyLocalRepository();
  late final Future<List<Movie>> _movies;

  @override
  void initState() {
    _movies = repository.loadMovies();
    super.initState();
  }

  static const double endPadding = 100;
  static const String messageError = "Missing movies";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Header(),
          LastSeen(
            movie: widget.lastMovie,
          ),
          FutureBuilder(
            future: _movies,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<Movie>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const CustomError(
                    message: messageError,
                  );
                } else {
                  return Movies(
                    movies: snapshot.data ?? <Movie>[],
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
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
