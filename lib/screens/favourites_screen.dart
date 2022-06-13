import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/models/joke.dart';

import '../providers/favourites_provider.dart';
import '../widgets/joke_card.dart';
import '../widgets/logo_svg.dart';

class FavouritesScreen extends StatefulWidget {
  static String routeId = 'favourites';

  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  int globalIndex = 0;
  late PageController pageController;
  bool isLandscapeOriented = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    bool wideDisplay = MediaQuery.of(context).size.aspectRatio >= 1.75;
    isLandscapeOriented =
        MediaQuery.of(context).orientation == Orientation.landscape;
    pageController = PageController(
      viewportFraction: isLandscapeOriented
          ? wideDisplay
              ? 0.5
              : 0.75
          : 0.85,
      initialPage: 0,
    );
    return Consumer<FavouritesProvider>(
        builder: (context, favouritesProvider, child) {
      List<Joke> favourites = favouritesProvider.favouriteJokes;
      return Scaffold(
        backgroundColor: Colors.amber.shade50,
        appBar: AppBar(
          centerTitle: true,
          title: isLandscapeOriented && favourites.isNotEmpty
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
          iconTheme: const IconThemeData(color: Colors.brown),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 0, right: 0, bottom: isLandscapeOriented ? 20 : 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: favourites.isNotEmpty
                    ? [
                        isLandscapeOriented
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: height * 0.1,
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: LogoSVG(mini: true),
                                ),
                              ),
                        isLandscapeOriented
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: height * 0.03,
                              ),
                        Expanded(
                          child: PageView.builder(
                            padEnds: !wideDisplay,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (index) => globalIndex = index,
                            controller: pageController,
                            itemCount: favourites.length,
                            itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: isLandscapeOriented ? 12 : 16.0,
                                    horizontal: isLandscapeOriented
                                        ? wideDisplay
                                            ? 14
                                            : 20
                                        : 8),
                                child: JokeCard(
                                  joke: favourites.elementAt(index),
                                  isDeliverable: false,
                                  isLoadable: false,
                                )),
                          ),
                        ),
                        isLandscapeOriented
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: height * 0.03,
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              heroTag: 'btnLeft',
                              mini: isLandscapeOriented,
                              onPressed: () {
                                pageController.animateToPage(globalIndex - 1,
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeOut);
                              },
                              backgroundColor: Colors.brown,
                              child: const Icon(
                                Icons.chevron_left_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            FloatingActionButton(
                              mini: isLandscapeOriented,
                              heroTag: 'btnRight',
                              onPressed: () {
                                pageController.animateToPage(globalIndex + 1,
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeOut);
                              },
                              backgroundColor: Colors.brown,
                              child: const Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        )
                      ]
                    : [
                        Flexible(
                          child: SizedBox(
                            child: Icon(
                              Icons.heart_broken_rounded,
                              color: Colors.brown,
                              size: MediaQuery.of(context).size.height < 500
                                  ? 80
                                  : 120,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: AutoSizeText(
                            'Looks like you don\'t like any of my jokes...',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.varelaRound(
                              letterSpacing: 0.4,
                              wordSpacing: 2,
                              fontWeight: FontWeight.w600,
                              fontSize: isLandscapeOriented ? 24 : 32,
                              color: Colors.brown.shade800,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: AutoSizeText(
                            'So... anyway,\nYou\'re adopted',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.varelaRound(
                              letterSpacing: 0.4,
                              wordSpacing: 2,
                              fontWeight: FontWeight.w600,
                              fontSize: isLandscapeOriented ? 20 : 26,
                              color: Colors.brown.shade400,
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
