import 'package:floor/floor.dart';

import '../../core/util/strings.dart';
import 'movie.dart';

const String entityName = 'MovieCast';

@Entity(
  tableName: entityName,
  foreignKeys: <ForeignKey>[
    ForeignKey(
      childColumns: <String>['movieId'],
      parentColumns: <String>['id'],
      entity: Movie,
    ),
  ],
)

class Cast {
  @primaryKey
  final int id;
  final String profilePath;
  final int movieId;

  Cast({
    required this.id,
    required this.profilePath,
    required this.movieId,
  });

  String get assetsCastPath {
    return '$imageUri$profilePath';
  }
}
