import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';
import 'side_menu_elements.dart';

class SideMenu extends StatefulWidget {
  final Function(int) optionSelected;

  const SideMenu({
    required this.optionSelected,
    super.key,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  static const double width = 0.75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryContainer,
      body: Center(
        child: SideMenuElements(
          width: MediaQuery.of(context).size.width * width,
          optionSelected: widget.optionSelected,
        ),
      ),
    );
  }
}
