import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/loaders/grid_view_loader.dart';
import 'package:movie_card/src/presentation/widgets/shared/custom_card.dart';

void main() {
  testWidgets(
    'GridViewLoader should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridViewLoader(
              gridCrossAxisCount: 2,
              length: 4,
            ),
          ),
        ),
      );

      expect(find.byType(GridViewLoader), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(CustomCard), findsNWidgets(4));
      expect(find.byType(LinearProgressIndicator), findsNWidgets(4));
    },
  );
}
