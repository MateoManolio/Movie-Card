import 'package:flutter/material.dart';

import '../../core/util/enums.dart';
import '../widgets/search/search_error.dart';
import '../../domain/entity/event.dart';
import '../bloc/search_movies_bloc.dart';
import '../../core/util/debouncer.dart';
import '../../core/util/ui_consts.dart';
import '../../domain/entity/movie.dart';
import '../widgets/search/movies_suggested.dart';

class SearchMovies extends StatefulWidget {
  final Function(Movie) setLastMovie;
  final Function(Movie) updateMovie;
  final SearchMoviesBloc searchMoviesBloc;

  const SearchMovies({
    required this.searchMoviesBloc,
    required this.setLastMovie,
    required this.updateMovie,
    super.key,
  });

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    widget.searchMoviesBloc.fetchAllMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.onPrimaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              style: TextStyle(
                color: colors.background,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: colors.secondary,
                hintText: 'Search...',
                hintStyle: TextStyle(
                  color: colors.secondary,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: colors.background.withOpacity(0.6),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _searchMovies,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                stream: widget.searchMoviesBloc.searchAllMoviesStream,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<Event<List<Movie>>> snapshot,
                ) {
                  switch (snapshot.data?.state) {
                    case null:
                    case Status.loading:
                      widget.searchMoviesBloc.fetchAllMovies();
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colors.background,
                          ),
                        ),
                      );
                    case Status.empty:
                    case Status.success:
                      ;
                      final List<Movie> allMovies = snapshot.data!.data!;
                      return StreamBuilder(
                        stream: widget.searchMoviesBloc.searchStream,
                        builder: (
                          BuildContext builderContext,
                          AsyncSnapshot<Event<List<Movie>>> snapshot,
                        ) {
                          switch (snapshot.data?.state) {
                            case null:
                            case Status.loading:
                              if (allMovies.isEmpty) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      colors.background,
                                    ),
                                  ),
                                );
                              }
                              continue empty;
                            case Status.empty:
                            empty:
                            case Status.success:
                              return ListView(
                                children: MoviesSuggested(
                                  setLastMovie: widget.setLastMovie,
                                  updateMovie: widget.updateMovie,
                                ).build(
                                  allMovies,
                                  snapshot.data?.data,
                                  context,
                                ),
                              );
                            case Status.error:
                              return SearchError();
                          }
                        },
                      );
                    case Status.error:
                      return SearchError();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchMovies(String value) {
    _debouncer.run(() {
      widget.searchMoviesBloc.searchMovies(value);
    });
  }
}
