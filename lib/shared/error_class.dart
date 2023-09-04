import 'package:flutter/cupertino.dart';

class CustomError extends StatelessWidget {
  const CustomError({
    super.key,
    required this.message,
  });

  final String message;
  static const errorImage = 'assets/error.gif';

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
