import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/shared/custom_card.dart';

void main() {
  final Widget child = Container(
    color: Colors.greenAccent,
  );

  testWidgets(
    "Verify that the child of the card is display correctly",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: CustomCard(
            child: child,
            padding: 8,
          ),
        ),
      );

      final Finder textFinder = find.byWidget(child);

      expect(textFinder, findsOneWidget);
    },
  );
}
