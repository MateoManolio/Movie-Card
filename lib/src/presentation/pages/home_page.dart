import 'package:flutter/material.dart';
import 'package:movie_card/src/presentation/pages/saved_movies.dart';
import 'package:provider/provider.dart';

import '../../core/util/ui_consts.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movies_bloc.dart';
import '../bloc/saved_bloc.dart';
import '../widgets/drawer/drawer.dart';
import '../widgets/drawer/side_menu_elements.dart';
import '../widgets/menu/exit_alert.dart';
import '../widgets/menu/header.dart';
import '../widgets/menu/menu_custom_navbar.dart';
import 'movie_menu.dart';
import 'popular.dart';

class HomePage extends StatefulWidget {
  final MoviesBloc bloc;

  const HomePage({
    required this.bloc,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  static const int initialIndex = 0;
  int selectedIndex = initialIndex;

  late List<Widget> _pages;
  late PageController _pageController;
  static const String backgroundAssets = 'assets/menu_background.png';
  static const int animationPageTransition = 500;

  // For the drawer
  static bool isSideMenuClosed = true;
  static late AnimationController animationController;
  static const int animationDrawerDuration = 200;

  @override
  void initState() {
    widget.bloc.initialize();
    super.initState();
    _pages = <Widget>[
      MovieMenu(
        moviesBloc: widget.bloc,
      ),
      Popular(
        moviesBloc: widget.bloc,
      ),
      SavedMovies(
        bloc: Provider.of<SavedMoviesBloc>(
          context,
          listen: false,
        ),
        setLastMovie: (Movie movie) => widget.bloc.setLastMovie(movie),
        updateMovie: (Movie movie) => widget.bloc.updateMovie(movie),
      ),
    ];
    _pageController = PageController(initialPage: selectedIndex);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: animationDrawerDuration),
    )..addListener(
        () {
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    animationController.dispose();
  }

  Future<bool> _checkExit() async {
    if (selectedIndex != initialIndex) {
      setState(() {
        selectedIndex = initialIndex;
        _pageController.jumpToPage(selectedIndex);
      });
      return false;
    } else {
      final bool? shouldPop = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return const ExitAlert();
        },
      );
      return shouldPop ?? false;
    }
  }

  void goToPage(int newIndex) {
    if (newIndex == homePage) {
      SideMenuElements.setSelectedPage(homePage);
    }
    _pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: animationPageTransition),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void toggleSideMenu() {
    isSideMenuClosed = !isSideMenuClosed;
    isSideMenuClosed
        ? animationController.reverse()
        : animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _checkExit(),
      child: HasDrawer(
        switchToPage: (int newPage) {
          setState(() {
            selectedIndex = newPage;
            toggleSideMenu();
            goToPage(newPage);
          });
        },
        childPage: Scaffold(
          appBar: AppBar(
            flexibleSpace: Header(
              openDrawer: () => toggleSideMenu(),
              isOpen: isSideMenuClosed,
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: colors.onPrimaryContainer,
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundAssets),
                fit: BoxFit.cover,
              ),
            ),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
          ),
          floatingActionButton: MenuCustomNavigationBar(
            currentIndex: selectedIndex,
            onIconTap: (int newPage) {
              selectedIndex = selectedIndex;
              goToPage(newPage);
            },
          ),
        ),
        animationController: animationController,
        isSideMenuClosed: isSideMenuClosed,
      ),
    );
  }
}
