import 'package:movie_card/src/data/repository/movies_repository.dart';

import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../entity/movie.dart';

class MoviesByTypeUseCase
    extends IUseCase<Future<DataState<List<Movie>>>, Endpoint> {
  final MovieRepository repository;

  MoviesByTypeUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Movie>>> call([Endpoint? params]) async {
    return repository.getMoviesByType(params!);
  }
}
