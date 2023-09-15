import '../../core/util/strings.dart';

class Cast {
  final String id;
  final String profilePath;
  final String movieId;

  Cast({
    required this.id,
    required this.profilePath,
    required this.movieId,
  });

  String get assetsCastPath {
    return '$imageUri$profilePath';
  }
}
