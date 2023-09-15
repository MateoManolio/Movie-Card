import 'package:flutter/material.dart';
import '../../../core/util/ui_consts.dart';
import '../../../domain/entity/cast.dart';
import 'cast_card.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({
    required this.castImages,
    super.key,
  });

  final List<Cast> castImages;

  static const double castWidth = 150.0;
  static const double castHeight = 230.0;
  static const String title = 'Cast';

  @override
  Widget build(BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              title,
              style: titleStyle,
            ),
          ),
          SizedBox(
            height: castHeight,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: castImages.length,
              itemBuilder: (BuildContext context, int index) => CastCard(
                castWidth: castWidth,
                castHeight: castHeight,
                index: index,
                images: castImages,
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      );
    }
}
