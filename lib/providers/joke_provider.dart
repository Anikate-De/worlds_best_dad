import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/joke.dart';

class JokeProvider extends ChangeNotifier {
  var client = http.Client();
  bool loadingJoke = true;
  bool isDeliveryVisible = false;
  bool errorOccurred = false;
  late Joke joke;
  Timer? _timer;

  void getJoke({bool safe = true}) async {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    loadingJoke = true;
    isDeliveryVisible = false;
    errorOccurred = false;
    notifyListeners();

    try {
      var url = Uri.parse(safe
          ? "https://joke-api-ad.herokuapp.com/dad/safe/apiKey=Anik12680900"
          : "https://joke-api-ad.herokuapp.com/dad/apiKey=Anik12680900");
      var response = await client.get(url);

      if (response.statusCode != 200) {
        throw Exception('Invalid response from API');
      }

      joke = Joke.fromJsonMap(jsonDecode(response.body));
      showDelivery();
      errorOccurred = false;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      isDeliveryVisible = false;
      errorOccurred = true;
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
    } finally {
      loadingJoke = false;
      notifyListeners();
    }
  }

  void showDelivery() {
    _timer = Timer(Duration(milliseconds: (joke.setup.length * 28) + 800), () {
      isDeliveryVisible = true;
      notifyListeners();
    });
  }
}
