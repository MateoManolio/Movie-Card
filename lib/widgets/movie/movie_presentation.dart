import 'package:flutter/material.dart';
import '../../pages/home_page.dart';
import '../../shared/movie.dart';
import '../../shared/poster.dart';
import '../../shared/ui_consts.dart';
import 'movie_info.dart';

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
              tag: movie.backdropName,
              child: Image(
                image: NetworkImage(
                  movie.assetsBackdropPath,
                ),
                colorBlendMode: BlendMode.srcATop,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Positioned(
            child: SafeArea(
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        lastMovie: movie,
                      ),
                    ),
                  );
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
                  tag: movie.posterName,
                  child: Poster(
                    posterPadding: pad1,
                    posterName: movie.assetsPosterPath,
                    posterWidth: posterWidth,
                  ),
                ),
                MovieInfo(
                  padGenresCard: pad1,
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
