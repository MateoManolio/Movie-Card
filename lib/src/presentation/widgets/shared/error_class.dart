import 'package:flutter/cupertino.dart';

import '../../../core/util/ui_consts.dart';

class CustomError extends StatelessWidget {
  const CustomError({
    required this.message,
    super.key,
  });

  final String message;
  static const String errorImage = 'assets/error.gif';
  static const double borderRadius = 12;
  static const double padding = 15;
  static const double imagePadding = 8;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            color: colors.errorContainer,
            child: Column(
              children: <Widget>[
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(imagePadding),
                  child: const Image(
                    image: AssetImage(errorImage),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
