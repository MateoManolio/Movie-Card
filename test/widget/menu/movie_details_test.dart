import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/widgets/menu/movie_details.dart';
import 'package:movie_card/src/presentation/widgets/shared/circular_percent_indicator.dart';

void main() {
  final Movie movie = Movie(
    id: 1,
    title: 'title',
    posterName: 'posterName',
    backdropName: 'backdropName',
    releaseDate: 'releaseDate',
    score: 0.5,
    genres: <int>[],
    overview: 'overview',
  );

  testWidgets(
    'MenuMovieDetails should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MenuMovieDetails(
              posterWidth: 150.0,
              movie: movie,
            ),
          ),
        ),
      );

      expect(find.text(movie.title), findsOneWidget);
      expect(find.text(movie.releaseDate), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
      expect(find.byType(CircularPercentIndicator), findsOneWidget);
    },
  );
}
