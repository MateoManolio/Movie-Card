import '../../domain/entity/genre.dart';

extension getGenres on List<Genre> {
  List<Genre> getGenresById(
      List<int> ids,
      ) {
    List<Genre> selectedGenres = <Genre>[];
    selectedGenres = where(
          (Genre genre) => ids.contains(genre.id),
    )
        .toList();
    return selectedGenres;
  }
}
