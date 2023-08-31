import 'package:flutter/material.dart';
import 'package:movie_card/pages/movie_details.dart';
import 'package:movie_card/shared/movie.dart';
import 'package:movie_card/shared/ui_consts.dart';

class LastSeen extends StatelessWidget {
  const LastSeen({super.key, required this.movie});

  final Movie movie;

  static const String title = "Last seen";
  static const double borderRadius = 20;
  static const double sidePadding = 15;
  static const double bottomPadding = 12;
  static const double titlePadding = 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(titlePadding),
          child: Text(
            title,
            style: titleStyle,
            textAlign: TextAlign.left,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              MovieDetails.routeName,
              arguments: movie,
            );
          },
          child: Stack(children: [
            Hero(
              tag: 'backdrop',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.network(
                  movie.assetsBackdropPath,
                ),
              ),
            ),
            Positioned(
              bottom: bottomPadding,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: sidePadding,
                  right: sidePadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie.title,
                      style: titleStyle,
                    ),
                    const SizedBox(
                      width: sidePadding,
                    ),
                    Text(
                      movie.releaseDate,
                      style: subtitleStyle,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
