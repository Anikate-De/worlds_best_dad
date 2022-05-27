import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/joke.dart';
import '../providers/favourites_provider.dart';
import '../providers/joke_provider.dart';
import 'loading_overlay.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;
  final bool isLoadable;
  final bool isDeliverable;
  const JokeCard(
      {required this.joke,
      this.isLoadable = true,
      this.isDeliverable = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandscapeOriented =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Consumer2<JokeProvider, FavouritesProvider>(
      builder: (context, jokeProvider, favouritesProvider, child) {
        return Stack(
          children: [
            Card(
              elevation: 10,
              shadowColor: Colors.brown.shade800,
              color: Colors.brown.shade700,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isLandscapeOriented ? 20 : 8,
                    horizontal: isLandscapeOriented ? 40 : 16),
                child: LoadingOverlay(
                  color: Colors.brown.shade700,
                  isLoading: isLoadable ? jokeProvider.loadingJoke : false,
                  child: Flex(
                    direction:
                        isLandscapeOriented ? Axis.horizontal : Axis.vertical,
                    children: [
                      isLandscapeOriented
                          ? const SizedBox.shrink()
                          : const SizedBox(
                              height: 8,
                            ),
                      Expanded(
                        child: Align(
                          alignment: isLandscapeOriented
                              ? Alignment.center
                              : Alignment.bottomCenter,
                          child: AutoSizeText(
                            joke.setup,
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
                      isLandscapeOriented
                          ? const SizedBox(
                              width: 30,
                            )
                          : const SizedBox(
                              height: 30,
                            ),
                      Expanded(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 250),
                          opacity: isDeliverable
                              ? jokeProvider.isDeliveryVisible
                                  ? 1
                                  : 0
                              : 1,
                          child: AutoSizeText(
                            joke.delivery,
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
                        ),
                      ),
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
                  favouritesProvider.modifyFavourites(joke);
                },
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      favouritesProvider.isInFavourites(joke)
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      size: 24,
                      color: favouritesProvider.isInFavourites(joke)
                          ? Colors.red
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
