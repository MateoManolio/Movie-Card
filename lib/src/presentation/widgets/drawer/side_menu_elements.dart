import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';
import 'drawer_element.dart';

class SideMenuElements extends StatefulWidget {
  final double width;

  static int selectedPage = homePage;

  SideMenuElements({
    required this.width,
    required this.optionSelected,
    super.key,
  });

  static void setSelectedPage(int newPage){
    selectedPage = newPage;
  }

  final Function(int) optionSelected;
  @override
  State<SideMenuElements> createState() => _SideMenuElementsState();
}

class _SideMenuElementsState extends State<SideMenuElements> {
  static const String homeText = "Home";
  static const String popularText = "Most Popular";
  static const String upcomingText = "Upcoming";
  void goToPage(int newPage) {
    setState(() {
      SideMenuElements.setSelectedPage(newPage);
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
          isActive: SideMenuElements.selectedPage == homePage,
          onIconTap: goToPage,
          pageRoute: homePage,
        ),
        DrawerElement(
          icon: Icons.stars_rounded,
          text: popularText,
          width: widget.width,
          isActive: SideMenuElements.selectedPage == popularPage,
          onIconTap: goToPage,
          pageRoute: popularPage,
        ),
        DrawerElement(
          icon: Icons.calendar_today_rounded,
          text: upcomingText,
          width: widget.width,
          isActive: SideMenuElements.selectedPage == upcomingPage,
          onIconTap: goToPage,
          pageRoute: upcomingPage,
        ),
      ],
    );
  }
}
