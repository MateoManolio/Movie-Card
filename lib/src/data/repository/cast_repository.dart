import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../domain/entity/cast.dart';
import '../../domain/repository/i_my_repository.dart';
import '../datasource/local/movie_database.dart';

class CastRepository {
  final IMyRepository repository;
  final MovieDatabase database;

  CastRepository({
    required this.repository,
    required this.database,
  });

  Future _updateDataBase(int movieId) async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      final DataState<List<Cast>> apiResponse =
          await repository.loadCast(movieId);
      if (apiResponse.state == Status.success) {
        await database.castDao.insertCast(apiResponse.data!);
      }
    }
  }

  Future<DataState<List<Cast>>> loadCast(int movieId) async {
    List<Cast> cast = await database.castDao.getCastByMovie(movieId);

    if (cast.isEmpty) {
      await _updateDataBase(movieId);
      cast = await database.castDao.getCastByMovie(movieId);
    } else {
      unawaited(_updateDataBase(movieId));
    }

    return DataSuccess<List<Cast>>(
      data: cast,
    );
  }
}
