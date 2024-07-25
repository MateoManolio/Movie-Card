import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/data/repository/genre_repository.dart';
import 'package:movie_card/src/domain/entity/genre.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/domain/usecase/fetch_genres_usecase.dart';

class MockSuccessMyRepository extends Mock implements GenreRepository {
  @override
  Future<DataState<List<Genre>>> getGenreForMovie(Movie movie) {
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

class MockFailureMyRepository extends Mock implements GenreRepository {
  @override
  Future<DataState<List<Genre>>> getGenreForMovie(Movie movie) {
    return Future<DataState<List<Genre>>>.value(
      DataFailure<List<Genre>>(
        error: Exception('No genres found'),
      ),
    );
  }
}

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
    'should return a list of genres based on provided ids',
    () async {
      final MockSuccessMyRepository mockRepository = MockSuccessMyRepository();

      final FetchGenresUseCase useCase =
          FetchGenresUseCase(repository: mockRepository);

      final DataState<List<Genre>> result = await useCase.call(movie);

      expect(result, isA<DataSuccess<List<Genre>>>());
      expect(result.data, hasLength(3));
    },
  );

  test(
    'should return a DataFailure when repository fails and when the parameters are none (null)',
    () async {
      final MockFailureMyRepository mockRepository = MockFailureMyRepository();
      final FetchGenresUseCase useCase =
          FetchGenresUseCase(repository: mockRepository);

      final DataState<List<Genre>> resultError = await useCase(movie);

      expect(resultError, isA<DataFailure<List<Genre>>>());
    },
  );
}
