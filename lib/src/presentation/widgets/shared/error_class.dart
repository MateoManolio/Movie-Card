import 'package:flutter/cupertino.dart';

class CustomError extends StatelessWidget {
  const CustomError({
    required this.message,
    super.key,
  });

  final String message;
  static const String errorImage = 'assets/error.gif';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(message),
          const Image(
            image: AssetImage(errorImage),
          ),
        ],
      ),
    );
  }
}
