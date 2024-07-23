import 'dart:async';

import 'package:flutter/material.dart';

import '../../../config/route/app_routes.dart';
import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/movie.dart';
import '../../navigation/movie_details_args.dart';
import '../shared/cache_image.dart';

class Carrousel extends StatefulWidget {
  final List<Movie> movies;
  final Function(Movie) setLastMovie;
  final Function(Movie) updateMovie;
  late Timer _timer;

  Timer get getTimer => _timer;

  Carrousel({
    required this.movies,
    required this.setLastMovie,
    required this.updateMovie,
    super.key,
  });

  @override
  State<Carrousel> createState() => _CarrouselState();
}

class _CarrouselState extends State<Carrousel> {
  static const double viewportFraction = 0.9;
  static const int switchDuration = 5;
  static const int animationSwitchDuration = 200;
  static const int animationGoToPageDuration = 350;
  static const double height = 200;

  static const double positionBottomDots = 20;
  static const double positionSideDots = 0;
  static const double bigDotsWidth = 30;
  static const double smallDotsWidth = 10;
  static const double dotsHeight = 12;

  static const int numberOfElements = 10;

  PageController _pageController =
      PageController(viewportFraction: viewportFraction);

  Timer timer() {
    return Timer.periodic(
      Duration(seconds: switchDuration),
      (Timer timer) {
        _currentPage < numberOfElements ? _currentPage++ : _currentPage = 0;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: animationSwitchDuration),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  int _currentPage = 0;

  @override
  initState() {
    widget._timer = timer();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    widget._timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: numberOfElements,
            onPageChanged: (int newPage) => setState(
              () => _currentPage = newPage,
            ),
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return InkWell(
                onTap: () {
                  widget._timer.cancel();
                  Navigator.pushNamed(
                    context,
                    Routes.movieDetailsRouteName,
                    arguments: MovieDetailsArguments(
                      movie: widget.movies[_currentPage],
                      setLastMovie: widget.setLastMovie,
                      backdropTag: '',
                      posterTag: '',
                      updateMovie: widget.updateMovie,
                    ),
                  );
                },
                child: Card(
                  child: CacheImage(
                    url: widget.movies[index].assetsBackdropPath,
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
              );
            },
          ),
          Positioned(
            left: positionSideDots,
            right: positionSideDots,
            bottom: positionBottomDots,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < numberOfElements; i++)
                  GestureDetector(
                    key: ValueKey<int>(i),
                    onTap: () => _pageController.animateToPage(
                      i,
                      duration: Duration(
                        milliseconds: animationGoToPageDuration,
                      ),
                      curve: Curves.easeIn,
                    ),
                    child: AnimatedContainer(
                      duration: Duration(
                        milliseconds: animationSwitchDuration,
                      ),
                      curve: Curves.easeInOut,
                      width: i == _currentPage ? bigDotsWidth : smallDotsWidth,
                      height: dotsHeight,
                      decoration: BoxDecoration(
                        color:
                            i == _currentPage ? colors.primary : Colors.black26,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
