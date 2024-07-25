import 'package:flutter/material.dart';
import '../../../core/util/ui_consts.dart';
import 'navbar_icon.dart';

class MenuCustomNavigationBar extends StatelessWidget {
  MenuCustomNavigationBar({
    required this.currentIndex,
    required this.onIconTap,
    super.key,
  });

  final Function(int) onIconTap;
  final int currentIndex;

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
        boxShadow: <BoxShadow>[
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
        children: <Widget>[
          NavbarIcon(
            icon: Icons.home_filled,
            pageIndex: homePage,
            currentIndex: currentIndex,
            onIconTap: onIconTap,
          ),
          NavbarIcon(
            icon: Icons.search_rounded,
            pageIndex: searchPage,
            currentIndex: currentIndex,
            onIconTap: onIconTap,
          ),
          NavbarIcon(
            icon: Icons.bookmark_added,
            pageIndex: savePage,
            currentIndex: currentIndex,
            onIconTap: onIconTap,
          ),
        ],
      ),
    );
  }
}
