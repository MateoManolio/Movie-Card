import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/loaders/movies_loader.dart';
import 'package:movie_card/src/presentation/widgets/shared/custom_card.dart';

void main() {
  testWidgets(
    'MoviesLoader should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MoviesLoader()),
        ),
      );

      expect(find.byType(MoviesLoader), findsOneWidget);

      expect(
        find.byType(
          CustomCard,
          skipOffstage: false,
        ),
        findsNWidgets(5),
      );
    },
  );
}
