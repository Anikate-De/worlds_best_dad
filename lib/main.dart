import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/providers/favourites_provider.dart';
import 'package:worlds_best_dad/providers/joke_provider.dart';
import 'package:worlds_best_dad/providers/user_settings_provider.dart';
import 'package:worlds_best_dad/screens/about_screen.dart';
import 'package:worlds_best_dad/screens/age_picker_screen.dart';
import 'package:worlds_best_dad/screens/favourites_screen.dart';
import 'package:worlds_best_dad/screens/joke_screen.dart';
import 'package:worlds_best_dad/screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  final ThemeData theme = ThemeData();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<JokeProvider>(
        create: (context) {
          JokeProvider jokeProvider = JokeProvider();
          jokeProvider.getJoke();
          return jokeProvider;
        },
      ),
      ChangeNotifierProvider<FavouritesProvider>(
        create: (context) {
          FavouritesProvider favouritesProvider = FavouritesProvider();
          favouritesProvider.getFavourites();
          return favouritesProvider;
        },
      ),
      ChangeNotifierProvider<UserSettingsProvider>(
        create: (context) {
          UserSettingsProvider userSettingsProvider = UserSettingsProvider();
          userSettingsProvider.getUserSettings();
          return userSettingsProvider;
        },
      ),
    ],
    child: MaterialApp(
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.brown)),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.routeId,
      routes: {
        WelcomeScreen.routeId: (context) => const WelcomeScreen(),
        AgePickerScreen.routeId: (context) => const AgePickerScreen(),
        JokeScreen.routeId: (context) => const JokeScreen(),
        FavouritesScreen.routeId: (context) => const FavouritesScreen(),
        AboutScreen.routeId: (context) => const AboutScreen(),
      },
    ),
  ));
}
