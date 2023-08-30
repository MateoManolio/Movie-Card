import 'package:flutter/material.dart';
import 'package:movie_card/shared/ui_consts.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  static const String title = "TMDB";
  static const String logo = 'assets/logo/logoTMDB.png';
  static const double padding = 25.0;
  static const double height = 30;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: padding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: titleStyle,
                ),
                Image.asset(
                  logo,
                  height: height,
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchMovieDelegate(),
                );
              },
              icon: Icon(
                Icons.search_rounded,
                color: colors.background,
                size: height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchMovieDelegate extends SearchDelegate {
  static const title = 'Search movie!';

  @override
  String get searchFieldLabel => title;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Text("data"),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(
        context,
        null,
      ),
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('Build Suggestions');
  }
}
