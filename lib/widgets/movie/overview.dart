import 'package:flutter/material.dart';
import '../../shared/ui_consts.dart';

class Overview extends StatelessWidget {
  const Overview({
    super.key,
    required this.overview,
  });

  final String overview;
  static const String title = "Overview";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: titleStyle,
      ),
      subtitle: Text(
        overview,
      ),
      textColor: Theme.of(context).colorScheme.background,
    );
  }
}
