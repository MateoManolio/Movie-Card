import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/menu/exit_alert.dart';

void main() {
  testWidgets(
    'ExitAlert should display correct content',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ExitAlert(),
        ),
      );
      await tester.pump();

      expect(find.text(ExitAlert.alertTitle), findsOneWidget);
      expect(find.text(ExitAlert.exitAppText), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);
    },
  );

  testWidgets(
    'ExitAlert should return true when Yes is pressed',
    (WidgetTester tester) async {
      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return ExitAlert();
                    },
                  );
                },
                child: Text('Show Dialog'),
              );
            },
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.text('Show Dialog'));
      await tester.pump();

      await tester.tap(find.text('Yes'));
      await tester.pump();

      expect(result, true);
    },
  );
}
