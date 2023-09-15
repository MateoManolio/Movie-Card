import 'package:http/http.dart';

import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../data/repository/api_repository.dart';
import '../entity/cast.dart';
import '../entity/movie.dart';
import '../repository/i_my_repository.dart';

class LoadCastUseCase
    extends IUseCase<Future<DataState<List<Cast>>>, Movie> {
  final IMyRepository repository;

  LoadCastUseCase({IMyRepository? repository})
      : repository = repository ?? APIRepository(client: Client());

  @override
  Future<DataState<List<Cast>>> call([Movie? params]) async {
    return await repository.loadCast(params?.id);
  }
}
