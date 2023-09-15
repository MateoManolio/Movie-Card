import 'package:flutter/material.dart';
import 'cache_image.dart';

class Poster extends StatelessWidget {
  const Poster({
    required this.posterPadding,
    required this.posterName,
    required this.posterWidth,
    super.key,
  });

  final String posterName;
  final double posterPadding;
  final double posterWidth;

  static const double borderRadiusCard = 15.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: posterPadding,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusCard),
        child: Container(
          width: posterWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              width: 3.0,
            ),
          ),
          child: CacheImage(url: posterName),
        ),
      ),
    );
  }
}
