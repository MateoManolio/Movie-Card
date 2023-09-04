import 'package:flutter/material.dart';

import '../../shared/ui_consts.dart';

class NavbarIcon extends StatefulWidget {
  final IconData icon;
  final int pageIndex;

  final int currentIndex;
  final PageController pageController;

  const NavbarIcon({
    super.key,
    required this.icon,
    required this.pageIndex,
    required this.currentIndex,
    required this.pageController,
    required this.onIconTap,
  });

  final Function(int) onIconTap;

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
            widget.onIconTap.call(widget.pageIndex);
            widget.pageController.animateToPage(
              widget.pageIndex,
              duration: const Duration(milliseconds: animationDuration),
              curve: Curves.fastLinearToSlowEaseIn,
            );
          },
        );
      },
      icon: Icon(
        widget.icon,
        color: colors.background
            .withOpacity(widget.currentIndex == widget.pageIndex ? 1 : opacity),
      ),
    );
  }
}
