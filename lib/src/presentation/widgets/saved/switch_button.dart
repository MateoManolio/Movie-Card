import 'package:flutter/material.dart';

import '../../../core/util/enums.dart';
import '../../../core/util/ui_consts.dart';

class SwitchButton extends StatelessWidget {
  final Color selectedColor;
  final Color secondaryColor;
  final Option option;
  final Function(Option) newOptionSelected;

  const SwitchButton({
    required this.option,
    required this.newOptionSelected,
    Color? color1,
    Color? color2,
    super.key,
  })  : selectedColor = color1 ?? Colors.deepPurpleAccent,
        secondaryColor = color2 ?? Colors.deepPurple;

  static const double containerHeight = 30;
  static const double containerWith = 100;

  static const double borderRadius = 12;
  static const double insidePadding = 10;

  static const int animationDuration = 500;

  static const String savedText = 'saved';
  static const String likedText = 'liked';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius:
              BorderRadius.horizontal(left: Radius.circular(borderRadius)),
          child: InkWell(
            onTap: () {
              if (option != Option.saved) {
                newOptionSelected(Option.saved);
              }
            },
            child: AnimatedContainer(
              height: containerHeight,
              width: containerWith,
              color: option == Option.saved ? selectedColor : secondaryColor,
              duration: Duration(milliseconds: animationDuration),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: insidePadding),
                child: Center(
                  child: Text(
                    savedText,
                    style: TextStyle(color: colors.background),
                  ),
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius:
              BorderRadius.horizontal(right: Radius.circular(borderRadius)),
          child: InkWell(
            onTap: () {
              if (option != Option.liked) {
                newOptionSelected(Option.liked);
              }
            },
            child: AnimatedContainer(
              height: containerHeight,
              width: containerWith,
              color: option == Option.liked ? selectedColor : secondaryColor,
              duration: Duration(milliseconds: animationDuration),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: insidePadding),
                child: Center(
                  child: Text(
                    likedText,
                    style: TextStyle(color: colors.background),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
