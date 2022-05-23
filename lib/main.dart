import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/providers/joke_provider.dart';
import 'package:worlds_best_dad/screens/joke_screen.dart';
import 'package:worlds_best_dad/screens/welcome_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<JokeProvider>(
      create: (context) {
        JokeProvider jokeProvider = JokeProvider();
        jokeProvider.getJoke();
        return jokeProvider;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.routeId,
        routes: {
          WelcomeScreen.routeId: (context) => const WelcomeScreen(),
          JokeScreen.routeId: (context) => const JokeScreen(),
        },
      ),
    ),
  );
}
