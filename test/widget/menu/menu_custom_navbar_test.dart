import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/menu/menu_custom_navbar.dart';
import 'package:movie_card/src/presentation/widgets/menu/navbar_icon.dart';

void main() {
  testWidgets(
    'Verify that the widget renders correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MenuCustomNavigationBar(
              currentIndex: 0,
              onIconTap: (int index) {},
            ),
          ),
        ),
      );

      expect(find.byType(NavbarIcon), findsNWidgets(3));

      await tester.tap(find.byIcon(Icons.search_rounded));
      await tester.pump();
    },
  );

  testWidgets(
    'Tapping on an icon changes the icons opacity',
    (WidgetTester tester) async {
      int currentIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MenuCustomNavigationBar(
              currentIndex: currentIndex,
              onIconTap: (int index) {
                currentIndex = index;
              },
            ),
          ),
        ),
      );
      expect(
        tester
            .widget<Icon>(
              find.byIcon(Icons.home_filled),
            )
            .color!
            .opacity,
        equals(1.0),
      );
      await tester.tap(find.byIcon(Icons.search_rounded));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MenuCustomNavigationBar(
              currentIndex: currentIndex,
              onIconTap: (int index) {
                currentIndex = index;
              },
            ),
          ),
        ),
      );

      expect(
        tester
            .widget<Icon>(
              find.byIcon(Icons.home_filled),
            )
            .color!
            .opacity
            .toStringAsFixed(1),
        equals('0.5'),
      );
    },
  );
}
