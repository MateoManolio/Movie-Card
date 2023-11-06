import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../config/route/app_routes.dart';
import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/movie.dart';
import '../../navigation/movie_details_args.dart';
import '../loaders/last_seen_loader.dart';
import '../shared/text_over_things.dart';

class LastSeen extends StatelessWidget {
  const LastSeen({
    required this.movie,
    required this.setLastMovie,
    required this.updateMovie,
    super.key,
  });

  final Movie movie;
  final Function(Movie) setLastMovie;
  final Function(Movie) updateMovie;

  static const String title = "Last seen";
  static const String asset = 'assets/error/default_backdrop.jpeg';
  static const double borderRadius = 9;
  static const double sidePadding = 10;
  static const double textSidePadding = sidePadding + 5;
  static const double bottomPadding = 12;
  static const double titlePadding = 12;
  static const double fontSizeTitle = 28;
  static const double fontSizeDate = 20;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
              Routes.movieDetailsRouteName,
              arguments: MovieDetailsArguments(
                movie: movie,
                setLastMovie: setLastMovie,
                backdropTag: movie.backdropName,
                posterTag: '',
                updateMovie: updateMovie,
              ),
            );
          },
          child: Stack(
            children: <Widget>[
              Hero(
                tag: movie.backdropName,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: sidePadding),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: CachedNetworkImage(
                      imageUrl: movie.assetsBackdropPath,
                      placeholder: (
                        BuildContext context,
                        String url,
                      ) =>
                          LastSeenLoader(),
                      errorWidget: (
                        BuildContext context,
                        String url,
                        Object error,
                      ) =>
                          Image.asset(asset),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: bottomPadding,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: textSidePadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextOverThings(
                        title: movie.title,
                        fontSize: fontSizeTitle,
                      ),
                      const SizedBox(
                        width: sidePadding,
                      ),
                      TextOverThings(
                        title: movie.releaseDate,
                        fontSize: fontSizeDate,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
