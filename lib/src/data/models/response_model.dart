import 'movie_model.dart';

class ResponseModel {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<dynamic> result;

  ResponseModel({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.result,
  });

  List<MovieModel> get movies {
    List<MovieModel> results = <MovieModel>[];
    for (int i = 0; i < result.length; i++) {
      final MovieModel movie = MovieModel.fromJson(result[i]);
      results.add(movie);
    }
    return results;
  }
}
