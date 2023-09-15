import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';

class DrawerElement extends StatefulWidget {
  final IconData icon;
  final String text;
  final double width;
  final int pageRoute;
  final bool isActive;
  final Function(int) onIconTap;

  DrawerElement({
    required this.icon,
    required this.text,
    required this.width,
    required this.isActive,
    required this.onIconTap,
    required this.pageRoute,
    super.key,
  });

  @override
  State<DrawerElement> createState() => _DrawerElementState();
}

class _DrawerElementState extends State<DrawerElement> {
  static const int animationDuration = 300;
  static const double radius = 10;
  static const double covertWidth = 0.80;
  static const double covertHeight = 50;
  static const double separator = 10;
  static const double leftPadding = 50;
  static const double height = 50;
  static const double fontSize = 25;
  static const double rightPosition = 0;
  static const double closeWidth = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          widget.isActive
              ? AnimatedPositioned(
                  duration: Duration(milliseconds: animationDuration),
                  height: covertHeight,
                  width: widget.isActive ? widget.width * covertWidth : closeWidth,
                  right: rightPosition,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.onPrimaryContainer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        bottomLeft: Radius.circular(radius),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    widget.icon,
                    color: widget.isActive ? colors.background : Colors.black54,
                  ),
                  SizedBox(
                    width: separator,
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: fontSize,
                      color:
                          widget.isActive ? colors.background : Colors.black54,
                    ),
                  ),
                  SizedBox(
                    width: leftPadding,
                  ),
                ],
              ),
              onTap: () {
                widget.onIconTap.call(widget.pageRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
