
import 'package:http/http.dart' show Client;

import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'src/config/route/app_routes.dart';
import 'src/config/theme/app_themes.dart';
import 'src/core/util/strings.dart';
import 'src/data/datasource/local/movie_database.dart';


void main() async {
  const String databaseName = 'movie_database.db1';
  WidgetsFlutterBinding.ensureInitialized();
  final MovieDatabase database =
      await $FloorMovieDatabase.databaseBuilder(databaseName).build();
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<MovieDatabase>(
          create: (_) => database,
        ),
        Provider<Client>(
          create: (_) => Client(),
        ),
      ],
      child: const MyApp(),
    ),
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
