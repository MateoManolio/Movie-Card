import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../data/repository/movies_repository.dart';
import '../entity/movie.dart';

class SearchMoviesUseCase
    extends IUseCase<Future<DataState<List<Movie>>>, String> {
  final MovieRepository repository;

  SearchMoviesUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Movie>>> call([String? params]) =>
      repository.searchMovies(params ?? '');
}
