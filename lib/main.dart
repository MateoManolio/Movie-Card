import 'package:flutter/material.dart';
import 'package:movie_card/pages/home_page.dart';
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
      title: 'Movie Cards',
      initialRoute: routeName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        MovieDetails.routeName: (context) => MovieDetails(
              movie: Movie.mockMovie(),
            ),
        HomePage.routeName: (context) => HomePage(
              lastMovie: Movie.mockMovie(),
            ),
      },
      home: HomePage(lastMovie: Movie.mockMovie()),
    );
  }
}
