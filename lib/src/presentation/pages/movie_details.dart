import 'package:flutter/material.dart';

import '../../core/util/enums.dart';
import '../../core/util/ui_consts.dart';
import '../../domain/entity/cast.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movie_details_bloc.dart';
import '../widgets/loaders/cast_loader.dart';
import '../widgets/movie/cast_widget.dart';
import '../widgets/movie/movie_details_custom_nav_bar.dart';
import '../widgets/movie/movie_presentation.dart';
import '../widgets/movie/overview.dart';
import '../widgets/shared/error_class.dart';

class MovieDetails extends StatefulWidget {
  static const double endPadding = 130;
  static const String message = 'Error to bring the cast';

  final Movie movie;
  final MovieDetailsBloc movieBloc;
  final Function(Movie) setLastMovie;


  const MovieDetails({
    required this.movie,
    required this.movieBloc,
    required this.setLastMovie,
    super.key,
  });

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  @override
  void initState() {
    widget.setLastMovie(widget.movie);
    widget.movieBloc.loadCast(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.onPrimaryContainer,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MoviePresentation(
              movie: widget.movie,
            ),
            Overview(
              overview: widget.movie.overview,
            ),
            StreamBuilder<Event<List<Cast>>>(
              stream: widget.movieBloc.castStream,
              builder: (
                BuildContext context,
                AsyncSnapshot<Event<List<Cast>>> snapshot,
              ) {
                switch (snapshot.data?.state) {
                  case null:
                  case Status.loading:
                    return CastLoader();
                  case Status.empty:
                  case Status.success:
                    return CastWidget(
                      castImages: snapshot.data!.data!,
                    );
                  case Status.error:
                    return CustomError(
                      message: MovieDetails.message,
                    );
                }
              },
            ),
            const SizedBox(
              height: MovieDetails.endPadding,
            ),
          ],
        ),
      ),
      floatingActionButton: CustomNavigationBar(
        movie: widget.movie,
      ),
    );
  }
}
