import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_card/src/core/util/enums.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/bloc/movies_bloc.dart';
import 'package:movie_card/src/presentation/pages/popular.dart';
import 'package:movie_card/src/presentation/widgets/loaders/grid_view_loader.dart';
import 'package:movie_card/src/presentation/widgets/popular/grid_card.dart';
import 'package:movie_card/src/presentation/widgets/shared/error_class.dart';

class MockMoviesBlocSuccess extends Mock implements MoviesBloc {
  @override
  final StreamController<Event<List<Movie>>> popularStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  @override
  Future<void> getMoviesByType(Endpoint endpoint) async {
    switch (endpoint) {
      case Endpoint.popular:
        popularStreamController.add(
          Event<List<Movie>>(
            state: Status.success,
            error: Exception('Some error'),
            data: <Movie>[
              MovieModel.mockMovie(),
              MovieModel.mockMovie(),
              MovieModel.mockMovie(),
            ],
          ),
        );
      default:
        popularStreamController.addError(Error());
    }
  }

  @override
  Stream<Event<List<Movie>>> get popularStream =>
      popularStreamController.stream;

  @override
  Stream<Event<List<Movie>>> get nowPlayingStream =>
      popularStreamController.stream;
}

class MockMoviesBlocFailure extends Mock implements MoviesBloc {
  @override
  final StreamController<Event<List<Movie>>> popularStreamController =
      StreamController<Event<List<Movie>>>.broadcast();

  @override
  Future<void> getMoviesByType(Endpoint endpoint) async {
    switch (endpoint) {
      case Endpoint.popular:
        popularStreamController.add(
          Event<List<Movie>>.error(Exception('Some error')),
        );
      default:
        popularStreamController.addError(Error());
    }
  }

  @override
  Stream<Event<List<Movie>>> get popularStream =>
      popularStreamController.stream;

  @override
  Stream<Event<List<Movie>>> get nowPlayingStream =>
      popularStreamController.stream;
}

void main() {
  testWidgets(
    'Popular Widget Test when the stream has the correct data',
    (WidgetTester tester) async {
      final MockMoviesBlocSuccess mockMoviesBloc = MockMoviesBlocSuccess();

      await tester.pumpWidget(
        MaterialApp(
          home: Popular(
            nowPlayingMoviesStream: mockMoviesBloc.nowPlayingStream,
            popularMoviesStream: mockMoviesBloc.popularStream,
            onPageInit: () {},
          ),
        ),
      );

      expect(find.text('Most Popular'), findsOneWidget);

      await tester.pump();

      expect(find.byType(GridViewLoader), findsOneWidget);

      mockMoviesBloc.popularStreamController.add(
        Event<List<Movie>>.success(
          List<Movie>.generate(
            10,
            (int index) => MovieModel.mockMovie(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(GridCard), findsWidgets);
    },
  );

  testWidgets(
    'Popular Widget Test when the stream has an error',
    (WidgetTester tester) async {
      final MockMoviesBlocFailure mockMoviesBloc = MockMoviesBlocFailure();

      await tester.pumpWidget(
        MaterialApp(
          home: Popular(
            nowPlayingMoviesStream: mockMoviesBloc.nowPlayingStream,
            popularMoviesStream: mockMoviesBloc.popularStream,
            onPageInit: () {},
          ),
        ),
      );

      expect(find.text('Most Popular'), findsOneWidget);
      mockMoviesBloc.popularStreamController
          .add(Event<List<Movie>>.error(Exception('Error')));
      await tester.pump();
      expect(find.byType(CustomError), findsNWidgets(2));
    },
  );
}
