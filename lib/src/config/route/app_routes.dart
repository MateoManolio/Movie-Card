import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_card/src/data/repository/movies_repository.dart';
import 'package:provider/provider.dart';

import '../../data/datasource/local/movie_database.dart';
import '../../data/datasource/remote/api_repository.dart';
import '../../data/repository/cast_repository.dart';
import '../../domain/usecase/fetch_last_seen_movie_usecase.dart';
import '../../domain/usecase/load_cast_usecase.dart';
import '../../domain/usecase/movies_by_type_usecase.dart';
import '../../presentation/bloc/movie_details_bloc.dart';
import '../../presentation/bloc/movies_bloc.dart';
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
        return Provider<MovieDetailsBloc>(
          create: (_) => MovieDetailsBloc(
            loadCastUseCase: LoadCastUseCase(repository: CastRepository(repository: APIRepository(client: Client()),
              database: Provider.of<MovieDatabase>(
                context,
                listen: false,
              ),),
            ),
          ),
          builder: (BuildContext builderContext, _) {
            return MovieDetails(
              movie: arguments.movie,
              movieBloc: Provider.of<MovieDetailsBloc>(
                builderContext,
                listen: false,
              ),
              setLastMovie: arguments.setLastMovie,
            );
          },
        );
      },
      Routes.homeRouteName: (BuildContext context) => Provider<MoviesBloc>(
            create: (BuildContext builderContext) => MoviesBloc(
              getMoviesUseCase: MoviesByTypeUseCase(
                repository: MovieRepository(
                  repository: APIRepository(client: Client()),
                  database: Provider.of<MovieDatabase>(
                    builderContext,
                    listen: false,
                  ),
                ),
              ),
              fetchFirstMovie: FetchLastSeenMovieUseCase(
                repository: MovieRepository(
                  repository: APIRepository(client: Client()),
                  database: Provider.of<MovieDatabase>(
                    builderContext,
                    listen: false,
                  ),
                ),
              ),
            ),
            builder: (BuildContext builderContext, _) {
              return HomePage(
                bloc: Provider.of<MoviesBloc>(
                  builderContext,
                  listen: false,
                ),
              );
            },
          ),
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
