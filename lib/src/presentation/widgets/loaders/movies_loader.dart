import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';
import '../menu/movies.dart';
import '../shared/custom_card.dart';

class MoviesLoader extends StatelessWidget {
  static const double height = 150;
  static const int quantity = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(loaderPadding),
      child: ListView(
        shrinkWrap: true,
        children: List<Widget>.generate(
          quantity,
          growable: false,
          (int index) => Padding(
            padding: const EdgeInsets.only(bottom: loaderPadding),
            child: CustomCard(
              padding: Movies.posterPadding,
              child: Container(
                width: MediaQuery.of(context).size.width * Movies.width,
                height: height,
                child: Center(
                  child: LinearProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
