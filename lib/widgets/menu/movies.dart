import 'package:flutter/material.dart';
import 'package:movie_card/pages/movie_details.dart';
import 'package:movie_card/shared/movie.dart';
import 'package:movie_card/shared/ui_consts.dart';
import 'package:movie_card/shared/custom_card.dart';
import 'package:movie_card/widgets/menu/movie_details.dart';

class Movies extends StatelessWidget {
  Movies({
    super.key,
    required this.movies,
    required this.filter,
  });

  bool filter;
  final List<Movie> movies;

  static const String title = "Movies";

  static const double borderPadding = 12.0;
  static const double posterPadding = 5;
  static const double width = 0.9;
  static const double height = 0.45;
  static const double topPadding = 20.0;

  static const double posterWidth = 0.6;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: topPadding),
          child: Text(
            title,
            style: superTitleStyle,
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetails.routeName,
                    arguments: movies[index],
                  );
                },
                child: CustomCard(
                  padding: posterPadding,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * width,
                    height: MediaQuery.of(context).size.width * height,
                    child: MenuMovieDetails(
                      movie: movies[index],
                      posterWidth: MediaQuery.of(context).size.width *
                          height *
                          posterWidth,
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
