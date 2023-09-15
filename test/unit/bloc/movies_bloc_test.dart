import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_card/src/core/usecase/i_usecase.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/core/util/enums.dart';
import 'package:movie_card/src/data/models/cast_model.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/presentation/bloc/movies_bloc.dart';

class MockPopularMoviesUseCase extends Mock
    implements IUseCase<Future<DataState<List<Movie>>>, dynamic> {
  @override
  Future<DataState<List<Movie>>> call([dynamic params]) async {
    return DataSuccess<List<Movie>>(data: movies);
  }
}

class MockNowPlayingMoviesUseCase extends Mock
    implements IUseCase<Future<DataState<List<Movie>>>, dynamic> {
  @override
  Future<DataState<List<Movie>>> call([dynamic params]) async {
    return DataSuccess<List<Movie>>(data: movies);
  }
}

class MockUpcomingMoviesUseCase extends Mock
    implements IUseCase<Future<DataState<List<Movie>>>, dynamic> {
  @override
  Future<DataState<List<Movie>>> call([dynamic params]) async {
    return DataSuccess<List<Movie>>(data: movies);
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
      late MockPopularMoviesUseCase mockPopularMoviesUseCase;
      late MockNowPlayingMoviesUseCase mockNowPlayingMoviesUseCase;
      late MockUpcomingMoviesUseCase mockUpcomingMoviesUseCase;

      setUp(
        () {
          mockPopularMoviesUseCase = MockPopularMoviesUseCase();
          mockNowPlayingMoviesUseCase = MockNowPlayingMoviesUseCase();
          mockUpcomingMoviesUseCase = MockUpcomingMoviesUseCase();

          moviesBloc = MoviesBloc(
            getPopularMovies: mockPopularMoviesUseCase,
            getNowPlayingMovies: mockNowPlayingMoviesUseCase,
            getUpcomingMovies: mockUpcomingMoviesUseCase,
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
