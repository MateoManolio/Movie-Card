import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/util/enums.dart';
import '../../core/util/ui_consts.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';
import '../bloc/saved_bloc.dart';
import '../widgets/loaders/grid_view_loader.dart';
import '../widgets/saved/grid_card.dart';
import '../widgets/saved/switch_button.dart';
import '../widgets/shared/error_class.dart';

class SavedMovies extends StatefulWidget {
  final SavedMoviesBloc bloc;
  final Function(Movie) setLastMovie;
  final Function(Movie) updateMovie;

  SavedMovies({
    required this.bloc,
    required this.setLastMovie,
    required this.updateMovie,
  });

  static const double initSeparation = 20;
  static const int gridCrossAxisCount = 3;

  @override
  State<SavedMovies> createState() => _SavedMoviesState();
}

class _SavedMoviesState extends State<SavedMovies> {
  Option option = Option.saved;
  static const int gridViewLoaderListSize = 4;
  static const double gridPadding = 12;
  static const String errorMessageSaved = 'Error to bring the movies';

  void initialization() async {
    option = await widget.bloc.option;
    switch (option) {
      case Option.saved:
        unawaited(widget.bloc.getSavedMovies());
      case Option.liked:
        unawaited(widget.bloc.getLikedMovies());
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initialization();
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: SavedMovies.initSeparation,
              ),
              SwitchButton(
                option: option,
                newOptionSelected: (Option option) {
                  setState(() {
                    widget.bloc.setOption(option);
                  });
                },
              ),
              const SizedBox(
                height: SavedMovies.initSeparation,
              ),
              StreamBuilder<Event<List<Movie>>>(
                stream: widget.bloc.stream,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<Event<List<Movie>>> snapshot,
                ) {
                  switch (snapshot.data?.state) {
                    case null:
                    case Status.loading:
                      return GridViewLoader(
                        gridCrossAxisCount: SavedMovies.gridCrossAxisCount,
                        length: gridViewLoaderListSize,
                      );
                    case Status.empty:
                    case Status.success:
                      return Padding(
                        padding: const EdgeInsets.all(gridPadding),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: SavedMovies.gridCrossAxisCount,
                            mainAxisSpacing: gridAxisSpacing,
                            crossAxisSpacing: gridAxisSpacing,
                            childAspectRatio: gridAspectRatio,
                          ),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return GridCard(
                              movie: snapshot.data!.data![index],
                              setLastMovie: widget.setLastMovie,
                              updateMovie: (Movie movie) {
                                setState(() {
                                  widget.updateMovie(movie);
                                });
                              },
                            );
                          },
                        ),
                      );
                    case Status.error:
                      return CustomError(
                        message: errorMessageSaved,
                      );
                  }
                },
              ),
            ],
          ),
        ),
    );
  }
}
