import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/shared/circular_percent_indicator.dart';

void main() {
  testWidgets(
    "Verify that the percentage is correctly been display",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: CircularPercentIndicator(
            percentIndicator: 0.5,
            radiusPercentIndicator: 30,
          ),
        ),
      );

      final Finder textFinder = find.text("50%");

      expect(textFinder, findsOneWidget);
    },
  );
}
