import 'package:flutter/material.dart';
import 'src/config/route/app_routes.dart';
import 'src/config/theme/app_themes.dart';
import 'src/core/util/strings.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      initialRoute: Routes.homeRouteName,
      theme: AppTheme.dark,
      routes: AppRoutes.routes,
    );
  }
}
