import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_card/src/domain/usecase/fetch_all_movies_usecase.dart';
import 'package:movie_card/src/domain/usecase/search_movies_usecase.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../presentation/bloc/search_movies_bloc.dart';
import '../../data/datasource/local/movie_database.dart';
import '../../data/datasource/remote/api_repository.dart';
import '../../data/repository/cast_repository.dart';
import '../../data/repository/movies_repository.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/fetch_last_seen_movie_usecase.dart';
import '../../domain/usecase/fetch_liked_movies_usecase.dart';
import '../../domain/usecase/fetch_saved_movies_usecase.dart';
import '../../domain/usecase/load_cast_usecase.dart';
import '../../domain/usecase/movies_by_type_usecase.dart';
import '../../domain/usecase/update_movie_usecase.dart';
import '../../presentation/bloc/movie_details_bloc.dart';
import '../../presentation/bloc/movies_bloc.dart';
import '../../presentation/bloc/saved_bloc.dart';
import '../../presentation/navigation/movie_details_args.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/movie_details.dart';
import '../../presentation/pages/saved_movies.dart';
import '../../presentation/pages/search_movies.dart';

abstract class AppRoutes {
  static Map<String, WidgetBuilder> get routes {
    return <String, WidgetBuilder>{
      Routes.movieDetailsRouteName: (BuildContext context) {
        final MovieDetailsArguments arguments = ModalRoute.of(context)!
            .settings
            .arguments! as MovieDetailsArguments;
        return Provider<MovieDetailsBloc>(
          create: (_) => MovieDetailsBloc(
            loadCastUseCase: LoadCastUseCase(
              repository: CastRepository(
                repository: APIRepository(client: Client()),
                database: Provider.of<MovieDatabase>(
                  context,
                  listen: false,
                ),
              ),
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
              posterTag: arguments.posterTag,
              backdropTag: arguments.backdropTag,
              updateMovie: arguments.updateMovie,
            );
          },
        );
      },
      Routes.homeRouteName: (BuildContext context) => MultiProvider(
            providers: <SingleChildWidget>[
              Provider<MoviesBloc>(
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
                  updateMovieUseCase: UpdateMovieUseCase(
                    repository: MovieRepository(
                      repository: APIRepository(client: Client()),
                      database: Provider.of<MovieDatabase>(
                        builderContext,
                        listen: false,
                      ),
                    ),
                  ),
                ),
              ),
              Provider<SavedMoviesBloc>(
                create: (BuildContext builderContext) => SavedMoviesBloc(
                  fetchSavedMoviesUseCase: FetchSavedMoviesUseCase(
                    repository: MovieRepository(
                      repository: APIRepository(client: Client()),
                      database: Provider.of<MovieDatabase>(
                        builderContext,
                        listen: false,
                      ),
                    ),
                  ),
                  fetchLikedMoviesUseCase: FetchLikedMoviesUseCase(
                    repository: MovieRepository(
                      repository: APIRepository(client: Client()),
                      database: Provider.of<MovieDatabase>(
                        builderContext,
                        listen: false,
                      ),
                    ),
                  ),
                ),
              ),
              Provider<SearchMoviesBloc>(
                create: (BuildContext context) => SearchMoviesBloc(
                  searchMoviesUseCase: SearchMoviesUseCase(
                    repository: MovieRepository(
                      repository: APIRepository(client: Client()),
                      database: Provider.of<MovieDatabase>(
                        context,
                        listen: false,
                      ),
                    ),
                  ),
                  fetchAllMoviesMoviesUseCase: FetchAllMoviesUseCase(
                    repository: MovieRepository(
                      repository: APIRepository(client: Client()),
                      database: Provider.of<MovieDatabase>(
                        context,
                        listen: false,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            builder: (BuildContext builderContext, _) => HomePage(
              bloc: Provider.of<MoviesBloc>(
                builderContext,
                listen: false,
              ),
            ),
          ),
      Routes.savedMovies: (BuildContext context) {
        return Provider<SavedMoviesBloc>(
          create: (BuildContext builderContext) => SavedMoviesBloc(
            fetchSavedMoviesUseCase: FetchSavedMoviesUseCase(
              repository: MovieRepository(
                repository: APIRepository(client: Client()),
                database: Provider.of<MovieDatabase>(
                  builderContext,
                  listen: false,
                ),
              ),
            ),
            fetchLikedMoviesUseCase: FetchLikedMoviesUseCase(
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
            return SavedMovies(
              bloc: Provider.of<SavedMoviesBloc>(
                builderContext,
                listen: false,
              ),
              setLastMovie: (Movie m) {},
              updateMovie: (Movie m) {},
            );
          },
        );
      },
      Routes.searchMovies: (BuildContext context) {
        final searchBloc = SearchMoviesBloc(
          searchMoviesUseCase: SearchMoviesUseCase(
            repository: MovieRepository(
              repository: APIRepository(client: Client()),
              database: Provider.of<MovieDatabase>(
                context,
                listen: false,
              ),
            ),
          ),
          fetchAllMoviesMoviesUseCase: FetchAllMoviesUseCase(
            repository: MovieRepository(
              repository: APIRepository(client: Client()),
              database: Provider.of<MovieDatabase>(
                context,
                listen: false,
              ),
            ),
          ),
        );
        return Provider<SearchMoviesBloc>(
          create: (BuildContext context) => searchBloc,
          child: SearchMovies(
            searchMoviesBloc: searchBloc,
            setLastMovie: (Movie Movie) {},
            updateMovie: (Movie Movie) {},
          ),
        );
      },
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
  static const String savedMovies = '/saved';
  static const String searchMovies = '/search';
}
