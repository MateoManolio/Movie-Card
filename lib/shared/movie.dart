class Movie {
  Movie({
    required this.title,
    required this.posterName,
    required this.backdropName,
    required this.releaseDate,
    required this.score,
    required this.genres,
    required this.overview,
    this.saved = false,
    required this.cast,
  });

  final String title;
  final String posterName;
  final String backdropName;
  final String releaseDate;
  final String genres;
  final String overview;
  final double score;
  final List<dynamic> cast;
  bool saved;
  static const uri = 'https://image.tmdb.org/t/p/w500';

  void toggleSaved() {
    saved = !saved;
  }

  String get assetsBackdropPath => uri + backdropName;

  String get assetsPosterPath => uri + posterName;

  List<String> get assetsCastPath {
    List<String> castPath = [];
    for (int i = 0; i < cast.length; i++) {
      castPath.add(uri + cast[i]["profile_path"]!);
    }
    return castPath;
  }

  String getGenres(List<int> list) {
    return '';
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      posterName: json['poster_path'],
      backdropName: json['backdrop_path'],
      releaseDate: json['release_date'],
      score: (json['vote_average'].toDouble()) * 100,
      genres: json['genre_ids'].toString(),
      overview: json['overview'],
      cast: json['cast'],
    );
  }

  factory Movie.mockMovie() => Movie(
        title: "Mario Bros. Movie",
        posterName: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
        backdropName: "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
        releaseDate: "2023-04-05",
        overview:
            "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        genres: "Animation, Family, Adventure, Fantasy, Comedy",
        score: 0.78,
        cast: [
          {"profile_path": "/qoVESlEjMLIbdDzeXwsYrSS2jpw.jpg"},
          {"profile_path": "/jxAbDJWvz4p1hoFpJYG5vY2dQmq.jpg"},
          {"profile_path": "/c0HNhjChGybnHa4eoLyqO4dDu1j.jpg"},
          {"profile_path": "/rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg"},
          {"profile_path": "/vAR5gVXRG2Cl6WskXT99wgkAoH8.jpg"}
        ],
      );
}
