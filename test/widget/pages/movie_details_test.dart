import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_card/src/data/models/cast_model.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/cast.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/bloc/movie_details_bloc.dart';
import 'package:movie_card/src/presentation/pages/movie_details.dart';
import 'package:movie_card/src/presentation/widgets/loaders/cast_loader.dart';
import 'package:movie_card/src/presentation/widgets/movie/cast_widget.dart';
import 'package:movie_card/src/presentation/widgets/movie/movie_presentation.dart';


class MockCastBloc extends Mock implements MovieDetailsBloc {
  @override
  final StreamController<Event<List<Cast>>> castStreamController =
  StreamController<Event<List<Cast>>>.broadcast();

}

final List<Cast> cast = CastModel.fromListOfJson({
  "id": 24512,
  "cast": [
    {
      "id": 73457,
      "known_for_department": "Acting",
      "profile_path": "/qoVESlEjMLIbdDzeXwsYrSS2jpw.jpg"
    },
    {
      "id": 1397778,
      "known_for_department": "Acting",
      "profile_path": "/jxAbDJWvz4p1hoFpJYG5vY2dQmq.jpg"
    },
    {
      "id": 95101,
      "known_for_department": "Acting",
      "profile_path": "/c0HNhjChGybnHa4eoLyqO4dDu1j.jpg"
    },
    {
      "id": 70851,
      "known_for_department": "Acting",
      "profile_path": "/rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg"
    },
    {
      "id": 298410,
      "known_for_department": "Acting",
      "profile_path": "/vAR5gVXRG2Cl6WskXT99wgkAoH8.jpg"
    }
  ],
});

void main() {
  testWidgets(
    'MovieDetails widget test',
    (WidgetTester tester) async {
      final MockCastBloc mockCastBloc = MockCastBloc();

      await tester.pumpWidget(
        MaterialApp(
          home: MovieDetails(
            movie: MovieModel.mockMovie(),
            movieBloc: mockCastBloc, setLastMovie: (Movie movie) {  },
          ),
        ),
      );
      
      mockCastBloc.castStreamController.add(Event<List<Cast>>.loading());
      await tester.pump();
      expect(find.byType(MovieDetails), findsOneWidget);
      expect(find.byType(MoviePresentation), findsOneWidget);
      expect(find.byType(CastLoader), findsOneWidget);
      mockCastBloc.castStreamController.add(Event<List<Cast>>.success(cast));
      await tester.pump();
      expect(find.byType(CastWidget), findsOneWidget);
    },
  );
}
