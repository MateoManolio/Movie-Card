import 'cast_model.dart';
import '../../domain/entity/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.posterName,
    required super.backdropName,
    required super.releaseDate,
    required super.score,
    required super.genres,
    required super.overview,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {

    const int percent = 10;
    return MovieModel(
      id: json['id'].toInt(),
      title: json['title'].toString(),
      posterName: json['poster_path'].toString(),
      backdropName: json['backdrop_path'].toString(),
      releaseDate: json['release_date'].toString(),
      score: (json['vote_average'].toDouble() / percent),
      genres: List<int>.from(json['genre_ids']),
      overview: json['overview'].toString(),
    );
  }

  static List<MovieModel> listOfMovies(List<dynamic> list) {
    List<MovieModel> movies = List.generate(
      list.length,
      (int index) => MovieModel.fromJson(list[index]),
    );
    return movies;
  }

  factory MovieModel.mockMovie() => MovieModel(
        id: 502356,
        title: "Mario Bros. Movie",
        posterName: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
        backdropName: "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
        releaseDate: "2023-04-05",
        overview:
            "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        genres: [16, 10751, 12, 14, 35],
        score: 0.78,
      );
}
