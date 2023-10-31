import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

import '../../core/util/enums.dart';
import 'movie.dart';

@Entity(
  primaryKeys: <String>['movieId', 'category'],
  foreignKeys: <ForeignKey>[
    ForeignKey(
      childColumns: <String>['movieId'],
      parentColumns: <String>['id'],
      entity: Movie,
    ),
    ForeignKey(
      childColumns: <String>['category'],
      parentColumns: <String>['category'],
      entity: Category,
    ),
  ],
)
class MovieCategory {
  final Endpoint category;
  final int movieId;

  MovieCategory({
    required this.category,
    required this.movieId,
  });
}
