import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }
}
