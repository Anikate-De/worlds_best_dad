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
    isLandscapeOriented =
        MediaQuery.of(context).orientation == Orientation.landscape;
    pageController = PageController(
      viewportFraction: isLandscapeOriented ? 0.75 : 0.85,
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
                    height: 60,
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
                            : const LogoSVG(
                                mini: true,
                              ),
                        SizedBox(
                          height: isLandscapeOriented ? 10 : 24,
                        ),
                        Expanded(
                          child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (index) => globalIndex = index,
                            controller: pageController,
                            itemCount: favourites.length,
                            itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: isLandscapeOriented ? 12 : 16.0,
                                    horizontal: isLandscapeOriented ? 20 : 8),
                                child: JokeCard(
                                  joke: favourites.elementAt(index),
                                  isDeliverable: false,
                                  isLoadable: false,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: isLandscapeOriented ? 10 : 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              heroTag: 'btnLeft',
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
                            SizedBox(
                              width: isLandscapeOriented ? 40 : 20,
                            ),
                            FloatingActionButton(
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
                        const Icon(
                          Icons.heart_broken_rounded,
                          color: Colors.brown,
                          size: 120,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Looks like you don\'t like any of my jokes...',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.varelaRound(
                              letterSpacing: 0.4,
                              wordSpacing: 2,
                              fontWeight: FontWeight.w600,
                              fontSize: 32,
                              color: Colors.brown.shade800,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'So... anyway,\nYou\'re adopted',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.varelaRound(
                              letterSpacing: 0.4,
                              wordSpacing: 2,
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
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
