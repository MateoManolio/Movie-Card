import '../../core/util/strings.dart';
import 'package:floor/floor.dart';

import '../../data/models/movie_model.dart';

@entity
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
  });

  @primaryKey
  final int id;
  final String title;
  final String posterName;
  final String backdropName;
  final String releaseDate;
  final List<int> genres;
  final String overview;
  final double score;
  bool saved;
  bool liked;

  void toggleSaved() => saved = !saved;

  void toggleLiked() => liked = !liked;

  String get assetsBackdropPath => imageUri + backdropName;

  String get assetsPosterPath => imageUri + posterName;

  bool get getSaved => saved;

  factory Movie.fromModel(MovieModel model) => Movie(
        id: model.id,
        title: model.title,
        posterName: model.posterName,
        backdropName: model.backdropName,
        releaseDate: model.releaseDate,
        score: model.score,
        genres: model.genres,
        overview: model.overview,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          posterName == other.posterName &&
          backdropName == other.backdropName &&
          releaseDate == other.releaseDate &&
          score == other.score &&
          listEquals(genres, other.genres) &&
          overview == other.overview &&
          saved == other.saved &&
          liked == other.liked;

  bool listEquals(List<int> a, List<int> b) {
    if (a.length != b.length) {
      return false;
    }
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}
