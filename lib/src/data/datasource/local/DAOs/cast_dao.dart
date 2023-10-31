import 'package:floor/floor.dart';

import '../../../../domain/entity/cast.dart';


@dao
abstract class CastDao{

  @Query('SELECT * FROM MovieCast WHERE movieId = :movieId ')
  Future<List<Cast>> getCastByMovie(int movieId);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertCast(List<Cast> cast);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCast(Cast cast);

}
