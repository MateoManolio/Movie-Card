import 'package:floor/floor.dart';

import '../../core/util/enums.dart';

@Entity(primaryKeys: <String>['movieId', 'category'])
class MovieCategory {
  final Endpoint category;
  final int movieId;
  final int page;

  MovieCategory({
    required this.category,
    required this.movieId,
    required this.page,
  });
}
