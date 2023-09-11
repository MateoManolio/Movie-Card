import 'package:flutter/material.dart';

import '../../../core/util/ui_consts.dart';


class ExitAlert extends StatelessWidget {
  const ExitAlert({super.key});

  static const alertTitle = 'Exit';
  static const exitAppText = 'Are you sure you want to exit?';
  static const double borderRadius = 12.0;

  static const double titleSize = 32;
  static const double subtitleSize = 16;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text(
        alertTitle,
        style: TextStyle(
          fontSize: titleSize,
        ),
      ),
      backgroundColor: colors.background,
      content: const Text(
        exitAppText,
        style: TextStyle(fontSize: subtitleSize),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('No'),
        ),
      ],
      shadowColor: Colors.black.withOpacity(boxShadowOpacity),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
