import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_card/src/core/usecase/i_usecase.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/genre.dart';
import 'package:movie_card/src/presentation/bloc/genres_bloc.dart';

class MockFetchGenresSuccessUseCase extends Mock
    implements IUseCase<Future<DataState<List<Genre>>>, List<int>> {
  @override
  Future<DataState<List<Genre>>> call([List<int>? params]) async {
    return Future<DataState<List<Genre>>>.value(successResult);
  }
}

class MockFetchGenresFailureUseCase extends Mock
    implements IUseCase<Future<DataState<List<Genre>>>, List<int>> {
  @override
  Future<DataState<List<Genre>>> call([List<int>? params]) async {
    return Future<DataState<List<Genre>>>.value(errorResult);
  }
}

final DataSuccess<List<Genre>> successResult =
    DataSuccess<List<Genre>>(data: <Genre>[Genre(id: 1, name: 'Action')]);
final DataFailure<List<Genre>> errorResult =
    DataFailure<List<Genre>>(error: Exception('Failed to fetch genres'));

void main() {
  test(
    'should emit success event when fetching genres successfully',
    () async {
      final List<int> genres = <int>[1, 2, 3];

      final MockFetchGenresSuccessUseCase mockFetchGenresUseCase =
          MockFetchGenresSuccessUseCase();
      final GenresBloc genresBlocSuccess =
          GenresBloc(fetchGenres: mockFetchGenresUseCase);
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

      await genresBlocSuccess.fetchGenres(genres);
      genresBlocSuccess.dispose();
    },
  );

  test(
    'should emit error event when fetching genres fails',
    () async {
      final MockFetchGenresFailureUseCase mockFetchGenresUseCase =
          MockFetchGenresFailureUseCase();
      final GenresBloc genresBlocFailure =
          GenresBloc(fetchGenres: mockFetchGenresUseCase);

      final List<int> genres = <int>[1, 2, 3];

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

      await genresBlocFailure.fetchGenres(genres);
    },
  );
}
