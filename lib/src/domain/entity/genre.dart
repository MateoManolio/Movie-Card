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

}
