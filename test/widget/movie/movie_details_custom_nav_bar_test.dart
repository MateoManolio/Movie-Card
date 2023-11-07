import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/widgets/movie/movie_details_custom_nav_bar.dart';

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
          home: CustomNavigationBar(
            movie: movie,
            updateMovie: (Movie movie) {},
          ),
        ),
      );

      expect(find.byType(CustomNavigationBar), findsOneWidget);
    },
  );

  testWidgets(
    "Verify that the widget renders correctly with a liked movie",
    (WidgetTester widgetTester) async {
      movie.toggleLiked();
      await widgetTester.pumpWidget(
        MaterialApp(
          home: CustomNavigationBar(
            movie: movie,
            updateMovie: (Movie movie) {},
          ),
        ),
      );

      expect(find.byType(CustomNavigationBar), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      final Icon iconWidget =
          widgetTester.widget<Icon>(find.byIcon(Icons.favorite));
      final Color? iconColor = iconWidget.color;

      expect(iconColor, equals(Colors.redAccent));
    },
  );

  testWidgets(
    "Verify that the saved button works correctly",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: CustomNavigationBar(
            movie: movie,
            updateMovie: (Movie movie) {},
          ),
        ),
      );

      await widgetTester.tap(find.byIcon(Icons.bookmark_border));
      await widgetTester.pump();

      expect(find.byIcon(Icons.bookmark), findsOneWidget);
    },
  );
}
