import 'dart:ui';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    required this.padding,
    super.key,
  });

  final Widget child;
  final double padding;

  static const double borderRadius = 12.0;
  static const double blur = 5.0;
  static const double borderOpacity = 0.5;
  static const double borderWidth = 1.2;
  static const double opacity = 0.15;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(borderOpacity),
              width: borderWidth,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white.withOpacity(opacity),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: child,
          ),
        ),
      ),
    );
  }
}
