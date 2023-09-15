import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/data/models/cast_model.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/cast.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/domain/repository/i_my_repository.dart';
import 'package:movie_card/src/domain/usecase/load_cast_usecase.dart';

class MockSuccessMyRepository extends Mock implements IMyRepository {

  @override
  Future<DataState<List<Cast>>> loadCast(int? movieId) async {
    return Future<DataState<List<CastModel>>>.value(
      DataSuccess<List<CastModel>>(
        data: expectedCast,
      ),
    );
  }
}

class MockFailureMyRepository extends Mock implements IMyRepository {
  @override
  Future<DataState<List<Cast>>> loadCast(int? movieId) {
    return Future<DataState<List<CastModel>>>.value(
      DataFailure<List<CastModel>>(
        error: Exception('No cast found'),
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

final List<CastModel> expectedCast = CastModel.fromListOfJson(
    {
      "id": 24512,
      "cast": [
        {
          "id": 73457,
          "known_for_department": "Acting",
          "profile_path": "/qoVESlEjMLIbdDzeXwsYrSS2jpw.jpg"
        },
        {
          "id": 1397778,
          "known_for_department": "Acting",
          "profile_path": "/jxAbDJWvz4p1hoFpJYG5vY2dQmq.jpg"
        },
        {
          "id": 95101,
          "known_for_department": "Acting",
          "profile_path": "/c0HNhjChGybnHa4eoLyqO4dDu1j.jpg"
        },
        {
          "id": 70851,
          "known_for_department": "Acting",
          "profile_path": "/rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg"
        },
        {
          "id": 298410,
          "known_for_department": "Acting",
          "profile_path": "/vAR5gVXRG2Cl6WskXT99wgkAoH8.jpg"
        }
      ],
    }
);

void main() {
  test(
    'should load cast successfully',
    () async {
      final MockSuccessMyRepository mockRepository = MockSuccessMyRepository();
      final LoadCastUseCase useCase =
          LoadCastUseCase(repository: mockRepository);

      final DataState<List<Cast>> result = await useCase(movie);

      expect(result, isA<DataSuccess<List<Cast>>>());
      expect(result.data, expectedCast);
    },
  );

  test(
    'should handle failure when loading cast',
    () async {
      final MockFailureMyRepository mockRepository = MockFailureMyRepository();
      final LoadCastUseCase useCase =
          LoadCastUseCase(repository: mockRepository);

      final DataState<List<Cast>> result = await useCase(movie);

      expect(result, isA<DataFailure<List<Cast>>>());
    },
  );
}
