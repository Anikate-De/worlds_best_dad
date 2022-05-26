import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/providers/favourites_provider.dart';
import 'package:worlds_best_dad/providers/joke_provider.dart';
import 'package:worlds_best_dad/screens/about_screen.dart';
import 'package:worlds_best_dad/screens/favourites_screen.dart';
import 'package:worlds_best_dad/screens/welcome_screen.dart';
import 'package:worlds_best_dad/widgets/loading_overlay.dart';

class JokeScreen extends StatelessWidget {
  static String routeId = 'joke';

  const JokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<JokeProvider, FavouritesProvider>(
      builder: (context, jokeProvider, favouritesProvider, child) {
        if (jokeProvider.errorOccurred) {
          Future.delayed(
              Duration.zero,
              () => Navigator.pushReplacementNamed(
                  context, WelcomeScreen.routeId));
        }
        return Scaffold(
          backgroundColor: Colors.amber.shade50,
          appBar: AppBar(
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
                          animationType: BadgeAnimationType.scale,
                          position: BadgePosition.topEnd(top: 0),
                          badgeColor: Colors.white,
                          badgeContent: Text(
                            favouritesProvider.favouriteJokes.length.toString(),
                            style: TextStyle(color: Colors.brown.shade800),
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
                    SvgPicture.asset(
                      'assets/vectors/mustache.svg',
                      fit: BoxFit.fitWidth,
                      width: 180,
                      color: Colors.brown,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Card(
                            elevation: 10,
                            shadowColor: Colors.brown.shade800,
                            color: Colors.brown.shade700,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: LoadingOverlay(
                                color: Colors.brown.shade700,
                                isLoading: jokeProvider.loadingJoke,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: AutoSizeText(
                                          jokeProvider.joke.setup,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.varelaRound(
                                            letterSpacing: 0.4,
                                            wordSpacing: 2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Expanded(
                                        child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      opacity: jokeProvider.isDeliveryVisible
                                          ? 1
                                          : 0,
                                      child: AutoSizeText(
                                        jokeProvider.joke.delivery,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.varelaRound(
                                          letterSpacing: 0.6,
                                          wordSpacing: 1,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 26,
                                          color: Colors.orange.shade100,
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                favouritesProvider
                                    .modifyFavourites(jokeProvider.joke);
                              },
                              child: Material(
                                elevation: 10,
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    favouritesProvider
                                            .isInFavourites(jokeProvider.joke)
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_outline_rounded,
                                    size: 24,
                                    color: favouritesProvider
                                            .isInFavourites(jokeProvider.joke)
                                        ? Colors.red
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    FloatingActionButton.extended(
                      onPressed: jokeProvider.loadingJoke
                          ? null
                          : () {
                              jokeProvider.getJoke();
                            },
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'ONE MORE!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.varelaRound(
                            letterSpacing: 0.4,
                            wordSpacing: 2,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.brown,
                    ),
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
