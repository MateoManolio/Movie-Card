import 'dart:convert';
import 'package:flutter/services.dart';

import '../interface/i_my_repository.dart';
import '../shared/genre.dart';
import '../shared/movie.dart';

class MyLocalRepository implements IMyRepository {
  static const String moviesAsset = 'assets/movies.json';
  static const String genresAsset = 'assets/genres.json';

  @override
  Future<List<Movie>> loadMovies() async {
    final String response = await rootBundle.loadString(moviesAsset);
    final data = await json.decode(response);
    return Movie.listOfMovies(data);
  }

  @override
  Future<List<Genre>> loadGenres() async {
    List<Genre> genres = [];
    final String response = await rootBundle.loadString(genresAsset);
    final data = await json.decode(response);
    data['genres'].forEach(
      (genreJson) {
        Genre genre = Genre.fromJson(genreJson);
        genres.add(genre);
      },
    );
    return genres;
  }

  Future<List<String>> getGenresById(List<int> genres) async {
    final List<Genre> genresJson = await loadGenres();
    List<String> genreNames = genresJson
        .where((genreJson) => genres.contains(genreJson.id))
        .map((genreJson) => genreJson.name)
        .toList();
    return genreNames;
  }
}
