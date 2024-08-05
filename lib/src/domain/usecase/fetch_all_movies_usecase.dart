import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../data/repository/movies_repository.dart';
import '../entity/movie.dart';

class FetchAllMoviesUseCase
    extends IUseCase<Future<DataState<List<Movie>>>, int?> {
  final MovieRepository repository;

  FetchAllMoviesUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Movie>>> call([int? params]) async {
    assert(params != null);
    return await repository.getAllMoviesPage(params!);
  }
}
