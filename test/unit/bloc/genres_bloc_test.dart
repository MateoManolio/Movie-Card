import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/genre.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/domain/usecase/fetch_genres_usecase.dart';
import 'package:movie_card/src/presentation/bloc/genres_bloc.dart';

class MockFetchGenresSuccessUseCase extends Mock implements FetchGenresUseCase {
  @override
  Future<DataState<List<Genre>>> call([Movie? params]) async {
    return Future<DataState<List<Genre>>>.value(successResult);
  }
}

class MockFetchGenresFailureUseCase extends Mock implements FetchGenresUseCase {
  @override
  Future<DataState<List<Genre>>> call([Movie? params]) async {
    return Future<DataState<List<Genre>>>.value(errorResult);
  }
}

final DataSuccess<List<Genre>> successResult =
    DataSuccess<List<Genre>>(data: <Genre>[Genre(id: 1, name: 'Action')]);
final DataFailure<List<Genre>> errorResult =
    DataFailure<List<Genre>>(error: Exception('Failed to fetch genres'));

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
  test(
    'should emit success event when fetching genres successfully',
    () async {
      final MockFetchGenresSuccessUseCase mockFetchGenresUseCase =
          MockFetchGenresSuccessUseCase();
      final GenresBloc genresBlocSuccess =
          GenresBloc(fetchGenresUseCase: mockFetchGenresUseCase);
      unawaited(
        expectLater(
          genresBlocSuccess.stream,
          emitsInOrder(
            [
              Event<List<Genre>>.loading(),
              Event<List<Genre>>.success(successResult.data!),
            ],
          ),
        ),
      );

      await genresBlocSuccess.fetchGenres(movie);
      genresBlocSuccess.dispose();
    },
  );

  test(
    'should emit error event when fetching genres fails',
    () async {
      final MockFetchGenresFailureUseCase mockFetchGenresUseCase =
          MockFetchGenresFailureUseCase();
      final GenresBloc genresBlocFailure =
          GenresBloc(fetchGenresUseCase: mockFetchGenresUseCase);

      unawaited(
        expectLater(
          genresBlocFailure.stream,
          emitsInOrder(
            [
              Event<List<Genre>>.loading(),
              Event<List<Genre>>.error(errorResult.error!),
            ],
          ),
        ),
      );

      await genresBlocFailure.fetchGenres(movie);
    },
  );
}
