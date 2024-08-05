import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';
import 'side_menu_elements.dart';

class SideMenu extends StatelessWidget {
  final Function(int) optionSelected;
  final int selectedPage;

  const SideMenu({
    required this.optionSelected,
    required this.selectedPage,
    super.key,
  });

  static const double width = 0.75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryContainer,
      body: Center(
        child: SideMenuElements(
          width: MediaQuery.of(context).size.width * width,
          optionSelected: optionSelected,
          selectedPage: selectedPage,
        ),
      ),
    );
  }
}
