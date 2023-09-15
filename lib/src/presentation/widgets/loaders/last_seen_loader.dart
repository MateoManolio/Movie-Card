import 'package:flutter/material.dart';
import '../../../core/util/ui_consts.dart';
import '../shared/custom_card.dart';
import '../menu/last_seen.dart';

class LastSeenLoader extends StatelessWidget {
  static const double height = 100;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(loaderPadding),
      child: CustomCard(
        padding: LastSeen.sidePadding,
        child: Container(
          width: double.infinity,
          height: height,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
