import 'package:flutter/material.dart';
import 'package:movie_card/shared/ui_consts.dart';

class MenuCustomNavigationBar extends StatefulWidget {
  MenuCustomNavigationBar({super.key, required this.filter});

  bool filter;

  @override
  State<MenuCustomNavigationBar> createState() =>
      _MenuCustomNavigationBarState();
}

class _MenuCustomNavigationBarState extends State<MenuCustomNavigationBar> {
  static const opacity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * paddingWidth,
        MediaQuery.of(context).size.width * paddingHeight,
        MediaQuery.of(context).size.width * paddingWidth,
        MediaQuery.of(context).size.width * paddingHeight,
      ),
      height: MediaQuery.of(context).size.width * height,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(boxShadowOpacity),
              blurRadius: boxBlurRadius,
              offset: const Offset(
                boxOffsetX,
                boxOffsetY,
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(navbarRadius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                widget.filter = false;
              });
            },
            icon: Icon(
              Icons.home_filled,
              color: colors.background.withOpacity(widget.filter ? opacity : 1),
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  widget.filter = true;
                });
              },
              icon: Icon(
                Icons.bookmark_added,
                color:
                    colors.background.withOpacity(widget.filter ? 1 : opacity),
              )),
        ],
      ),
    );
  }
}
