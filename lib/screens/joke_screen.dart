import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/providers/favourites_provider.dart';
import 'package:worlds_best_dad/providers/joke_provider.dart';
import 'package:worlds_best_dad/providers/user_settings_provider.dart';
import 'package:worlds_best_dad/screens/about_screen.dart';
import 'package:worlds_best_dad/screens/favourites_screen.dart';
import 'package:worlds_best_dad/screens/welcome_screen.dart';

import '../widgets/joke_card.dart';
import '../widgets/logo_svg.dart';

class JokeScreen extends StatelessWidget {
  static String routeId = 'joke';

  const JokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    bool isLandscapeOriented =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Consumer3<JokeProvider, FavouritesProvider, UserSettingsProvider>(
      builder: (context, jokeProvider, favouritesProvider, userSettingsProvider,
          child) {
        if (jokeProvider.errorOccurred) {
          Future.delayed(
              Duration.zero,
              () => Navigator.pushReplacementNamed(
                  context, WelcomeScreen.routeId));
        }
        return Scaffold(
          backgroundColor: Colors.amber.shade50,
          appBar: AppBar(
            centerTitle: true,
            title: isLandscapeOriented
                ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SvgPicture.asset(
                      'assets/vectors/mustache.svg',
                      fit: BoxFit.fitHeight,
                      height: 46,
                      color: Colors.brown,
                    ),
                  )
                : const SizedBox.shrink(),
            actionsIconTheme: const IconThemeData(
              color: Colors.brown,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              InkWell(
                splashColor: Colors.brown.shade200,
                onTap: () =>
                    Navigator.pushNamed(context, FavouritesScreen.routeId),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: favouritesProvider.favouriteJokes.isNotEmpty
                      ? Badge(
                          animationDuration: const Duration(milliseconds: 150),
                          animationType: BadgeAnimationType.scale,
                          position: BadgePosition.topEnd(top: 2),
                          badgeColor: Colors.white,
                          badgeContent: Text(
                            favouritesProvider.favouriteJokes.length.toString(),
                            style: GoogleFonts.varelaRound(
                                color: Colors.brown,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                          ),
                        )
                      : const Icon(
                          Icons.favorite_rounded,
                        ),
                ),
              ),
              InkWell(
                splashColor: Colors.brown.shade200,
                onTap: () => Navigator.pushNamed(context, AboutScreen.routeId),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.more_vert_rounded,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isLandscapeOriented
                        ? const SizedBox.shrink()
                        : SizedBox(
                            height: height * 0.1,
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: LogoSVG(mini: true),
                            ),
                          ),
                    SizedBox(
                      height: isLandscapeOriented ? 20 : height * 0.04,
                    ),
                    Expanded(
                      child: Flex(
                        crossAxisAlignment: isLandscapeOriented
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.center,
                        direction: isLandscapeOriented
                            ? Axis.horizontal
                            : Axis.vertical,
                        children: [
                          Expanded(
                            child: JokeCard(
                              joke: jokeProvider.joke,
                            ),
                          ),
                          SizedBox(
                            height: isLandscapeOriented ? 0 : height * 0.04,
                            width: isLandscapeOriented ? 40 : 0,
                          ),
                          RotatedBox(
                            quarterTurns: isLandscapeOriented ? 3 : 0,
                            child: FloatingActionButton.extended(
                              onPressed: jokeProvider.loadingJoke
                                  ? null
                                  : () {
                                      jokeProvider.getJoke(
                                          safe: !userSettingsProvider
                                              .settings['adult']);
                                    },
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: isLandscapeOriented
                                    ? RotatedBox(
                                        quarterTurns: 1,
                                        child: Column(
                                          children: 'ONE MORE'
                                              .split('')
                                              .map(
                                                (c) => Text(
                                                  c,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.varelaRound(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ))
                                    : Text(
                                        'ONE MORE',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.varelaRound(
                                          letterSpacing: 0.8,
                                          wordSpacing: 2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: height < 600 ? 14 : 18,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                              backgroundColor: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
