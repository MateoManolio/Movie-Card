import 'package:floor/floor.dart';

@entity
class Genre {
  @primaryKey
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Genre && id == other.id && name == other.name;
}
