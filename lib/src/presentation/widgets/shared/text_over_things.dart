import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';

class TextOverThings extends StatelessWidget {
  final String title;
  final double fontSize;
  final double strokeWidth;

  const TextOverThings({
    required this.title,
    this.fontSize = 24,
    this.strokeWidth = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = Colors.black,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: colors.background,
          ),
        ),
      ],
    );
  }
}
