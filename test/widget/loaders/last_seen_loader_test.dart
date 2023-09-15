import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/loaders/last_seen_loader.dart';
import 'package:movie_card/src/presentation/widgets/shared/custom_card.dart';

void main() {
  testWidgets(
    'LastSeenLoader shows CircularProgressIndicator',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LastSeenLoader(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(CustomCard), findsOneWidget);
    },
  );
}
