import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/loaders/cast_loader.dart';
import 'package:movie_card/src/presentation/widgets/shared/custom_card.dart';

void main() {
  testWidgets(
    'CastLoader widget test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CastLoader(),
          ),
        ),
      );

      expect(find.byType(LinearProgressIndicator),
          findsNWidgets(CastLoader.quantity));
      expect(find.byType(CustomCard), findsNWidgets(CastLoader.quantity));
    },
  );
}
