import 'package:flutter/material.dart';
import '../../pages/movie_details.dart';
import '../../shared/movie.dart';
import '../../shared/ui_consts.dart';
import '../../shared/custom_card.dart';
import 'movie_details.dart';

class Movies extends StatelessWidget {
  Movies({
    super.key,
    required this.movies,
  });

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
      children: [
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
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetails(
                      movie: movies[index],
                    ),
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
