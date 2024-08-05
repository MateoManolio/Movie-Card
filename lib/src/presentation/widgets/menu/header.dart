import 'package:flutter/material.dart';
import '../../../core/util/ui_consts.dart';

class Header extends StatefulWidget {
  Header({
    required this.openDrawer,
    required this.isOpen,
    super.key,
  });

  final Function() openDrawer;
  final bool isOpen;
  static const String title = "TMDB";
  static const String logo = 'assets/logo/logoTMDB.png';
  static const double padding = 25.0;
  static const double height = 30;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin {
  late AnimationController _controller;
  static const int animationDuration = 350;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.isOpen ? _controller.reverse() : _controller.forward();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Header.padding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  Header.title,
                  style: titleStyle,
                ),
                Image(
                  height: Header.height,
                  image: AssetImage(Header.logo),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                widget.openDrawer.call();
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _controller,
                color: colors.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
