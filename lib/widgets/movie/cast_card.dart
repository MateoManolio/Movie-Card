import 'package:flutter/material.dart';

class CastCard extends StatelessWidget {
  const CastCard({
    super.key,
    required this.padCast,
    required this.borderRadius,
    required this.castWidth,
    required this.castHeight,
    required this.index,
    required this.images,
  });

  final int index;
  final double padCast;
  final double borderRadius;
  final List<String> images;
  final double castWidth;
  final double castHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padCast),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image(
          image: NetworkImage(images[index]),
          width: castWidth,
          height: castHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
