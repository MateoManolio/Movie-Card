import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/bloc/movies_bloc.dart';
import 'package:movie_card/src/presentation/pages/movie_menu.dart';
import 'package:movie_card/src/presentation/widgets/loaders/last_seen_loader.dart';
import 'package:movie_card/src/presentation/widgets/loaders/movies_loader.dart';
import 'package:movie_card/src/presentation/widgets/menu/last_seen.dart';
import 'package:movie_card/src/presentation/widgets/menu/movies.dart';

void main() {
  testWidgets(
    'MovieMenu widget test',
    (WidgetTester tester) async {
      final MoviesBloc mockMoviesBloc = MockMoviesBloc();

      await tester.pumpWidget(
        MaterialApp(
          home: MovieMenu(
            moviesBloc: mockMoviesBloc,
          ),
        ),
      );

      expect(find.byType(LastSeenLoader), findsOneWidget);

      await tester.pump();

      expect(find.byType(LastSeen), findsOneWidget);

      mockMoviesBloc.popularStreamController.add(Event<List<Movie>>.loading());
      await tester.pump();

      expect(find.byType(MoviesLoader), findsOneWidget);

      mockMoviesBloc.popularStreamController
          .add(Event<List<Movie>>.success(<Movie>[MovieModel.mockMovie()]));
      await tester.pump();

      expect(find.byType(Movies), findsOneWidget);
    },
  );
}

class MockMoviesBloc extends Mock implements MoviesBloc {
  @override
  final StreamController<Event<List<Movie>>> popularStreamController =
      StreamController<Event<List<Movie>>>();

  @override
  Stream<Event<List<Movie>>> get popularStream =>
      popularStreamController.stream;
}

