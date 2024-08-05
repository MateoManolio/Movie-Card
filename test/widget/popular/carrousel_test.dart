import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_card/src/core/util/enums.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/bloc/movies_bloc.dart';
import 'package:movie_card/src/presentation/widgets/popular/carrousel.dart';
import 'package:movie_card/src/presentation/widgets/shared/error_class.dart';

class MockMoviesBlocSuccess extends Mock implements MoviesBloc {
  @override
  final StreamController<Event<List<Movie>>> nowPlayingStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  @override
  Future<void> getMoviesByType(
    Endpoint endpoint,
    int? page,
  ) async {
    switch (endpoint) {
      case Endpoint.nowPlaying:
        nowPlayingStreamController.add(
          Event<List<Movie>>(
            state: Status.success,
            error: Exception('Some error'),
            data:
                List<Movie>.generate(10, (int index) => MovieModel.mockMovie()),
          ),
        );
      default:
        nowPlayingStreamController.addError(Error());
    }
  }

  @override
  Stream<Event<List<Movie>>> get nowPlayingStream =>
      nowPlayingStreamController.stream;
}

class MockMoviesBlocFailure extends Mock implements MoviesBloc {
  @override
  final StreamController<Event<List<Movie>>> nowPlayingStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  @override
  Future<void> getMoviesByType(
    Endpoint endpoint,
    int? page,
  ) async {}

  @override
  Stream<Event<List<Movie>>> get nowPlayingStream =>
      nowPlayingStreamController.stream;
}

void main() {
  testWidgets(
    'Carrousel renders without error',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Carrousel(
            movies:
                List<Movie>.generate(10, (int index) => MovieModel.mockMovie()),
            setLastMovie: (Movie movie) {},
            updateMovie: (Movie movie) {},
          ),
        ),
      );

      expect(find.byType(Carrousel), findsOneWidget);
    },
  );

  testWidgets(
    'Carrousel increments page with timer',
    (WidgetTester tester) async {
      final Carrousel mockCarrousel = Carrousel(
        movies: List<Movie>.generate(10, (int index) => MovieModel.mockMovie()),
        setLastMovie: (Movie Movie) {},
        updateMovie: (Movie movie) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: mockCarrousel,
        ),
      );

      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(mockCarrousel.getTimer.tick, 1);
    },
  );
  testWidgets(
    'Carrousel displays error message when stream emits an error',
    (WidgetTester tester) async {
      final MockMoviesBlocFailure mockMoviesBloc = MockMoviesBlocFailure();

      await tester.pumpWidget(
        MaterialApp(
          home: Carrousel(
            movies:
                List<Movie>.generate(10, (int index) => MovieModel.mockMovie()),
            setLastMovie: (Movie Movie) {},
            updateMovie: (Movie movie) {},
          ),
        ),
      );

      mockMoviesBloc.nowPlayingStreamController
          .add(Event<List<Movie>>.error(Exception('Some error')));
      await tester.pump();
      expect(find.byType(CustomError), findsOneWidget);
    },
  );
}
