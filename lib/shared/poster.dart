import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  const Poster({
    super.key,
    required this.pad1,
    required this.posterName,
    required this.posterWidth,
  });

  final String posterName;
  final double pad1;
  final double posterWidth;

  static const double borderRadiusCard = 20.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: pad1,
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
            image: AssetImage(posterName),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
