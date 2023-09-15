import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/shared/error_class.dart';

void main() {
  const String messageError = 'Error';
  const String errorImage = 'assets/error.gif';

  testWidgets(
    "Verify that a text and a image is display",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: CustomError(
            message: messageError,
          ),
        ),
      );

      final Finder textFinder = find.text(messageError);

      final Finder imageFinder = find.image(AssetImage(errorImage));

      expect(textFinder, findsOneWidget);
      expect(imageFinder, findsOneWidget);
    },
  );
}
