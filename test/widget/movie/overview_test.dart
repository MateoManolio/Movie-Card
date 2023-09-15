import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/movie/overview.dart';

void main() {
  const String title = 'Overview';
  const String overview = 'Example Overview';

  testWidgets(
    "Verify that the texts are display",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Overview(overview: overview),
          ),
        ),
      );

      final Finder titleFinder = find.text(title);
      expect(titleFinder, findsOneWidget);

      final Finder overviewFinder = find.text(overview);
      expect(overviewFinder, findsOneWidget);
    },
  );
}
