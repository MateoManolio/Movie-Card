import 'package:flutter/material.dart';
import '../../core/util/ui_consts.dart';
import '../../domain/entity/movie.dart';
import '../widgets/movie/movie_presentation.dart';
import '../widgets/movie/overview.dart';
import '../widgets/movie/movie_details_custom_nav_bar.dart';
import '../widgets/movie/cast.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    super.key,
    required this.movie,
  });

  final Movie movie;
  static const String routeName = '/movie';

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  static const double endPadding = 130;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.onPrimaryContainer,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoviePresentation(
              movie: widget.movie,
            ),
            Overview(
              overview: widget.movie.overview,
            ),
            Cast(
              castImages: widget.movie.assetsCastPath,
            ),
            const SizedBox(
              height: endPadding,
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
