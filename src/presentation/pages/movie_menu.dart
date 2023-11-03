import 'package:flutter/material.dart';
import '../shared/error_class.dart';
import '../provider/my_local_repository.dart';
import '../interface/i_my_repository.dart';
import '../shared/movie.dart';
import '../widgets/menu/header.dart';
import '../widgets/menu/last_seen.dart';
import '../widgets/menu/movies.dart';

class MovieMenu extends StatefulWidget {
  MovieMenu({
    super.key,
    required this.lastMovie,
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                    message: "Missing movies",
                  );
                } else {
                  return Movies(
                    movies: snapshot.data ?? [],
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
