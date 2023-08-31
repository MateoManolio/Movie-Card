import 'package:flutter/material.dart';
import 'dart:math';
import 'ui_consts.dart';

class CircularPercentIndicator extends StatelessWidget {
  const CircularPercentIndicator({
    super.key,
    required this.percentIndicator,
    required this.radiusPercentIndicator,
  });

  final double percentIndicator;
  final double radiusPercentIndicator;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCircularPercentIndicatorPainter(
        percent: percentIndicator,
        progressColor: Colors.lightGreenAccent.shade700,
        backgroundColor: Colors.grey,
        lineWidth: lineWidthPercentIndicator,
        radius: radiusPercentIndicator,
      ),
      child: Text(
        "${(percentIndicator * 100).toStringAsFixed(0)}%",
        style: TextStyle(
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}

class MyCircularPercentIndicatorPainter extends CustomPainter {
  final double percent;
  final Color progressColor;
  final Color backgroundColor;
  final double lineWidth;
  final double radius;

  MyCircularPercentIndicatorPainter({
    required this.percent,
    required this.progressColor,
    required this.backgroundColor,
    required this.lineWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);

    paint.color = progressColor;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ),
      0,
      2 * pi * percent,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
