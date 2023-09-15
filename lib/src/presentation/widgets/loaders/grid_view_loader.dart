import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';
import '../shared/custom_card.dart';

class GridViewLoader extends StatelessWidget {
  final int gridCrossAxisCount;
  final int length;

  const GridViewLoader({
    required this.gridCrossAxisCount,
    required this.length,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(loaderPadding),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCrossAxisCount,
          mainAxisSpacing: gridAxisSpacing,
          crossAxisSpacing: gridAxisSpacing,
          childAspectRatio: gridAspectRatio,
        ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List<Widget>.generate(
          length,
          growable: false,
          (int index) => Padding(
            padding: const EdgeInsets.only(right: loaderPadding),
            child: CustomCard(
              padding: loaderPadding,
              child: Center(
                child: LinearProgressIndicator(
                  borderRadius:
                      BorderRadius.circular(loaderLinearBorderRadius),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
