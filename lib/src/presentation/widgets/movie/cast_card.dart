import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/cast.dart';

class CastCard extends StatelessWidget {
  const CastCard({
    required this.castWidth,
    required this.castHeight,
    required this.index,
    required this.images,
    super.key,
  });

  final int index;
  static const double padCast = 10.0;
  static const double borderRadius = 10.0;
  final List<Cast> images;
  final double castWidth;
  final double castHeight;

  @override
  Widget build(BuildContext context) {
    if (images[index].profilePath != 'null') {
      return Padding(
        padding: EdgeInsets.all(padCast),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: CachedNetworkImage(
            imageUrl: images[index].assetsCastPath,
            placeholder: (BuildContext context, String url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (
              BuildContext context,
              String url,
              Object error,
            ) =>
                Icon(Icons.error),
            width: castWidth,
            height: castHeight,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
