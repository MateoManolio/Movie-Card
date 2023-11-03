import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../data/repository/genre_repository.dart';
import '../entity/genre.dart';
import '../entity/movie.dart';

class FetchGenresUseCase
    extends IUseCase<Future<DataState<List<Genre>>>, Movie> {
  final GenreRepository repository;

  FetchGenresUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Genre>>> call([Movie? params]) async {
    return await repository.getGenreForMovie(params!);
  }
}
