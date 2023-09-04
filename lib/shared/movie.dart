import 'package:movie_card/shared/cast.dart';

import 'ui_consts.dart';

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
    return cast.map((castMember) => imageUri + castMember.profilePath).toList();
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    const percent = 10;
    return Movie(
      id: json['id'].toInt(),
      title: json['title'].toString(),
      posterName: json['poster_path'].toString(),
      backdropName: json['backdrop_path'].toString(),
      releaseDate: json['release_date'].toString(),
      score: (json['vote_average'].toDouble() / percent),
      genres: List<int>.from(json['genre_ids']),
      overview: json['overview'].toString(),
      cast: Cast.fromListOfJson(
        json['cast'],
      ),
    );
  }

  static List<Movie> listOfMovies(List<dynamic> list) {
    List<Movie> movies = List.generate(
      list.length,
      (index) => Movie.fromJson(list[index]),
    );
    return movies;
  }

  factory Movie.mockMovie() => Movie(
        id: 502356,
        title: "Mario Bros. Movie",
        posterName: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
        backdropName: "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
        releaseDate: "2023-04-05",
        overview:
            "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        genres: [16, 10751, 12, 14, 35],
        score: 0.78,
        cast: Cast.fromListOfJson(
          [
            {
              "id": 73457,
              "known_for_department": "Acting",
              "profile_path": "/qoVESlEjMLIbdDzeXwsYrSS2jpw.jpg"
            },
            {
              "id": 1397778,
              "known_for_department": "Acting",
              "profile_path": "/jxAbDJWvz4p1hoFpJYG5vY2dQmq.jpg"
            },
            {
              "id": 95101,
              "known_for_department": "Acting",
              "profile_path": "/c0HNhjChGybnHa4eoLyqO4dDu1j.jpg"
            },
            {
              "id": 70851,
              "known_for_department": "Acting",
              "profile_path": "/rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg"
            },
            {
              "id": 298410,
              "known_for_department": "Acting",
              "profile_path": "/vAR5gVXRG2Cl6WskXT99wgkAoH8.jpg"
            }
          ],
        ),
      );
}
