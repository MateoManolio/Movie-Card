import 'package:flutter/material.dart';
import 'package:movie_card/shared/movie.dart';
import 'package:movie_card/shared/poster.dart';
import 'package:movie_card/shared/ui_consts.dart';
import 'package:movie_card/widgets/movie/movie_info.dart';

class MoviePresentation extends StatelessWidget {
  const MoviePresentation({
    super.key,
    required this.movie,
  });

  final Movie movie;

  static const double movieCardsContainerHeight = 0.5;
  static const double pad1 = 12.0;
  static const double posterPosition = 0;
  static const double posterWidth = 150.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * movieCardsContainerHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: Hero(
              tag: 'backdrop',
              child: Image(
                image: NetworkImage(movie.assetsBackdropPath),
                colorBlendMode: BlendMode.srcATop,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.maybePop(context);
                },
                color: colors.background,
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: posterPosition,
            child: Row(
              children: [
                Hero(
                  tag: 'movie',
                  child: Poster(
                    pad1: pad1,
                    posterName: movie.assetsPosterPath,
                    posterWidth: posterWidth,
                  ),
                ),
                MovieInfo(
                  pad1: pad1,
                  movie: movie,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
