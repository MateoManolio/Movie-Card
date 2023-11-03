import 'package:flutter/material.dart';

import '../../shared/index.dart';
import '../../shared/ui_consts.dart';

class NavbarIcon extends StatefulWidget {
  final IconData icon;
  final int page;

  final Index currentIndex;
  final PageController pageController;

  const NavbarIcon({
    super.key,
    required this.icon,
    required this.page,
    required this.currentIndex,
    required this.pageController,
  });

  @override
  State<NavbarIcon> createState() => _NavbarIconState();
}

class _NavbarIconState extends State<NavbarIcon> {
  static const opacity = 0.5;
  static const animationDuration = 500;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(
          () {
            widget.currentIndex.setIndex(widget.page);
            widget.pageController.animateToPage(
              widget.page,
              duration: const Duration(milliseconds: animationDuration),
              curve: Curves.fastLinearToSlowEaseIn,
            );
          },
        );
      },
      icon: Icon(
        widget.icon,
        color: colors.background.withOpacity(
            widget.currentIndex.getIndex == widget.page ? 1 : opacity),
      ),
    );
  }
}
