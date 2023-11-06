import '../../core/usecase/i_usecase.dart';
import '../../data/repository/movies_repository.dart';
import '../entity/movie.dart';

class UpdateMovieUseCase extends IUseCase<void, Movie> {
  final MovieRepository repository;

  UpdateMovieUseCase ({
    required this.repository,
  });

  @override
  void call([Movie? params]) {
    repository.updateMovie(params!);
  }
}
