import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/core/util/enums.dart';
import 'package:movie_card/src/data/repository/movies_repository.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/domain/usecase/movies_by_type_usecase.dart';

class MockAPIRepository extends Mock implements MovieRepository {
  @override
  Future<DataState<List<Movie>>> getMoviesByType(Endpoint endpoint) {
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
          final DataState<List<Movie>> result =
              await useCase(Endpoint.nowPlaying);

          expect(result, isA<DataSuccess<List<Movie>>>());
        },
      );
    },
  );
}
