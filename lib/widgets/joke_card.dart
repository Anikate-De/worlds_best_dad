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
              elevation: 6,
              shadowColor: Colors.brown.shade800,
              color: Colors.brown.shade700,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isLandscapeOriented ? 20 : 8,
                    horizontal: isLandscapeOriented ? 16 : 16),
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
                              ? Alignment.centerRight
                              : Alignment.bottomCenter,
                          child: AutoSizeText(
                            joke.setup,
                            minFontSize: 6,
                            maxFontSize: 32,
                            wrapWords: false,
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
                              width: 20,
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
                            joke.punchline,
                            textAlign: TextAlign.center,
                            wrapWords: false,
                            minFontSize: 6,
                            maxFontSize: 26,
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
            !joke.safe
                ? Positioned(
                    top: 18,
                    right: 64,
                    child: Tooltip(
                      verticalOffset: 36,
                      margin: const EdgeInsets.symmetric(horizontal: 34),
                      triggerMode: TooltipTriggerMode.tap,
                      preferBelow: false,
                      showDuration: const Duration(milliseconds: 4000),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.brown.shade900.withOpacity(0.9),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      textStyle: GoogleFonts.varelaRound(
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: Colors.white,
                      ),
                      message: createTooltipMessage(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                width: 2, color: Colors.redAccent.shade700)),
                        child: const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }

  String createTooltipMessage() {
    String message = 'Flagged ';
    bool flag = false;
    if (joke.nsfw) {
      message = '${message}NSFW, ';
      flag = true;
    }
    if (joke.explicit) {
      message = '${message}Explicit, ';
      flag = true;
    }
    if (joke.political) {
      message = '${message}Political, ';
      flag = true;
    }
    if (joke.racist) {
      message = '${message}Racist, ';
      flag = true;
    }
    if (joke.sexist) {
      message = '${message}Sexist, ';
      flag = true;
    }
    if (joke.religious) {
      message = '${message}Religious, ';
      flag = true;
    }
    if (!joke.safe) {
      message = flag
          ? '${message.substring(0, message.length - 2)} & Not for Children'
          : '${message}Not for Children';
    }
    return message;
  }
}
