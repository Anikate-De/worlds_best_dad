import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/providers/joke_provider.dart';
import 'package:worlds_best_dad/screens/joke_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeId = 'welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<JokeProvider>(builder: (context, jokeProvider, child) {
      if (jokeProvider.errorOccurred) {
        Future.delayed(
            Duration.zero,
            () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(days: 1),
                    action: SnackBarAction(
                        label: 'RETRY',
                        onPressed: () => jokeProvider.getJoke()),
                    content: const Text('Unable to connect to internet..'),
                  ),
                ));
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (!jokeProvider.loadingJoke) {
          Future.delayed(
              const Duration(milliseconds: 400),
              () =>
                  Navigator.pushReplacementNamed(context, JokeScreen.routeId));
        }
      }
      return Scaffold(
        backgroundColor: Colors.amber.shade50,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: SizedBox(
                                width: 240,
                                child: SvgPicture.asset(
                                  'assets/vectors/mustache.svg',
                                  fit: BoxFit.fitWidth,
                                  width: 240,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                            const GreetingsTextColumn(),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 64,
                            ),
                            SvgPicture.asset(
                              'assets/vectors/mustache.svg',
                              fit: BoxFit.fitWidth,
                              width: 240,
                              color: Colors.brown,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const GreetingsTextColumn(),
                          ],
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: jokeProvider.errorOccurred ? 68 : 28),
                  child: Text(
                    'World\'s Best Dad v0.0.2',
                    style: GoogleFonts.varelaRound(
                      letterSpacing: 0.4,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class GreetingsTextColumn extends StatelessWidget {
  const GreetingsTextColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 240,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Hello there!',
              style: GoogleFonts.pacifico(
                  letterSpacing: 0.4,
                  wordSpacing: 2,
                  color: Colors.brown.shade800),
            ),
          ),
        ),
        Text(
          'My Sperms',
          style: GoogleFonts.pacifico(
            fontSize: 22,
            letterSpacing: 1,
            wordSpacing: 2,
            color: Colors.brown.shade600,
          ),
        ),
        const SizedBox(
          height: 44,
        ),
        Text(
          '[screaming begins]',
          style: GoogleFonts.bitter(
            letterSpacing: 1,
            wordSpacing: 4,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.brown.shade400,
          ),
        ),
      ],
    );
  }
}
