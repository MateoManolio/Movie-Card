import 'package:flutter/material.dart';
import 'pages/movie_details.dart';
import 'shared/movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const routeName = '/';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: routeName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        MovieDetails.routeName: (context) => MovieDetails(
              movie: Movie.mockMovie(),
            ),
      },
      home: MovieDetails(
        movie: Movie.mockMovie(),
      ),
    );
  }
}
