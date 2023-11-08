import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../data/repository/movies_repository.dart';
import '../entity/movie.dart';

class FetchSavedMoviesUseCase extends IUseCase<Future<DataState<List<Movie>>>, dynamic>{

  final MovieRepository repository;

  FetchSavedMoviesUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Movie>>> call([params]) async {
    return repository.getSavedMovies();
  }
}
