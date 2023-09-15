import '../../domain/entity/cast.dart';

class CastModel extends Cast {
  CastModel({
    required super.id,
    required super.profilePath,
    required super.movieId,
  });

  factory CastModel.fromJson(Map<String, dynamic> json, String movieId) => CastModel(
        id: json['id'].toString(),
        profilePath: json['profile_path'].toString(),
        movieId: movieId,
      );

  static List<CastModel> fromListOfJson(Map<String, dynamic> json) {
    List<CastModel> casts = <CastModel>[];
    final String movieId = json['id'].toString();
    final List<dynamic> list = List<dynamic>.from(json['cast']);
    for (int index = 0; index < list.length; index++) {
      if (list[index]['known_for_department'] == 'Acting') {
        casts.add(CastModel.fromJson(list[index], movieId));
      }
    }
    return casts;
  }
}
