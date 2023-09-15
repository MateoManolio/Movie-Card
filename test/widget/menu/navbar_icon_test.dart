import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/menu/navbar_icon.dart';

void main() {
  testWidgets(
    'Verify that the widget renders correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NavbarIcon(
              icon: Icons.home,
              pageIndex: 0,
              currentIndex: 0,
              onIconTap: (int index) {},
            ),
          ),
        ),
      );

      expect(
        find.byIcon(Icons.home),
        findsOneWidget,
      );
      expect(
        tester
            .widget<Icon>(
              find.byIcon(Icons.home),
            )
            .color!
            .opacity,
        equals(1.0),
      );
    },
  );
}
