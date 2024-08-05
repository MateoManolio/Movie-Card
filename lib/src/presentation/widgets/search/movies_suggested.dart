import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../config/route/app_routes.dart';
import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/movie.dart';
import '../../navigation/movie_details_args.dart';

class MoviesSuggested {
  static const double sidePadding = 40.0;
  static const double verticalPadding = 10.0;

  final Function(Movie) setLastMovie;
  final Function(Movie) updateMovie;

  MoviesSuggested({
    required this.setLastMovie,
    required this.updateMovie,
  });

  List<Widget> build(
    List<Movie> movies,
    List<Movie>? filteredMovies,
    BuildContext context,
  ) {
    if (filteredMovies == null) {
      filteredMovies = <Movie>[];
    }
    return List<Widget>.generate(
      filteredMovies.isNotEmpty ? filteredMovies.length : movies.length,
      (int index) {
        final Movie movie =
            filteredMovies!.isNotEmpty ? filteredMovies[index] : movies[index];
        return Padding(
          padding: const EdgeInsets.only(top: verticalPadding),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    Routes.movieDetailsRouteName,
                    arguments: MovieDetailsArguments(
                      movie: movie,
                      setLastMovie: setLastMovie,
                      backdropTag: '',
                      posterTag: movie.assetsBackdropPath,
                      updateMovie: updateMovie,
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    movie.title,
                    style: TextStyle(color: colors.background),
                  ),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                      movie.assetsPosterPath,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: sidePadding,
                  right: sidePadding,
                  top: verticalPadding,
                ),
                child: Divider(
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
