import 'package:flutter/material.dart';
import '../../core/util/ui_consts.dart';
import '../../domain/entity/movie.dart';
import 'movie_menu.dart';
import '../widgets/menu/exit_alert.dart';
import '../widgets/menu/menu_custom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.lastMovie,
    super.key,
  });

  final Movie lastMovie;

  static const String routeName = "/home";

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  static const int initialIndex = 0;
  int selectedIndex = initialIndex;
  late List<Widget> _pages;
  late PageController _pageController;
  static const String backgroundAssets = 'assets/menu_background.png';

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      MovieMenu(lastMovie: widget.lastMovie),
    ];
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _checkExit(),
      child: Scaffold(
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
          pageController: _pageController,
          currentIndex: selectedIndex,
          onIconTap: (int selectedIndex) => this.selectedIndex = selectedIndex,
        ),
      ),
    );
  }
}
