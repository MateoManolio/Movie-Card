import '../../core/usecase/i_usecase.dart';
import '../../data/repository/my_local_repository.dart';
import '../entity/movie.dart';

class FetchLastSeenMovieUseCase extends IUseCase<Movie,dynamic> {
  final MyLocalRepository repository = MyLocalRepository();

  @override
  Movie call([params]) {
    return repository.getMockMovie;
  }
}
