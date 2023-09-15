import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/domain/entity/genre.dart';
import 'package:movie_card/src/domain/repository/i_my_repository.dart';
import 'package:movie_card/src/domain/usecase/fetch_genres_usecase.dart';

class MockSuccessMyRepository extends Mock implements IMyRepository {
  @override
  Future<DataState<List<Genre>>> loadGenres(List<int>? genres) {
    return Future<DataState<List<Genre>>>.value(
      DataSuccess<List<Genre>>(
        data: <Genre>[
          Genre(id: 1, name: 'name1'),
          Genre(id: 2, name: 'name2'),
          Genre(id: 3, name: 'name3'),
        ],
      ),
    );
  }
}

class MockFailureMyRepository extends Mock implements IMyRepository {
  @override
  Future<DataState<List<Genre>>> loadGenres(List<int>? genres) {
    return Future<DataState<List<Genre>>>.value(
      DataFailure<List<Genre>>(
        error: Exception('No genres found'),
      ),
    );
  }
}

void main() {
  test(
    'should return a list of genres based on provided ids',
    () async {
      final MockSuccessMyRepository mockRepository = MockSuccessMyRepository();
      final FetchGenresUseCase useCase =
          FetchGenresUseCase(repository: mockRepository);
      final List<int> genreIds = <int>[1, 3];

      final DataState<List<Genre>> result = await useCase(genreIds);

      expect(result, isA<DataSuccess<List<Genre>>>());
      expect(result.data, hasLength(2));
    },
  );

  test(
    'should return a DataFailure when repository fails and when the parameters are none (null)',
    () async {
      final MockFailureMyRepository mockRepository = MockFailureMyRepository();
      final FetchGenresUseCase useCase =
          FetchGenresUseCase(repository: mockRepository);
      final List<int> genreIds = <int>[1, 3];

      final DataState<List<Genre>> resultError = await useCase(genreIds);
      final DataState<List<Genre>> resultNull = await useCase(null);

      expect(resultError, isA<DataFailure<List<Genre>>>());
      expect(resultNull, isA<DataFailure<List<Genre>>>());
    },
  );
}
