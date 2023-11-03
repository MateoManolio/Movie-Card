import 'package:flutter/material.dart';

import '../../navigation/movie_details_args.dart';
import '../../../config/route/app_routes.dart';
import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/movie.dart';
import '../shared/custom_card.dart';
import 'movie_details.dart';

class Movies extends StatelessWidget {
  const Movies({
    required this.movies,
    required this.setLastMovie,
    super.key,
  });

  final Function(Movie) setLastMovie;
  final List<Movie> movies;

  static const String title = "Movies";

  static const double borderPadding = 12.0;
  static const double posterPadding = 10;
  static const double width = 0.9;
  static const double height = 0.45;
  static const double topPadding = 20.0;
  static const double cardsPadding = 12.0;

  static const double posterWidth = 0.6;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: topPadding,
          ),
          child: Text(
            title,
            style: superTitleStyle,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.movieDetailsRouteName,
                  arguments: MovieDetailsArguments(
                    movie: movies[index],
                    setLastMovie: setLastMovie,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(cardsPadding),
                child: CustomCard(
                  padding: posterPadding,
                  child: MenuMovieDetails(
                    movie: movies[index],
                    posterWidth: MediaQuery.of(context).size.width *
                        height *
                        posterWidth,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
