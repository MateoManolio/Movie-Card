import 'package:flutter/material.dart';
import '../../shared/movie.dart';
import '../../shared/ui_consts.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with TickerProviderStateMixin {
  var liked = false;
  var saved = false;
  var likes = 0;
  late final AnimationController _likeController;
  late final AnimationController _saveController;

  static const int likeSeconds = 3;
  static const int saveMilliseconds = 1500;

  @override
  void initState() {
    super.initState();
    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: likeSeconds),
    );
    _saveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: saveMilliseconds),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _likeController.dispose();
    _saveController.dispose();
  }

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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(boxShadowOpacity),
              blurRadius: boxBlurRadius,
              offset: const Offset(boxOffsetX, boxOffsetY),
            ),
          ],
          borderRadius: BorderRadius.circular(navbarRadius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              if (liked) {
                _likeController.reverse();
                likes++;
              } else {
                _likeController.forward();
              }
              setState(() {
                liked = !liked;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                liked
                    ? const Icon(Icons.favorite_border)
                    : const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
                Text(
                  likes.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (saved) {
                _saveController.reverse();
              } else {
                _saveController.forward();
              }
              setState(() {
                saved = !saved;
                widget.movie.toggleSaved();
              });
            },
            child: saved
                ? const Icon(
                    Icons.bookmark_border,
                  )
                : const Icon(
                    Icons.bookmark,
                    color: Colors.blue,
                  ),
          ),
        ],
      ),
    );
  }
}
