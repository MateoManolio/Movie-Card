import 'dart:math';
import 'package:flutter/material.dart';
import 'side_menu.dart';

class HasDrawer extends StatefulWidget {
  final Widget childPage;
  final Function(int) switchToPage;
  final AnimationController animationController;
  bool isSideMenuClosed;

  HasDrawer({
    required this.childPage,
    required this.switchToPage,
    required this.animationController,
    required this.isSideMenuClosed,
    super.key,
  });

  @override
  State<HasDrawer> createState() => _HasDrawerState();
}

class _HasDrawerState extends State<HasDrawer>
    with SingleTickerProviderStateMixin {
  static const int animationDrawerDuration = 200;
  static const double drawerSize = 0.725;
  static const double borderRadius = 24;
  static const double rotateDegree = 30;
  static const double smallScale = 0.85;

  late Animation<double> openDrawerAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    openDrawerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scaleAnimation = Tween<double>(begin: 1, end: smallScale).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          duration: Duration(milliseconds: animationDrawerDuration),
          curve: Curves.fastOutSlowIn,
          right: widget.isSideMenuClosed
              ? -MediaQuery.of(context).size.width * drawerSize
              : 0,
          child: SideMenu(
            optionSelected: (int newPage) {
              widget.isSideMenuClosed = !widget.isSideMenuClosed;
              widget.switchToPage.call(newPage);
            },
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(
              rotateDegree * openDrawerAnimation.value * pi / 180 -
                  openDrawerAnimation.value,
            ),
          child: Transform.translate(
            offset: Offset(
              -openDrawerAnimation.value *
                  MediaQuery.of(context).size.width *
                  drawerSize,
              0,
            ),
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    openDrawerAnimation.value * borderRadius,
                  ),
                ),
                child: widget.childPage,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
