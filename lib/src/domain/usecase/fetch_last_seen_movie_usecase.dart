import '../../data/repository/movies_repository.dart';
import '../../core/usecase/i_usecase.dart';
import '../entity/movie.dart';

class FetchLastSeenMovieUseCase extends IUseCase<Future<Movie>,int> {
  final MovieRepository repository;

  FetchLastSeenMovieUseCase({required this.repository});

  @override
  Future<Movie> call([int? params]) async {
    return repository.getMovieById(params!);
  }
}
