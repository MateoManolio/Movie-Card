import 'package:flutter/material.dart';
import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/movie.dart';
import '../shared/circular_percent_indicator.dart';
import '../shared/poster.dart';

class MenuMovieDetails extends StatelessWidget {
  const MenuMovieDetails({
    super.key,
    required this.posterWidth,
    required this.movie,
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
      children: [
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
              ),
              const SizedBox(
                height: separator,
              )
            ],
          ),
        ),
      ],
    );
  }
}
