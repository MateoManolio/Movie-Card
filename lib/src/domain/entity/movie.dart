import '../../core/util/strings.dart';
import 'cast.dart';

class Movie {
  Movie({
    required this.id,
    required this.title,
    required this.posterName,
    required this.backdropName,
    required this.releaseDate,
    required this.score,
    required this.genres,
    required this.overview,
    this.saved = false,
    this.liked = false,
    required this.cast,
  });

  final int id;
  final String title;
  final String posterName;
  final String backdropName;
  final String releaseDate;
  final List<int> genres;
  final String overview;
  final double score;
  final List<Cast> cast;
  bool saved;
  bool liked;

  void toggleSaved() => saved = !saved;

  void toggleLiked() => liked = !liked;

  String get assetsBackdropPath => imageUri + backdropName;

  String get assetsPosterPath => imageUri + posterName;

  bool get getSaved => saved;

  List<String> get assetsCastPath {
    return cast.map((Cast castMember) => imageUri + castMember.profilePath).toList();
  }

}
