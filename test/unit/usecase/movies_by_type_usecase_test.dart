import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/core/util/enums.dart';
import 'package:movie_card/src/data/repository/api_repository.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/domain/usecase/movies_by_type_usecase.dart';

class MockAPIRepository extends Mock implements APIRepository {
  @override
  Future<DataState<List<Movie>>> loadNowPlayingMovies() {
    return Future<DataState<List<Movie>>>.value(
      DataSuccess<List<Movie>>(
        data: <Movie>[],
      ),
    );
  }
}

void main() {
  group(
    'MoviesByTypeUseCase',
    () {
      late FetchGenresUseCase useCase;
      late MockAPIRepository mockRepository;

      setUp(
        () {
          mockRepository = MockAPIRepository();
          useCase = FetchGenresUseCase(repository: mockRepository);
        },
      );

      test(
        'should return a list of movies when the endpoint is provided',
        () async {
          final DataState<List<Movie>> result =
              await useCase(Endpoint.nowPlaying);

          expect(result, isA<DataSuccess<List<Movie>>>());
        },
      );

      test(
        'should return a DataFailure when the endpoint is not provided',
        () async {
          final DataState<List<Movie>> result = await useCase(null);

          expect(result, isA<DataFailure<List<Movie>>>());
        },
      );
    },
  );
}
