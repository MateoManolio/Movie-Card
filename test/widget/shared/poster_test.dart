import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/presentation/widgets/shared/poster.dart';

void main() {
  const String posterName = '/asset';

  testWidgets(
    "Verify that a image is display",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Poster(
            posterPadding: 0,
            posterName: posterName,
            posterWidth: 50,
          ),
        ),
      );

      final Finder textFinder =
          find.image(CachedNetworkImageProvider(posterName));

      expect(textFinder, findsOneWidget);
    },
  );
}
