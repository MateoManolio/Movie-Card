import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:http/src/response.dart';

import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_my_repository.dart';
import '../models/cast_model.dart';
import '../models/genre_model.dart';
import '../models/movie_model.dart';
import '../models/response_model.dart';

class APIRepository implements IMyRepository {
  static const String messageIdError = 'missing id: id must be provided';
  static const String messageFetchMoviesError = 'Failed to fetch movies';
  static const String messageLoadGenresError = 'Failed to load the genres';
  static const String messageLoadCastError = 'Failed to load the cast';
  static const String messageMissingParameters = 'The parameters are missing';
  static const String apiKey = '42436bf062f671bce7b4344e0962f60c';
  static const String apiKeyUri = '?api_key=$apiKey';

  late final String addingUri;
  static const String latest = '/latest';
  static const String popular = '/popular';
  static const String upcoming = '/upcoming';
  static const String nowPlaying = '/now_playing';
  static const String cast = '/credits';
  final Client client;

  late final int movieId;

  APIRepository({
    required this.client,
  });

  @override
  Future<DataState<List<Genre>>> loadGenres(List<int>? genres) async {
    if(genres != null){
      List<GenreModel> genresFromApi = <GenreModel>[];
      try {
        final Response response = await client.get(
          Uri.parse(
            '$genresUri$apiKeyUri',
          ),
        );
        if (response.statusCode == HttpStatus.ok) {
          final List<Map<String, dynamic>> genreList =
          List<Map<String, dynamic>>.from(
            json.decode(response.body)['genres'],
          );
          genreList.forEach(
                (Map<String, dynamic> genreJson) {
              GenreModel genre = GenreModel.fromJson(genreJson);
              genresFromApi.add(genre);
            },
          );
          return DataSuccess<List<Genre>>(
            data: genresFromApi
                .where((GenreModel genre) => genres!.contains(genre.id))
                .toList(),
          );
        } else {
          return DataFailure<List<Genre>>(
            error: Exception(messageLoadGenresError),
          );
        }
      } catch (error) {
        return DataFailure<List<Genre>>(
          error: Exception(error),
        );
      }
    }else{
      return DataFailure<List<Genre>>(
        error: Exception(messageMissingParameters),
      );
    }
  }

  Future<DataState<List<MovieModel>>> _fetchMovies(String url) async {
    try {
      final Response response = await client.get(
        Uri.parse(
          url,
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> results = json.decode(response.body);
        final ResponseModel responseModel = ResponseModel(
            page: results['page'],
            totalResults: results['total_results'],
            totalPages: results['total_pages'],
            result: results['results']);
        return DataSuccess<List<MovieModel>>(
          data: responseModel.movies,
        );
      } else {
        return DataFailure<List<MovieModel>>(
          error: Exception(messageFetchMoviesError),
        );
      }
    } catch (error) {
      return DataFailure<List<MovieModel>>(
        error: Exception(error),
      );
    }
  }

  @override
  Future<DataState<List<Movie>>> loadMoviesByType(Endpoint endpoint) async {
    late final String search;
    switch (endpoint) {
      case Endpoint.popular:
        search = popular;
      case Endpoint.nowPlaying:
        search = nowPlaying;
      case Endpoint.upcoming:
        search = upcoming;
    }
    return await _fetchMovies('$moviesDetailsUri$search$apiKeyUri');
  }

  @override
  Future<DataState<List<CastModel>>> loadCast(int? movieId) async {
    if (movieId != null) {
      final Client client = Client();
      try {
        final Response response = await client.get(
          Uri.parse(
            '$moviesDetailsUri/$movieId$cast$apiKeyUri',
          ),
        );
        if (response.statusCode == HttpStatus.ok) {
          final Map<String, dynamic> castJson = json.decode(response.body);
          return DataSuccess<List<CastModel>>(
            data: CastModel.fromListOfJson(castJson),
          );
        } else {
          return DataFailure<List<CastModel>>(
            error: Exception(messageLoadCastError),
          );
        }
      } catch (error) {
        return DataFailure<List<CastModel>>(
          error: Exception(error),
        );
      }
    } else {
      return DataFailure<List<CastModel>>(
        error: Exception(messageMissingParameters),
      );
    }
  }
}
