import 'package:flutter/material.dart';

import '../../../core/util/enums.dart';
import '../../../domain/entity/event.dart';
import '../../bloc/genres_bloc.dart';
import '../../../domain/entity/genre.dart';
import '../../../domain/entity/movie.dart';
import '../loaders/default_loader.dart';
import '../shared/circular_percent_indicator.dart';
import '../shared/custom_card.dart';
import '../shared/error_class.dart';

class MovieInfo extends StatefulWidget {
  const MovieInfo({
    required this.padGenresCard,
    required this.movie,
    super.key,
  });

  final double padGenresCard;
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
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  final GenresBloc _genreBloc = GenresBloc();

  @override
  void initState() {
    _genreBloc.fetchGenres(widget.movie.genres);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(MovieInfo.padCard),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomCard(
              padding: MovieInfo.padTitle,
              child: ListTile(
                title: Text(
                  widget.movie.title,
                ),
                subtitle: Text(
                  widget.movie.releaseDate,
                ),
                textColor: Theme.of(context).colorScheme.background,
              ),
            ),
            const SizedBox(
              height: MovieInfo.separation,
            ),
            CustomCard(
              padding: MovieInfo.padGenres,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(MovieInfo.padCard),
                    child: Padding(
                      padding: EdgeInsets.all(widget.padGenresCard),
                      child: CircularPercentIndicator(
                        percentIndicator: widget.movie.score,
                        radiusPercentIndicator:
                            MovieInfo.radiusPercentIndicator,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: MovieInfo.textGenderWidth,
                      child: StreamBuilder<Event<List<Genre>>>(
                        stream: _genreBloc.stream,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<Event<List<Genre>>> snapshot,
                        ) {
                          switch (snapshot.data?.state) {
                            case null:
                            case Status.loading:
                              return DefaultLoader();
                            case Status.empty:
                            case Status.success:
                              return Text(
                                snapshot.data!.data!
                                    .map((Genre genre) => genre.name)
                                    .join(", "),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                overflow: TextOverflow.visible,
                              );
                            case Status.error:
                              const CustomError(
                                message: "Genres Missing: Server Error",
                              );
                          }
                          return DefaultLoader();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
