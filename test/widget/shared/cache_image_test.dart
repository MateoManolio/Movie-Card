import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/shared/cache_image.dart';

void main() {
  const String url =
      'https://www.rollingstone.com/wp-content/uploads/2016/06/rs-243008-lin.jpg';

  testWidgets(
    "Verify that a image is display",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: CacheImage(url: url),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    },
  );
}
