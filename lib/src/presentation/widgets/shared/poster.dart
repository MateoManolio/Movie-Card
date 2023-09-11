import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  const Poster({
    super.key,
    required this.posterPadding,
    required this.posterName,
    required this.posterWidth,
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
          child: Image(
            image: NetworkImage(posterName),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
