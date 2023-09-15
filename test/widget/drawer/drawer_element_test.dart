import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/drawer/drawer_element.dart';

void main() {
  group(
    'DrawerElement renders correctly',
    () {
      testWidgets(
        'DrawerElement renders correctly when it\'s active',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: DrawerElement(
                  icon: Icons.home,
                  text: 'Home',
                  width: 200,
                  isActive: true,
                  onIconTap: (int pageRoute) {},
                  pageRoute: 1,
                ),
              ),
            ),
          );

          final Icon iconWidget = tester.widget<Icon>(find.byIcon(Icons.home));
          expect(find.byWidget(iconWidget), findsOneWidget);

          final BoxDecoration boxDecoration = tester
              .widget<Container>(find.byType(Container))
              .decoration! as BoxDecoration;
          expect(boxDecoration, isNotNull);
        },
      );
      testWidgets(
        'DrawerElement renders correctly when it\'s not active',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: DrawerElement(
                  icon: Icons.home,
                  text: 'Home',
                  width: 200,
                  isActive: false,
                  onIconTap: (int pageRoute) {},
                  pageRoute: 1,
                ),
              ),
            ),
          );

          final Icon iconWidget = tester.widget<Icon>(find.byIcon(Icons.home));
          expect(find.byWidget(iconWidget), findsOneWidget);

          expect(find.byWidget(Container()), findsNothing);
          expect(find.text('Home'), findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'DrawerElement should call onIconTap when tapped',
    (WidgetTester tester) async {
      int test = -1;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawerElement(
              icon: Icons.home,
              text: 'Home',
              width: 200,
              isActive: false,
              onIconTap: (int pageRoute) {
                test = pageRoute;
              },
              pageRoute: 1,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Icon));
      await tester.pump();
      expect(test, equals(1));
    },
  );
}
