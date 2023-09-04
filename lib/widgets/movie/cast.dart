import 'package:flutter/material.dart';
import 'cast_card.dart';
import '../../shared/ui_consts.dart';

class Cast extends StatelessWidget {
  const Cast({
    super.key,
    required this.castImages,
  });

  final List<String> castImages;

  static const double padCast = 10.0;
  static const double castWidth = 150.0;
  static const double castHeight = 230.0;
  static const double borderRadius = 10.0;
  static const String title = 'Cast';

  @override
  Widget build(BuildContext context) {
    if (castImages.isEmpty) {
      return Container();
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
              itemBuilder: (context, index) => CastCard(
                padCast: padCast,
                borderRadius: borderRadius,
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
}
