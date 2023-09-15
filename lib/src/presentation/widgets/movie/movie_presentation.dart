import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/movie.dart';
import '../shared/poster.dart';
import 'movie_info.dart';

class MoviePresentation extends StatelessWidget {
  const MoviePresentation({
    required this.movie,
    super.key,
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
        children: <Widget>[
          Positioned(
            child: Hero(
              tag: movie.backdropName,
              child: CachedNetworkImage(
                imageUrl: movie.assetsBackdropPath,
                placeholder: (BuildContext context, String url) => CircularProgressIndicator(),
                errorWidget: (BuildContext context, String url, Object error) => Icon(Icons.error),
                colorBlendMode: BlendMode.srcATop,
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
                  Navigator.pop(
                    context,
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
              children: <Widget>[
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
