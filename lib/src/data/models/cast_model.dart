import '../../domain/entity/cast.dart';

class CastModel extends Cast {
  CastModel({
    required super.id,
    required super.profilePath,
    required super.movieId,
  });

  factory CastModel.fromJson(Map<String, dynamic> json, int movieId) =>
      CastModel(
        id: json['id'].toInt(),
        profilePath: json['profile_path'].toString(),
        movieId: movieId,
      );

  static List<CastModel> fromListOfJson(Map<String, dynamic> json) {
    List<CastModel> casts = <CastModel>[];
    final int movieId = json['id'].toInt();
    final List<dynamic> list = List<dynamic>.from(json['cast']);
    for (int index = 0; index < list.length; index++) {
      if (list[index]['known_for_department'] == 'Acting' &&
          list[index]['profile_path'] != null) {
        casts.add(
          CastModel.fromJson(
            list[index],
            movieId,
          ),
        );
      }
    }
    return casts;
  }
}
