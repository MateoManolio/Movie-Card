import 'package:flutter/material.dart';
import '../../shared/ui_consts.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  static const String title = "TMDB";
  static const String logo = 'assets/logo/logoTMDB.png';
  static const double padding = 25.0;
  static const double height = 30;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: padding,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            Image.asset(
              logo,
              height: height,
            ),
          ],
        ),
      ),
    );
  }
}
