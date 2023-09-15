import 'package:http/http.dart';

import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../data/repository/api_repository.dart';
import '../entity/movie.dart';
import '../repository/i_my_repository.dart';

class PopularMoviesUseCase extends IUseCase<Future<DataState<List<Movie>>>, dynamic> {
  final IMyRepository repository = APIRepository(client: Client());

  @override
  Future<DataState<List<Movie>>> call([params]) async {
    return await repository.loadMoviesByType(Endpoint.popular);
  }
}
