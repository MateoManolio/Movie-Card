class Cast {
  final String id;
  final String profilePath;

  Cast({
    required this.id,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json['id'].toString(),
        profilePath: json['profile_path'].toString(),
      );

  static List<Cast> fromListOfJson(List<dynamic> list) {
    List<Cast> casts = List.generate(
      list.length,
      (index) => Cast.fromJson(list[index]),
    );
    return casts;
  }
}
