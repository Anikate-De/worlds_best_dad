import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/providers/joke_provider.dart';
import 'package:worlds_best_dad/widgets/loading_overlay.dart';

class JokeScreen extends StatelessWidget {
  static String routeId = 'joke';

  const JokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<JokeProvider>(
      builder: (context, jokeProvider, child) => LoadingOverlay(
        isLoading: jokeProvider.loadingJoke,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: FloatingActionButton.extended(
              onPressed: () {
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
          ),
          backgroundColor: Colors.amber.shade50,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'mustache',
                      child: SvgPicture.asset(
                        'assets/vectors/mustache.svg',
                        fit: BoxFit.fitWidth,
                        width: 180,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 80,
                              ),
                              Text(
                                jokeProvider.joke!.text,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.varelaRound(
                                  letterSpacing: 0.4,
                                  wordSpacing: 2,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
