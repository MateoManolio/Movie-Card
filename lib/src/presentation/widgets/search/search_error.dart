import 'package:flutter/material.dart';
import '../../../core/util/ui_consts.dart';

class SearchError extends StatelessWidget {
  const SearchError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            size: 50,
            color: colors.error,
          ),
          const SizedBox(height: 10),
          Text(
            'Error to bring the movies',
            style: TextStyle(
              fontSize: 20,
              color: colors.error,
            ),
          ),
        ],
      ),
    );
  }
}
