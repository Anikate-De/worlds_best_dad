import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/models/joke.dart';

import '../providers/favourites_provider.dart';

class FavouritesScreen extends StatefulWidget {
  static String routeId = 'favourites';

  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  int globalIndex = 0;
  PageController pageController = PageController(
    viewportFraction: 0.85,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProvider>(
        builder: (context, favouritesProvider, child) {
      List<Joke> favourites = favouritesProvider.favouriteJokes;
      return Scaffold(
        backgroundColor: Colors.amber.shade50,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.brown),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: favourites.isNotEmpty
                    ? [
                        SvgPicture.asset(
                          'assets/vectors/mustache.svg',
                          fit: BoxFit.fitWidth,
                          width: 180,
                          color: Colors.brown,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Expanded(
                          child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (index) => globalIndex = index,
                            controller: pageController,
                            itemCount: favourites.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 8),
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 10,
                                    shadowColor: Colors.brown.shade800,
                                    color: Colors.brown.shade700,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18, horizontal: 16),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: AutoSizeText(
                                                favourites
                                                    .elementAt(index)
                                                    .setup,
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
                                            child: AutoSizeText(
                                              favourites
                                                  .elementAt(index)
                                                  .delivery,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        favouritesProvider.modifyFavourites(
                                            favourites.elementAt(index));
                                      },
                                      child: Material(
                                        elevation: 10,
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            favouritesProvider.isInFavourites(
                                                    favourites.elementAt(index))
                                                ? Icons.favorite_rounded
                                                : Icons
                                                    .favorite_outline_rounded,
                                            size: 24,
                                            color: favouritesProvider
                                                    .isInFavourites(favourites
                                                        .elementAt(index))
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
                          ),
                        ),
                        const SizedBox(
                          height: 24,
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
                            const SizedBox(
                              width: 20,
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
