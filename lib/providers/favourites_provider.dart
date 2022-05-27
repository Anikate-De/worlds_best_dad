import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worlds_best_dad/models/joke.dart';

class FavouritesProvider extends ChangeNotifier {
  late SharedPreferences sharedPreferences;

  final List<Joke> _favouriteJokes = [];

  List<Joke> get favouriteJokes {
    return UnmodifiableListView(_favouriteJokes);
  }

  void getFavourites() async {
    sharedPreferences = await SharedPreferences.getInstance();
    for (Map<String, dynamic> jsonMap
        in (jsonDecode(sharedPreferences.getString('favourites') ?? '[]')
            as List<dynamic>)) {
      _favouriteJokes.add(
        Joke.fromJsonMap(
          jsonMap,
        ),
      );
    }

    notifyListeners();
  }

  void addToFavourites(Joke joke) {
    _favouriteJokes.add(joke);
    notifyListeners();
  }

  void removeFromFavourites(Joke joke) {
    _favouriteJokes.removeWhere((element) =>
        element.setup == joke.setup && element.delivery == joke.delivery);
    notifyListeners();
  }

  void modifyFavourites(Joke joke) async {
    if (isInFavourites(joke)) {
      removeFromFavourites(joke);
    } else {
      addToFavourites(joke);
    }

    await sharedPreferences.setString(
      'favourites',
      jsonEncode(
        _favouriteJokes
            .map(
              (joke) => joke.toJsonMap(),
            )
            .toList(),
      ),
    );
  }

  bool isInFavourites(Joke joke) {
    return _favouriteJokes.any((Joke favourite) =>
        favourite.setup == joke.setup && favourite.delivery == joke.delivery);
  }
}
