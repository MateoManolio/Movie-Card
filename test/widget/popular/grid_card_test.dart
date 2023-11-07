import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/widgets/popular/grid_card.dart';

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
    "Verify that the widgets are display correctly",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridCard(
              movie: movie,
              setLastMovie: (Movie movie) {},
              updateMovie: (Movie movie) {},
            ),
          ),
        ),
      );

      expect(find.byType(GridCard), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(2));
    },
  );

  group(
    'Verify that the buttons works correctly',
    () {
      testWidgets(
        "Verify that the like button changes when is press",
        (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: GridCard(
                  movie: movie,
                  setLastMovie: (Movie movie) {},
                  updateMovie: (Movie movie) {},
                ),
              ),
            ),
          );

          final Finder likeButton = find.byIcon(Icons.favorite_border_rounded);
          await widgetTester.tap(likeButton);
          await widgetTester.pump();

          expect(find.byIcon(Icons.favorite), findsOneWidget);
        },
      );
      testWidgets(
        "Verify that the save button changes when is press",
        (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: GridCard(
                  movie: movie,
                  setLastMovie: (Movie movie) {},
                  updateMovie: (Movie movie) {},
                ),
              ),
            ),
          );

          final Finder saveButton = find.byIcon(Icons.bookmark_border);
          await widgetTester.tap(saveButton);
          await widgetTester.pump();

          expect(find.byIcon(Icons.bookmark), findsOneWidget);
        },
      );
    },
  );
}
