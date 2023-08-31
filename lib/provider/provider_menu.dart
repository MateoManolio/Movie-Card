import 'package:flutter/services.dart' show rootBundle;

class _ProviderMenu {
  static const String moviesLocation = 'assets/movies.json';
  List<dynamic> jsonMovies = [];
  _ProviderMenu(){
    loadData();
  }

  void loadData() {
    rootBundle.loadString(moviesLocation);
  }
}

final menuProvider = _ProviderMenu();