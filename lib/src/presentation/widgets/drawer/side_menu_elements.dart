import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';
import 'drawer_element.dart';

class SideMenuElements extends StatefulWidget {
  final double width;

  final int selectedPage;

  SideMenuElements({
    required this.width,
    required this.optionSelected,
    required this.selectedPage,
    super.key,
  });

  final Function(int) optionSelected;
  @override
  State<SideMenuElements> createState() => _SideMenuElementsState();
}

class _SideMenuElementsState extends State<SideMenuElements> {
  static const String homeText = "Home";
  static const String popularText = "Most Popular";
  static const String searchText = "Search";
  static const String savedText = "Saved / Liked";

  void goToPage(int newPage) {
    setState(() {
      widget.optionSelected.call(newPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DrawerElement(
          icon: Icons.home,
          text: homeText,
          width: widget.width,
          isActive: widget.selectedPage == homePage,
          onIconTap: goToPage,
          pageRoute: homePage,
        ),
        DrawerElement(
          icon: Icons.stars_rounded,
          text: popularText,
          width: widget.width,
          isActive: widget.selectedPage == popularPage,
          onIconTap: goToPage,
          pageRoute: popularPage,
        ),
        DrawerElement(
          icon: Icons.search_rounded,
          text: searchText,
          width: widget.width,
          isActive: widget.selectedPage == searchPage,
          onIconTap: goToPage,
          pageRoute: searchPage,
        ),
        DrawerElement(
          icon: Icons.bookmark_border_rounded,
          text: savedText,
          width: widget.width,
          isActive: widget.selectedPage == savePage,
          onIconTap: goToPage,
          pageRoute: savePage,
        ),
      ],
    );
  }
}
