import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/cast.dart';
import '../shared/custom_card.dart';

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
  static const double textPadding = 10.0;
  static const double cardPadding = 0;
  static const String asset = 'assets/error/default_cast.png';
  static const String messageError = 'No internet';
  final List<Cast> images;
  final double castWidth;
  final double castHeight;

  @override
  Widget build(BuildContext context) {
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
                CustomCard(
              padding: cardPadding,
              child: Column(
                children: <Widget>[
                  Image.asset(asset),
                  Padding(
                    padding: EdgeInsets.only(top: textPadding),
                    child: Text(
                      messageError,
                      style: TextStyle(
                        color: colors.background,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            width: castWidth,
            height: castHeight,
            fit: BoxFit.cover,
          ),
        ),
      );
  }
}
