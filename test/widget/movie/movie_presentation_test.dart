import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/widgets/movie/movie_presentation.dart';

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
    "Verify that the widget renders correctly",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoviePresentation(
              movie: movie,
              posterTag: '',
              backdropTag: '',
            ),
          ),
        ),
      );

      expect(find.byType(MoviePresentation), findsOneWidget);
    },
  );

  testWidgets(
    "Verify that the back button leaves the page",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoviePresentation(
              movie: movie,
              posterTag: '',
              backdropTag: '',
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(IconButton));
      await widgetTester.pump();

      expect(find.byType(MoviePresentation), findsNothing);
    },
  );
}
