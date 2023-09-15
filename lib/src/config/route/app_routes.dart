import 'package:flutter/material.dart';

import '../../presentation/bloc/cast_bloc.dart';
import '../../presentation/navigation/movie_details_args.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/movie_details.dart';

abstract class AppRoutes {
  static Map<String, WidgetBuilder> get routes {
    return <String, WidgetBuilder>{
      Routes.movieDetailsRouteName: (BuildContext context) {
        final MovieDetailsArguments arguments = ModalRoute.of(context)!
            .settings
            .arguments! as MovieDetailsArguments;
        return MovieDetails(
          movie: arguments.movie,
          movieBloc: arguments.bloc,
          castBloc: CastBloc(),
        );
      },
      Routes.homeRouteName: (BuildContext context) => HomePage(),
    };
  }
}

abstract class Routes {
  static const String homeRouteName = "/";
  static const String movieDetailsRouteName = '/movie';
  static const String movieMenuRouteName = "/menu";
  static const String drawerRouteName = '/drawer';
  static const String mostPopularRouteName = '/most_popular';
  static const String upcomingRouteName = '/upcoming';
}
