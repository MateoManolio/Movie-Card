import 'package:flutter/material.dart';
import 'package:movie_card/shared/movie.dart';
import 'package:movie_card/shared/ui_consts.dart';
import 'package:movie_card/shared/poster.dart';
import 'package:movie_card/shared/circular_percent_indicator.dart';

class MenuMovieDetails extends StatelessWidget {
  const MenuMovieDetails({
    super.key,
    required this.posterWidth,
    required this.movie,
  });

  final double posterWidth;
  final Movie movie;

  static const double separator = 40;
  static const double padding = 8.0;
  static const double radiusPercentIndicator = 30;
  static const double posterPadding = 0;
  static const double releaseDateSize = 15;
  static const String score = "Score";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Hero(
          tag: 'poster',
          child: Poster(
            pad1: posterPadding,
            posterName: movie.assetsPosterPath,
            posterWidth: posterWidth,
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(padding),
              child: Text(
                movie.title,
                style: titleStyle,
              ),
            ),
            Text(
              movie.releaseDate,
              style: TextStyle(
                color: colors.background,
                fontSize: releaseDateSize,
              ),
            ),
            const SizedBox(
              height: separator,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  score,
                  style: subtitleStyle,
                ),
                const SizedBox(
                  width: separator,
                ),
                CircularPercentIndicator(
                  percentIndicator: movie.score,
                  radiusPercentIndicator: radiusPercentIndicator,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
