import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/joke.dart';

class JokeProvider extends ChangeNotifier {
  var client = http.Client();
  bool loadingJoke = true;
  Joke? joke;

  void getJoke() async {
    loadingJoke = true;
    notifyListeners();

    var url = Uri.parse('https://icanhazdadjoke.com/slack');
    var response = await client.get(url);

    joke = Joke(jsonDecode(response.body)['attachments'][0]['text']);
    loadingJoke = false;
    notifyListeners();
  }
}
