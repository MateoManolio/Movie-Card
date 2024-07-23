import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/widgets/menu/movies.dart';
import 'package:movie_card/src/presentation/widgets/shared/custom_card.dart';

void main() {
  testWidgets(
    'Verify that the widget renders correctly',
    (WidgetTester tester) async {
      final List<Movie> movies = <Movie>[
        Movie(
          id: 1,
          title: 'title',
          posterName: 'posterName',
          backdropName: 'backdropName',
          releaseDate: 'releaseDate',
          score: 0.5,
          genres: <int>[],
          overview: 'overview',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Movies(
            movies: movies,
            setLastMovie: (Movie movie) {},
            updateMovie: (Movie movie) {},
          ),
        ),
      );

      expect(find.text("Movies"), findsOneWidget);

      expect(find.byType(CustomCard), findsNWidgets(movies.length));
    },
  );
}
