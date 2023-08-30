import 'package:flutter/material.dart';
import 'package:movie_card/shared/movie.dart';
import 'package:movie_card/widgets/menu/header.dart';
import 'package:movie_card/shared/ui_consts.dart';
import 'package:movie_card/widgets/menu/last_seen.dart';
import 'package:movie_card/widgets/menu/menu_custom_navbar.dart';
import 'package:movie_card/widgets/menu/movies.dart';

class MovieMenu extends StatefulWidget {
  const MovieMenu({super.key});

  static const String routeName = "/menu";

  @override
  State<MovieMenu> createState() => _MovieMenuState();
}

class _MovieMenuState extends State<MovieMenu> {

  bool filter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.onPrimaryContainer,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/menuBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              LastSeen(
                movie: Movie.mockMovie(),
              ),
              Movies(
                movie: Movie.mockMovie(),
                filter: filter,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MenuCustomNavigationBar(
        filter: filter,
      ),
    );
  }
}
