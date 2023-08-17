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
    this.cast = const <String>[],
  });

  final String title;
  final String posterName;
  final String backdropName;
  final String releaseDate;
  final String genres;
  final String overview;
  final double score;
  final List<String> cast;
  bool saved;

  void toggleSaved() {
    saved = !saved;
  }

  String get assetsBackdropPath => 'assets/$backdropName.jpg';

  String get assetsPosterPath => 'assets/$posterName.jpg';

  List<String> get assetsCastPath {
    List<String> castPath = [];
    for (int i = 0; i < cast.length; i++) {
      castPath.add('assets/cast/${cast[i]}.jpg');
    }
    return castPath;
  }

  factory Movie.mockMovie() => Movie(
        title: "Mario Bros. Movie",
        posterName: "poster_MarioBros",
        backdropName: "backdrop_MarioBros",
        releaseDate: "2023-04-05",
        overview:
            "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        genres: "Animation, Family, Adventure, Fantasy, Comedy",
        score: 0.78,
        cast: [
          "1",
          "2",
          "3",
          "4",
          "5",
          "6",
        ],
      );
}
