import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/genre_model.dart';
import '../../domain/repository/i_my_repository.dart';
import '../models/movie_model.dart';

class MyLocalRepository implements IMyRepository {
  static const String moviesAsset = 'assets/movies.json';
  static const String genresAsset = 'assets/genres.json';

  @override
  Future<List<MovieModel>> loadMovies() async {
    final String response = await rootBundle.loadString(moviesAsset);
    final data = await json.decode(response);
    return MovieModel.listOfMovies(data);
  }

  @override
  Future<List<GenreModel>> loadGenres() async {
    List<GenreModel> genres = [];
    final String response = await rootBundle.loadString(genresAsset);
    final data = await json.decode(response);
    data['genres'].forEach(
      (genreJson) {
        GenreModel genre = GenreModel.fromJson(genreJson);
        genres.add(genre);
      },
    );
    return genres;
  }

  Future<List<String>> getGenresById(List<int> genres) async {
    final List<GenreModel> genresJson = await loadGenres();
    List<String> genreNames = genresJson
        .where((genreJson) => genres.contains(genreJson.id))
        .map((genreJson) => genreJson.name)
        .toList();
    return genreNames;
  }
}
