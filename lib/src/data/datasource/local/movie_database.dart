import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';


import '../../../core/util/enums.dart';
import '../../../domain/entity/cast.dart';
import '../../../domain/entity/genre.dart';
import '../../../domain/entity/movie.dart';
import '../../../domain/entity/movie_category.dart';
import '../../../domain/entity/movie_genre.dart';
import 'DAOs/genre_dao.dart';
import 'DAOs/movie_dao.dart';
import 'DAOs/cast_dao.dart';
import 'converter/genres_list_converter.dart';
part 'movie_database.g.dart';

@TypeConverters(<Type>[GenresListConverter])
@Database(
  version: 1,
  entities: <Type>[
    Movie,
    Genre,
    Cast,
    MovieCategory,
    MovieGenre,
  ],
)
abstract class MovieDatabase extends FloorDatabase{
  CastDao get castDao;
  MovieDao get movieDao;
  GenreDao get genreDao;
}
