import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:http/src/response.dart';
import 'package:movie_card/src/core/util/extensions.dart';

import '../../../config/secrets/env.dart';
import '../../../core/util/data_state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/strings.dart';
import '../../../domain/entity/genre.dart';
import '../../../domain/entity/movie.dart';
import '../../../domain/repository/i_my_repository.dart';
import '../../models/cast_model.dart';
import '../../models/genre_model.dart';
import '../../models/movie_model.dart';
import '../../models/response_model.dart';

class APIRepository implements IMyRepository {
  static const String messageIdError = 'missing id: id must be provided';
  static const String messageFetchMoviesError = 'Failed to fetch movies';
  static const String messageLoadGenresError = 'Failed to load the genres';
  static const String messageLoadCastError = 'Failed to load the cast';
  static const String messageMissingParameters = 'The parameters are missing';
  late final String apiKeyUri = '?api_key=${Env.apiKey}';

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
  Future<DataState<List<Genre>>> loadGenres() async {
    try {
      final Response moviesResponse = await client.get(
        Uri.parse(
          '$genresMoviesUri$apiKeyUri',
        ),
      );
      final Response tvShowsResponse = await client.get(
        Uri.parse(
          '$genresTVShowsUri$apiKeyUri',
        ),
      );
      if (moviesResponse.statusCode == HttpStatus.ok ||
          tvShowsResponse.statusCode == HttpStatus.ok) {
        final List<Genre> genreList = <Genre>[];
        if (moviesResponse.statusCode == HttpStatus.ok) {
          final List<Map<String, dynamic>> genreMoviesList =
              List<Map<String, dynamic>>.from(
            json.decode(moviesResponse.body)['genres'],
          );
          genreList.addAll(GenreModel.listOfGenres(genreMoviesList));
        }
        if (tvShowsResponse.statusCode == HttpStatus.ok) {
          final List<Map<String, dynamic>> genreTVShowsList =
              List<Map<String, dynamic>>.from(
            json.decode(tvShowsResponse.body)['genres'],
          );
          genreList
              .addButRepeatedGenres(GenreModel.listOfGenres(genreTVShowsList));
        }
        return DataSuccess<List<Genre>>(
          data: genreList,
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
          result: results['results'],
        );
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
  Future<DataState<List<Movie>>> loadMoviesByType(
    Endpoint endpoint, [
    String? page,
  ]) async {
    late final String search;
    switch (endpoint) {
      case Endpoint.popular:
        search = popular;
      case Endpoint.nowPlaying:
        search = nowPlaying;
      case Endpoint.upcoming:
        search = upcoming;
    }
    final String pageUri = page != null ? '&page=$page' : '';
    return await _fetchMovies('$moviesDetailsUri$search$apiKeyUri$pageUri');
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

  @override
  Future<DataState<List<Movie>>> searchMovies(String query) async {
    try {
      final Response response = await client.get(
        Uri.parse(
          '$searchMoviesUri/multi$apiKeyUri&query=$query',
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> results = json.decode(response.body);
        final ResponseModel responseModel = ResponseModel(
          page: results['page'],
          totalResults: results['total_results'],
          totalPages: results['total_pages'],
          result: results['results'],
        );
        return DataSuccess<List<Movie>>(
          data: responseModel.movies.toEntity(),
        );
      } else {
        return DataFailure<List<Movie>>(
          error: Exception(messageFetchMoviesError),
        );
      }
    } catch (error) {
      return DataFailure<List<MovieModel>>(
        error: Exception(error),
      );
    }
  }
}
