import '../../domain/entity/cast.dart';

class CastModel extends Cast {
  CastModel({
    required super.id,
    required super.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        id: json['id'].toString(),
        profilePath: json['profile_path'].toString(),
      );

  static List<CastModel> fromListOfJson(List<dynamic> list) {
    List<CastModel> casts = List.generate(
      list.length,
      (int index) => CastModel.fromJson(list[index]),
    );
    return casts;
  }
}
