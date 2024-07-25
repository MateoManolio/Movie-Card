import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/core/util/ui_consts.dart';
import 'package:movie_card/src/presentation/widgets/drawer/side_menu.dart';
import 'package:movie_card/src/presentation/widgets/drawer/side_menu_elements.dart';

void main() {
  testWidgets(
    'Test SideMenu widget renders correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SideMenu(
            optionSelected: (int page) {},
            selectedPage: 0,
          ),
        ),
      );

      expect(find.byType(SideMenuElements), findsOneWidget);
    },
  );
  testWidgets(
    'Testing SideMenu widget buttons works correctly',
    (WidgetTester tester) async {
      int test = -1;
      await tester.pumpWidget(
        MaterialApp(
          home: SideMenu(
            optionSelected: (int page) {
              test = 0;
            },
            selectedPage: 0,
          ),
        ),
      );
      await tester.tap(find.text('Home'));

      expect(test, equals(homePage));
    },
  );
}
