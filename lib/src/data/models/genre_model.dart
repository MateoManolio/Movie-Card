import '../../domain/entity/genre.dart';

class GenreModel extends Genre {
  GenreModel({
    required super.id,
    required super.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }

  static List<GenreModel> listOfGenres(List<Map<String, dynamic>> list) {
    List<GenreModel> genres = List<GenreModel>.generate(
      list.length,
          (int index) => GenreModel.fromJson(list[index]),
    );
    return genres;
  }
}
