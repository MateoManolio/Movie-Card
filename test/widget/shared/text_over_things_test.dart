import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/shared/text_over_things.dart';

void main() {
  const String textOverThings = 'My Title';

  testWidgets(
    "Verify that the text is display",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: TextOverThings(
            title: textOverThings,
          ),
        ),
      );

      final Finder textFinder = find.text(textOverThings);

      expect(textFinder, findsNWidgets(2));
    },
  );
}
