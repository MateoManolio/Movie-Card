import '../../data/models/movie_model.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';

extension GetGenres on List<Genre> {
  List<Genre> getGenresById(
    List<int> ids,
  ) {
    List<Genre> selectedGenres = <Genre>[];
    selectedGenres = where(
      (Genre genre) => ids.contains(genre.id),
    ).toList();
    return selectedGenres;
  }
}

extension MovieModelToDomain on List<MovieModel> {
  List<Movie> toEntity() {
    final List<Movie> movies = <Movie>[];
    forEach((MovieModel movie) {
      movies.add(Movie.fromModel(movie));
    });
    return movies;
  }
}

extension AddButRepeated on List<Movie> {
  List<Movie> addButRepeated(List<Movie> movies) {
    movies.forEach((Movie movie) {
      if (!contains(movie)) {
        add(movie);
      }
    });
    return this;
  }
}

extension AddButRepeatedGenres on List<Genre> {
  List<Genre> addButRepeatedGenres(List<Genre> genres) {
    genres.forEach((Genre genre) {
      if (!contains(genre)) {
        add(genre);
      }
    });
    return this;
  }
}
