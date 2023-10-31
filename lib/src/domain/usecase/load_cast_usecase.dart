
import '../../core/usecase/i_usecase.dart';
import '../../core/util/data_state.dart';
import '../../data/repository/cast_repository.dart';
import '../entity/cast.dart';

class LoadCastUseCase extends IUseCase<Future<DataState<List<Cast>>>, int> {
  final CastRepository repository;

  LoadCastUseCase({
    required this.repository,
  });

  @override
  Future<DataState<List<Cast>>> call([int? params]) async {
    return repository.loadCast(params!);
  }
}
