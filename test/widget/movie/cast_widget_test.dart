import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/domain/entity/cast.dart';
import 'package:movie_card/src/presentation/widgets/movie/cast_card.dart';
import 'package:movie_card/src/presentation/widgets/movie/cast_widget.dart';

void main() {
  final List<Cast> mockCastImages = <Cast>[
    Cast(
      id: 1,
      profilePath: 'profilePath',
      movieId: 100,
    ),
  ];

  testWidgets(
    "Verify that the widget renders correctly",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CastWidget(
              castImages: mockCastImages,
            ),
          ),
        ),
      );

      expect(find.text('Cast'), findsOneWidget);
      expect(find.byType(CastCard), findsNWidgets(mockCastImages.length));
    },
  );
}
