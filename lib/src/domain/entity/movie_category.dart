import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

import '../../core/util/enums.dart';
import 'movie.dart';

@Entity(primaryKeys: <String>['movieId', 'category'])
class MovieCategory {
  final Endpoint category;
  final int movieId;

  MovieCategory({
    required this.category,
    required this.movieId,
  });
}
