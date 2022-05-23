import 'package:flutter/material.dart';
import 'package:worlds_best_dad/screens/joke_screen.dart';
import 'package:worlds_best_dad/screens/welcome_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: JokeScreen.routeId,
    routes: {
      WelcomeScreen.routeId: (context) => const WelcomeScreen(),
      JokeScreen.routeId: (context) => const JokeScreen(),
    },
  ));
}
