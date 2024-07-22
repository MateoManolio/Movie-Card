import 'package:flutter/material.dart';

import '../../../core/util/enums.dart';
import '../../../core/util/ui_consts.dart';

class EmptyText extends StatelessWidget {
  final Option option;

  const EmptyText({required this.option});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        option == Option.saved ? 'No saved movies' : 'No liked movies',
        style: titleStyle.copyWith(color: Colors.white.withOpacity(0.9)),
      ),
    );
  }
}
