import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_card/provider/provider_menu.dart';
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
  List<Movie> movies = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/movies.json');
    final data = await json.decode(response);
    setState(() {
      movies = List.generate(
        data.length,
            (index) => Movie.fromJson(data[index]),
      );
    });
  }

  _MovieMenuState (){
    readJson();
}

  @override
  void initState() {
    readJson();
    super.initState();
  }

  bool filter = false;
  static const backgroundAssets = 'assets/menuBackground.png';

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty){
      return const CircularProgressIndicator();
    }else{
      return Scaffold(
        backgroundColor: colors.onPrimaryContainer,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundAssets),
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
                  movies: movies,
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
}
