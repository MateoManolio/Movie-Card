import 'package:flutter/material.dart';

import '../../core/util/enums.dart';
import '../../core/util/ui_consts.dart';
import '../../domain/entity/event.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movies_bloc.dart';
import '../widgets/loaders/grid_view_loader.dart';
import '../widgets/loaders/last_seen_loader.dart';
import '../widgets/popular/carrousel.dart';
import '../widgets/popular/grid_card.dart';
import '../widgets/shared/error_class.dart';

class Popular extends StatefulWidget {
  final Stream<Event<List<Movie>>> popularMoviesStream;
  final Stream<Event<List<Movie>>> nowPlayingMoviesStream;
  final Function() onPageInit;

  const Popular({
    required this.popularMoviesStream,
    required this.nowPlayingMoviesStream,
    required this.onPageInit,
    super.key,
  });

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  static const String title = 'Most Popular';
  static const String errorMessagePopular = 'Error to bring the Popular movies';
  static const String errorMessageNowPlaying =
      'Error to bring the Now Playing movies';

  static const double gridPadding = 12;
  static const int gridCrossAxisCount = 2;
  static const double space = 30;
  static const int gridViewLoaderListSize = 4;

  static const double endHeight = 150;


  get selectedIndex => 0;

  @override
  void initState() {
    widget.onPageInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder<Event<List<Movie>>>(
            stream: widget.nowPlayingMoviesStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<Event<List<Movie>>> snapshot,
            ) {
              switch (snapshot.data?.state) {
                case null:
                case Status.loading:
                  return LastSeenLoader();
                case Status.empty:
                case Status.success:
                  return Carrousel(movies: snapshot.data!.data!);
                case Status.error:
                  return CustomError(
                    message: errorMessageNowPlaying,
                  );
              }
            },
          ),
          SizedBox(
            height: space,
          ),
          Center(
            child: Text(
              title,
              style: titleStyle,
            ),
          ),
          StreamBuilder<Event<List<Movie>>>(
            stream: widget.popularMoviesStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<Event<List<Movie>>> snapshot,
            ) {
              switch (snapshot.data?.state) {
                case null:
                case Status.loading:
                  return GridViewLoader(
                    gridCrossAxisCount: gridCrossAxisCount,
                    length: gridViewLoaderListSize,
                  );
                case Status.empty:
                case Status.success:
                  return Padding(
                    padding: const EdgeInsets.all(gridPadding),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCrossAxisCount,
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
                        return GridCard(movie: snapshot.data!.data![index]);
                      },
                    ),
                  );
                case Status.error:
                  return CustomError(
                    message: errorMessagePopular,
                  );
              }
            },
          ),
          SizedBox(
            height: endHeight,
          ),
        ],
      ),
    );
  }
}
