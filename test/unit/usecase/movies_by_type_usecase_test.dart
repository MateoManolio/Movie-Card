import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/core/util/enums.dart';
import 'package:movie_card/src/core/util/movies_by_type_params.dart';
import 'package:movie_card/src/data/repository/movies_repository.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/domain/usecase/movies_by_type_usecase.dart';

class MockAPIRepository extends Mock implements MovieRepository {
  @override
  Future<DataState<List<Movie>>> getMoviesByType(
    Endpoint endpoint,
    int? page,
  ) {
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
      late MoviesByTypeUseCase useCase;
      late MockAPIRepository mockRepository;

      setUp(
        () {
          mockRepository = MockAPIRepository();
          useCase = MoviesByTypeUseCase(repository: mockRepository);
        },
      );

      test(
        'should return a list of movies when the endpoint is provided',
        () async {
          final MoviesByTypeParams params = MoviesByTypeParams(
            endpoint: Endpoint.nowPlaying,
            page: 0,
          );

          when(() => mockRepository.getMoviesByType(
                params.endpoint,
                params.page,
              )).thenAnswer(
            (_) async => DataSuccess<List<Movie>>(
              data: <Movie>[],
            ),
          );
          final DataState<List<Movie>> result = await useCase(params);

          expect(result, isA<DataSuccess<List<Movie>>>());
        },
      );
    },
  );
}
