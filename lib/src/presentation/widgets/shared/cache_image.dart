import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'error_class.dart';

class CacheImage extends StatelessWidget {
  final String url;

  const CacheImage({
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (
        BuildContext context,
        String url,
      ) =>
          Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (
        BuildContext context,
        String url,
        Object error,
      ) =>
          CustomError(message: error.toString()),
      fit: BoxFit.cover,
    );
  }
}
