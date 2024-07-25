import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/drawer/side_menu_elements.dart';

void main() {
  testWidgets(
    'SideMenuElements should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SideMenuElements(
              width: 200.0,
              optionSelected: (int page) {},
              selectedPage: 0,
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Most Popular'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    },
  );
}
