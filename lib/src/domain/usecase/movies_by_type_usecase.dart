import '../../core/util/movies_by_type_params.dart';
import '../../data/repository/movies_repository.dart';
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../entity/movie.dart';

class MoviesByTypeUseCase
    extends IUseCase<Future<DataState<List<Movie>>>, MoviesByTypeParams> {
  final MovieRepository repository;

  MoviesByTypeUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Movie>>> call([MoviesByTypeParams? params]) async {
    return repository.getMoviesByType(params!.endpoint, params.page);
  }
}
