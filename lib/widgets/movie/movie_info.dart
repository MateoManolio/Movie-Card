import 'package:flutter/material.dart';
import '../../provider/my_local_repository.dart';
import '../../shared/circular_percent_indicator.dart';
import '../../shared/custom_card.dart';
import '../../shared/error_class.dart';
import '../../shared/movie.dart';

class MovieInfo extends StatefulWidget {
  const MovieInfo({
    super.key,
    required this.padGenresCard,
    required this.movie,
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
  late final Future<List<String>> _movieGenres;
  MyLocalRepository repository = MyLocalRepository();

  @override
  void initState() {
    _movieGenres = repository.getGenresById(widget.movie.genres);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(MovieInfo.padCard),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                children: [
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
                      child: FutureBuilder(
                        future: _movieGenres,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                        ) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const CustomError(
                                message: "Genres Missing",
                              );
                            } else {
                              return Text(
                                snapshot.data.join(", "),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                overflow: TextOverflow.visible,
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
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
