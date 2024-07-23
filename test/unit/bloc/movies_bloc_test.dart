import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/core/util/enums.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/domain/usecase/fetch_last_seen_movie_usecase.dart';
import 'package:movie_card/src/domain/usecase/movies_by_type_usecase.dart';
import 'package:movie_card/src/domain/usecase/update_movie_usecase.dart';
import 'package:movie_card/src/presentation/bloc/movies_bloc.dart';

class MockGetMoviesUseCase extends Mock
    implements MoviesByTypeUseCase {
  @override
  Future<DataState<List<Movie>>> call([dynamic params]) async {
    return DataSuccess<List<Movie>>(data: movies);
  }
}

class MockFetchLastSeenMovieUseCase extends Mock
    implements FetchLastSeenMovieUseCase {
  @override
  Future<Movie> call([int? params]) {
    return Future<Movie>.value(movie);
  }
}

class MockUpdateMovieUseCase extends Mock
    implements UpdateMovieUseCase {
  @override
  Future<Movie> call([Movie? params]) {
    return Future<Movie>.value(movie);
  }
}

final List<Movie> movies = <Movie>[movie];

final Movie movie = MovieModel(
  id: 502356,
  title: "Mario Bros. Movie",
  posterName: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
  backdropName: "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
  releaseDate: "2023-04-05",
  overview:
      "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
  genres: <int>[16, 10751, 12, 14, 35],
  score: 0.78,
);

void main() {
  group(
    'MoviesBloc',
    () {
      late MoviesBloc moviesBloc;
      setUp(
        () {
          final MockGetMoviesUseCase mockPopularMoviesUseCase = MockGetMoviesUseCase();
          final MockFetchLastSeenMovieUseCase fetchFirstLastMovie = MockFetchLastSeenMovieUseCase();
          final MockUpdateMovieUseCase updateMovieUseCase = MockUpdateMovieUseCase();
          moviesBloc = MoviesBloc(
            getMoviesUseCase: mockPopularMoviesUseCase, fetchFirstMovie: fetchFirstLastMovie, updateMovieUseCase: updateMovieUseCase,
          );
        },
      );

      tearDown(
        () {
          moviesBloc.dispose();
        },
      );

      test(
        'getMoviesByType updates streams correctly',
        () async {
          expect(
            moviesBloc.popularStream,
            emitsInOrder([Event<List<Movie>>.success(movies)]),
          );

          await moviesBloc.getMoviesByType(Endpoint.popular);
        },
      );
    },
  );
}
