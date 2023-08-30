import 'package:flutter/material.dart';
import 'package:movie_card/shared/movie.dart';
import 'package:movie_card/widgets/movie/movie_presentation.dart';
import 'package:movie_card/widgets/movie/overview.dart';
import 'package:movie_card/widgets/movie/movie_details_custom_nav_bar.dart';
import 'package:movie_card/widgets/movie/cast.dart';

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
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
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
            Cast(castImages: widget.movie.assetsCastPath),
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
