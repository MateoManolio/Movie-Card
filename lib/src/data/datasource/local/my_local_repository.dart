import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../core/util/data_state.dart';
import '../../models/genre_model.dart';
import '../../models/movie_model.dart';

@Deprecated(
  'This class was for local data fetching, but now we use a remote API'
  'You should use the remote repository instead',
)
class MyLocalRepository {
  static const String moviesAsset = 'assets/movies.json';
  static const String genresAsset = 'assets/genres.json';

  Future<DataState<List<MovieModel>>> loadMovies() async {
    final String response = await rootBundle.loadString(moviesAsset);
    final List<dynamic> data = await json.decode(response);
    return DataSuccess<List<MovieModel>>(data: MovieModel.listOfMovies(data));
  }

  Future<DataState<List<GenreModel>>> loadGenres() async {
    List<GenreModel> genres = <GenreModel>[];
    final String response = await rootBundle.loadString(genresAsset);
    final Map<String, dynamic> data = await json.decode(response);
    data['genres'].forEach(
      (Map<String, dynamic> genreJson) {
        GenreModel genre = GenreModel.fromJson(genreJson);
        genres.add(genre);
      },
    );
    return DataSuccess<List<GenreModel>>(data: genres);
  }

  Future<List<String>> getGenresById(List<int> genres) async {
    final DataState<List<GenreModel>> genresJson = await loadGenres();
    List<String> genreNames = genresJson.data!
        .where((GenreModel genreJson) => genres.contains(genreJson.id))
        .map((GenreModel genreJson) => genreJson.name)
        .toList();
    return genreNames;
  }

  MovieModel get getMockMovie => MovieModel.mockMovie();
}
