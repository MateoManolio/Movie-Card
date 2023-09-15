import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/movie.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with TickerProviderStateMixin {
  int likes = 0;

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
        color: colors.primary,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(boxShadowOpacity),
            blurRadius: boxBlurRadius,
            offset: const Offset(boxOffsetX, boxOffsetY),
          ),
        ],
        borderRadius: BorderRadius.circular(navbarRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                widget.movie.toggleLiked();
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                widget.movie.liked
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      )
                    : const Icon(Icons.favorite_border),
                Text(
                  likes.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(
                () {
                  widget.movie.toggleSaved();
                },
              );
            },
            child: widget.movie.saved
                ? const Icon(
                    Icons.bookmark,
                    color: Colors.blue,
                  )
                : const Icon(
                    Icons.bookmark_border,
                  ),
          ),
        ],
      ),
    );
  }
}
