import 'package:flutter/material.dart';
import 'package:movie_card/shared/circular_percent_indicator.dart';
import 'package:movie_card/shared/custom_card.dart';
import 'package:movie_card/shared/movie.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    super.key,
    required this.pad1,
    required this.movie,
  });

  final double pad1;
  final Movie movie;

  static const double opacity_1 = 0.75;
  static const double padCard = 8.0;

  static const double lineWidthPercentIndicator = 5.0;

  static const double radiusPercentIndicator = 20.0;
  static const double textGenderWidth = 70;

  static const double padTitle = 5;
  static const double padGenres = 10;
  static const double separation = 10;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(padCard),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomCard(
              padding: padTitle,
              child: ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate),
                textColor: Theme.of(context).colorScheme.background,
              ),
            ),
            const SizedBox(
              height: separation,
            ),
            CustomCard(
              padding: padGenres,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(padCard),
                    child: Padding(
                      padding: EdgeInsets.all(pad1),
                      child: CircularPercentIndicator(
                        percentIndicator: movie.score,
                        radiusPercentIndicator: radiusPercentIndicator,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: textGenderWidth,
                      child: Text(
                        movie.genres,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
