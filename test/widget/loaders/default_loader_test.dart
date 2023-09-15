import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/loaders/default_loader.dart';

void main() {
  testWidgets(
    'GridViewLoader should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DefaultLoader(),
          ),
        ),
      );

      expect(find.byType(DefaultLoader), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
