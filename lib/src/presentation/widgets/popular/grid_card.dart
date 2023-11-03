import 'package:flutter/material.dart';

import '../../../config/route/app_routes.dart';
import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/movie.dart';
import '../../navigation/movie_details_args.dart';
import '../shared/cache_image.dart';
import '../shared/custom_card.dart';

class GridCard extends StatefulWidget {
  final Movie movie;
  final Function(Movie) setLastMovie;

  const GridCard({
    required this.setLastMovie,
    required this.movie,
    super.key,
  });

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
  late bool isLiked;
  late bool isSaved;

  static const double posterRadius = 8;
  static const double spacePosterButtons = 9.5;
  static const double avatarColorOpacity = 0.5;
  static const double padding = 5;

  @override
  void initState() {
    isLiked = widget.movie.liked;
    isSaved = widget.movie.saved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomCard(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.movieDetailsRouteName,
                  arguments: MovieDetailsArguments(
                    movie: widget.movie,
                    setLastMovie: widget.setLastMovie,
                    backdropTag: '',
                    posterTag: widget.movie.posterName,
                  ),
                );
              },
              child: Hero(
                tag: widget.movie.posterName,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(posterRadius),
                    topRight: Radius.circular(posterRadius),
                  ),
                  child: CacheImage(
                    url: widget.movie.assetsPosterPath,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: spacePosterButtons,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor:
                      colors.secondary.withOpacity(avatarColorOpacity),
                  child: IconButton(
                    onPressed: () => setState(() => isLiked = !isLiked),
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                      color: isLiked ? Colors.redAccent : Colors.white70,
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor:
                      colors.secondary.withOpacity(avatarColorOpacity),
                  child: IconButton(
                    onPressed: () => setState(() => isSaved = !isSaved),
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? Colors.lightBlueAccent : Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        padding: padding,
      ),
    );
  }
}
