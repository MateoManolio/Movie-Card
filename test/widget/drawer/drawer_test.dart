import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/drawer/drawer.dart';

void main() {
  testWidgets(
    'HasDrawer should build without error',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HasDrawer(
            childPage: Container(),
            switchToPage: (int newPage) {},
            animationController: AnimationController(
              vsync: const TestVSync(),
              duration: Duration(milliseconds: 200),
            ),
            isSideMenuClosed: true,
            selectedPage: 0,
          ),
        ),
      );

      expect(find.byType(HasDrawer), findsOneWidget);
    },
  );
  testWidgets(
    'HasDrawer should animate and switch state correctly',
    (WidgetTester tester) async {
      final AnimationController animationController = AnimationController(
        vsync: const TestVSync(),
        duration: Duration(milliseconds: 200),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: HasDrawer(
            childPage: Container(),
            switchToPage: (int newPage) {},
            animationController: animationController,
            isSideMenuClosed: true,
            selectedPage: 0,
          ),
        ),
      );

      expect(find.byType(HasDrawer), findsOneWidget);

      await animationController.forward();
      await tester.pumpAndSettle();

      expect(find.byType(HasDrawer), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(HasDrawer), findsOneWidget);
    },
  );
}
