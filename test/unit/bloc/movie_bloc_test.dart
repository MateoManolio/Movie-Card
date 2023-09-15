import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_card/src/core/util/data_state.dart';
import 'package:movie_card/src/data/models/cast_model.dart';
import 'package:movie_card/src/data/models/movie_model.dart';
import 'package:movie_card/src/domain/entity/cast.dart';
import 'package:movie_card/src/domain/entity/event.dart';
import 'package:movie_card/src/domain/entity/movie.dart';
import 'package:movie_card/src/domain/usecase/fetch_last_seen_movie_usecase.dart';
import 'package:movie_card/src/domain/usecase/load_cast_usecase.dart';
import 'package:movie_card/src/presentation/bloc/movie_bloc.dart';

class MockFetchFirstLastMovieUseCase extends Mock
    implements FetchLastSeenMovieUseCase {
  @override
  Movie call([dynamic params]) {
    return movie;
  }
}

class MockLoadCastToMovieUseCase extends Mock
    implements LoadCastUseCase {
  @override
  Future<DataState<List<Cast>>> call([Movie? params]) async {
    return DataSuccess<List<Cast>>(data: cast);
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

final List<Cast> cast = CastModel.fromListOfJson(
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
  group(
    'MovieBloc test',
    () {
      late MovieBloc movieBloc;
      setUp(() {
        movieBloc = MovieBloc(
          fetchFirstMovie: MockFetchFirstLastMovieUseCase(),
        );
      });

      tearDown(
        () {
          movieBloc.dispose();
        },
      );

      test(
        'getMockMovie should return the first movie',
        () {
          final Movie actualMovie = movieBloc.getMockMovie();

          expect(actualMovie, movie);
        },
      );

      test(
        'setLastMovie should add the movie to the movie stream',
        () async {
          expect(
            movieBloc.movieStream,
            emitsInOrder(
              <Event<Movie>?>[
                Event<Movie>.success(movie),
              ],
            ),
          );

          movieBloc.setLastMovie(movie);
        },
      );
    },
  );
}
