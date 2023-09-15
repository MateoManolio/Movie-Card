import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';

class NavbarIcon extends StatefulWidget {
  final IconData icon;
  final int pageIndex;

  final int currentIndex;

  const NavbarIcon({
    required this.icon,
    required this.pageIndex,
    required this.currentIndex,
    required this.onIconTap,
    super.key,
  });

  final Function(int) onIconTap;

  @override
  State<NavbarIcon> createState() => _NavbarIconState();
}

class _NavbarIconState extends State<NavbarIcon> {
  static const double opacity = 0.5;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => setState(
        () => widget.onIconTap.call(widget.pageIndex),
      ),
      icon: Icon(
        widget.icon,
        color: colors.background
            .withOpacity(widget.currentIndex == widget.pageIndex ? 1 : opacity),
      ),
    );
  }
}
