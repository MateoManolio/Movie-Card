import 'package:flutter/material.dart';
import '../../../core/util/ui_consts.dart';
import '../movie/cast_widget.dart';
import '../shared/custom_card.dart';

class CastLoader extends StatelessWidget {
  static const double height = 150;
  static const int quantity = 5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CastWidget.castHeight,
      child: Padding(
        padding: const EdgeInsets.all(loaderPadding),
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: List<Widget>.generate(
            quantity,
            growable: false,
            (int index) => Padding(
              padding: const EdgeInsets.only(right: loaderPadding),
              child: CustomCard(
                padding: loaderPadding,
                child: Container(
                  width: CastWidget.castWidth,
                  height: CastWidget.castHeight,
                  child: Center(
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(loaderLinearBorderRadius),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
