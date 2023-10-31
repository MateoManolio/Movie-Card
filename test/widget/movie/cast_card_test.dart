import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_card/src/domain/entity/cast.dart';
import 'package:movie_card/src/presentation/widgets/movie/cast_card.dart';

void main() {
  final List<Cast> mockCastImages = <Cast>[
    Cast(
      id: 1,
      profilePath: 'profilePath',
      movieId: 100,
    ),
    Cast(
      id: 2,
      profilePath: 'null',
      movieId: 100,
    ),
  ];

  testWidgets(
    "Verify that the widget renders correctly",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CastCard(
              castWidth: 100,
              castHeight: 150,
              index: 0,
              images: mockCastImages,
            ),
          ),
        ),
      );

      expect(find.byType(CastCard), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    },
  );
}
