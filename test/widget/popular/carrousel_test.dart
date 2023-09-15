/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_card/src/core/util/enums.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/bloc/movies_bloc.dart';
import 'package:movie_card/src/presentation/widgets/popular/carrousel.dart';
import 'package:movie_card/src/presentation/widgets/shared/cache_image.dart';

class MockMoviesBloc extends Mock implements MoviesBloc {}

void main() {
  final Movie movie1 = MovieModel.mockMovie();
  final Movie movie2 = Movie(
    id: 1,
    title: 'title',
    posterName: 'posterName',
    backdropName: 'backdropName',
    releaseDate: 'releaseDate',
    score: 0.5,
    genres: <int>[],
    overview: 'overview',
  );

  final List<Movie> movies =
      List<Movie>.generate(10, (int index) => index % 2 == 0 ? movie1 : movie2);

  testWidgets(
    "Verify that the widget renders correctly",
    (WidgetTester widgetTester) async {
      MockMoviesBloc mockMoviesBloc = MockMoviesBloc();
      when(() => mockMoviesBloc.nowPlayingStream)
          .thenReturn(StreamController<Event<List<Movie>>>.broadcast().stream as Stream<Event<List<Movie>>> Function());
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Carrousel(moviesBloc: mockMoviesBloc),
          ),
        ),
      );
      await widgetTester.pump(
        Duration(seconds: 5),
      );
      expect(find.byType(Carrousel), findsOneWidget);
    },
  );

  testWidgets(  //TODO: not working
    "Verify that the carrousel changes page when the user taps a dot",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Carrousel(moviesBloc: MockMoviesBloc()),
          ),
        ),
      );

      await widgetTester.tap(find.byType(InkWell).hitTestable().first);
      await widgetTester.pump();
      expect(find.byType(CacheImage),
        findsNWidgets(2), );

      await widgetTester.tap(find.byType(InkWell).hitTestable().last);
      await widgetTester.pump();
      expect(find.byType(CacheImage),
          findsNWidgets(3),);
    },
  );

  testWidgets(
    "Verify that the carrousel changes page every 5 seconds",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Carrousel(moviesBloc: MockMoviesBloc()),
          ),
        ),
      );

      await widgetTester.pump(Duration(seconds: 5));

      expect(find.byType(CacheImage), findsNWidgets(2));
    },
  );
}
*/
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
  Future<void> getMoviesByType(Endpoint endpoint) async {
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
  Future<void> getMoviesByType(Endpoint endpoint) async {}

  @override
  Stream<Event<List<Movie>>> get nowPlayingStream =>
      nowPlayingStreamController.stream;
}

void main() {
  testWidgets(
    'Carrousel renders without error',
    (WidgetTester tester) async {
      final MockMoviesBlocSuccess mockMoviesBloc = MockMoviesBlocSuccess();

      await tester.pumpWidget(
        MaterialApp(
          home: Carrousel(movies: List.generate(10, (index) => MovieModel.mockMovie())),
        ),
      );

      expect(find.byType(Carrousel), findsOneWidget);
    },
  );

  testWidgets(
    'Carrousel increments page with timer',
    (WidgetTester tester) async {
      final MockMoviesBlocSuccess mockMoviesBloc = MockMoviesBlocSuccess();

      final Carrousel mockCarrousel = Carrousel(
        movies: List.generate(10, (index) => MovieModel.mockMovie()),
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
          home: Carrousel(movies: List.generate(10, (index) => MovieModel.mockMovie())),
        ),
      );

      mockMoviesBloc.nowPlayingStreamController
          .add(Event<List<Movie>>.error(Exception('Some error')));
      await tester.pump();
      expect(find.byType(CustomError), findsOneWidget);
    },
  );
}
