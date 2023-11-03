import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../core/util/ui_consts.dart';
import '../../../data/datasource/local/movie_database.dart';
import '../../../data/datasource/remote/api_repository.dart';
import '../../../data/repository/genre_repository.dart';
import '../../../domain/entity/movie.dart';
import '../../../domain/usecase/fetch_genres_usecase.dart';
import '../../bloc/genres_bloc.dart';
import '../shared/poster.dart';
import 'movie_info.dart';

class MoviePresentation extends StatelessWidget {
  const MoviePresentation({
    required this.movie,
    required this.posterTag,
    required this.backdropTag,
    super.key,
  });

  final String posterTag;
  final String backdropTag;
  final Movie movie;

  static const double movieCardsContainerHeight = 0.5;
  static const String asset = 'assets/error/default_backdrop.jpeg';
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
              tag: backdropTag,
              child: AspectRatio(
                aspectRatio: 16/10,
                child: CachedNetworkImage(
                  imageUrl: movie.assetsBackdropPath,
                  placeholder: (BuildContext context, String url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (
                    BuildContext context,
                    String url,
                    Object error,
                  ) =>
                      Image.asset(asset),
                  colorBlendMode: BlendMode.srcATop,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
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
                  tag: posterTag,
                  child: Poster(
                    posterPadding: pad1,
                    posterName: movie.assetsPosterPath,
                    posterWidth: posterWidth,
                  ),
                ),
                Provider<GenresBloc>(
                  create: (_) => GenresBloc(
                    fetchGenresUseCase: FetchGenresUseCase(
                      repository: GenreRepository(
                        repository: APIRepository(client: Client()),
                        database: Provider.of<MovieDatabase>(
                          context,
                          listen: false,
                        ),
                      ),
                    ),
                  ),
                  builder: (BuildContext builderContext, _) => MovieInfo(
                    padGenresCard: pad1,
                    movie: movie,
                    genreBloc: Provider.of<GenresBloc>(
                      builderContext,
                      listen: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
