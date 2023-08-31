import 'package:flutter/material.dart';
import 'package:movie_card/widgets/movie/cast_card.dart';
import 'package:movie_card/shared/ui_consts.dart';

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

  @override
  Widget build(BuildContext context) {
    if (castImages.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              "Cast",
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
                  images: castImages),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
