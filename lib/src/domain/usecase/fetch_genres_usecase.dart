import 'package:http/http.dart';

import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../data/repository/api_repository.dart';
import '../entity/genre.dart';
import '../repository/i_my_repository.dart';

class FetchGenresUseCase
    extends IUseCase<Future<DataState<List<Genre>>>, List<int>> {
  final IMyRepository repository;

  FetchGenresUseCase({IMyRepository? repository})
      : repository = repository ?? APIRepository(client: Client());

  @override
  Future<DataState<List<Genre>>> call([List<int>? params]) async {
    return await repository.loadGenres(params);
  }
}
