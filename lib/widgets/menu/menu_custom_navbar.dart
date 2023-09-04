import 'package:flutter/material.dart';
import 'navbar_icon.dart';
import '../../shared/ui_consts.dart';

class MenuCustomNavigationBar extends StatelessWidget {
  MenuCustomNavigationBar({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.onIconTap,
  });

  final Function(int) onIconTap;
  int currentIndex;
  PageController pageController;

  static const int homePage = 0;
  static const int searchPage = 1;
  static const int savePage = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * paddingWidth,
        MediaQuery.of(context).size.width * paddingHeight,
        MediaQuery.of(context).size.width * paddingWidth,
        MediaQuery.of(context).size.width * paddingHeight,
      ),
      height: MediaQuery.of(context).size.width * height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(boxShadowOpacity),
            blurRadius: boxBlurRadius,
            offset: const Offset(
              boxOffsetX,
              boxOffsetY,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(navbarRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavbarIcon(
            icon: Icons.home_filled,
            pageIndex: homePage,
            currentIndex: currentIndex,
            pageController: pageController,
            onIconTap: onIconTap,
          ),
          NavbarIcon(
            icon: Icons.search_rounded,
            pageIndex: searchPage,
            currentIndex: currentIndex,
            pageController: pageController,
            onIconTap: onIconTap,
          ),
          NavbarIcon(
            icon: Icons.bookmark_added,
            pageIndex: savePage,
            currentIndex: currentIndex,
            pageController: pageController,
            onIconTap: onIconTap,
          ),
        ],
      ),
    );
  }
}
