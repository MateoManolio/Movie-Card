import 'dart:js';

import 'package:flutter/material.dart';
import 'package:movie_card/src/presentation/pages/home_page.dart';

import '../../data/models/movie_model.dart';
import '../../presentation/pages/movie_details.dart';

abstract class AppRoutes {
  static Map<String, WidgetBuilder> get routes {
    return <String, WidgetBuilder>{
      MovieDetails.routeName: (BuildContext context) => MovieDetails(
            movie: MovieModel.mockMovie(),
          ),
      HomePage.routeName: (BuildContext context) => HomePage(
            lastMovie: MovieModel.mockMovie(),
          ),
    };
  }
}
