import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/menu/header.dart';

void main() {
  testWidgets(
    'Header Widget renders correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              openDrawer: () {},
              isOpen: false,
            ),
          ),
        ),
      );

      expect(find.text("TMDB"), findsOneWidget);

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName == Header.logo),
          findsOneWidget);
    },
  );
}
