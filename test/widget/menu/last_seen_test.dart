import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/config/route/app_routes.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/widgets/menu/last_seen.dart';

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
    'LastSeen widget should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LastSeen(
            movie: movie,
           setLastMovie: (Movie movie ) {  },
          ),
        ),
      );

      expect(find.text("Last seen"), findsOneWidget);

      expect(find.text(movie.title), findsNWidgets(2));
      expect(find.text(movie.releaseDate), findsNWidgets(2));

      expect(find.byType(GestureDetector), findsOneWidget);
    },
  );

  testWidgets(
    'LastSeen widget should navigate correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == Routes.movieDetailsRouteName) {
              return MaterialPageRoute<Widget>(
                builder: (BuildContext context) => Container(),
              );
            }
            return null; // Return null for other routes.
          },
          home: LastSeen(
            movie: movie,
            setLastMovie: (Movie movie) {  },
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.byType(LastSeen), findsNothing);
    },
  );
}
