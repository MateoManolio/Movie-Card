import 'package:flutter/material.dart';
import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/movie.dart';
import '../shared/circular_percent_indicator.dart';
import '../shared/poster.dart';

class MenuMovieDetails extends StatelessWidget {
  const MenuMovieDetails({
    required this.posterWidth,
    required this.movie,
    super.key,
  });

  final double posterWidth;
  final Movie movie;

  static const double separator = 20;
  static const double padding = 8.0;
  static const double radiusPercentIndicator = 30;
  static const double posterPadding = 0;
  static const double releaseDateSize = 15;
  static const String score = "Score";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Hero(
          tag: movie.posterName,
          child: Poster(
            posterPadding: posterPadding,
            posterName: movie.assetsPosterPath,
            posterWidth: posterWidth,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
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
              ),
              const SizedBox(
                height: separator,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
