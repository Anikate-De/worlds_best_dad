import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/providers/joke_provider.dart';
import 'package:worlds_best_dad/providers/user_settings_provider.dart';
import 'package:worlds_best_dad/screens/age_picker_screen.dart';
import 'package:worlds_best_dad/screens/joke_screen.dart';

import '../widgets/logo_svg.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeId = 'welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer2<JokeProvider, UserSettingsProvider>(
        builder: (context, jokeProvider, userSettingsProvider, child) {
      bool keepSafe = !userSettingsProvider.settings.containsKey('adult') ||
          (userSettingsProvider.settings.containsKey('adult') &&
              !userSettingsProvider.settings['adult']);
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
        int delay = 0;
        if (jokeProvider.jokeStartedLoading != null) {
          int difference = jokeProvider.jokeStartedLoading!
              .difference(DateTime.now())
              .inMilliseconds;
          if (difference > 600) {
            delay = 0;
          } else {
            delay = 600 - difference;
          }
        }

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (!userSettingsProvider.settings.containsKey('adult')) {
          if (!jokeProvider.loadingJoke) {
            Future.delayed(
                Duration(milliseconds: delay),
                () => Navigator.pushReplacementNamed(
                    context, AgePickerScreen.routeId));
          }
        } else {
          if (!jokeProvider.loadingJoke) {
            Future.delayed(
                Duration(milliseconds: delay),
                () => Navigator.pushReplacementNamed(
                    context, JokeScreen.routeId));
          }
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  child: const FittedBox(
                                      fit: BoxFit.scaleDown, child: LogoSVG())),
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
                            SizedBox(
                              height: height * 0.12,
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: LogoSVG(),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            GreetingsTextColumn(
                              safeGreetings: keepSafe,
                            ),
                          ],
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: jokeProvider.errorOccurred ? 68 : 28),
                  child: Text(
                    'World\'s Best Dad v0.0.4',
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
  final bool safeGreetings;

  const GreetingsTextColumn({this.safeGreetings = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Hello there!',
          style: GoogleFonts.pacifico(
              letterSpacing: 0.4,
              wordSpacing: 2,
              fontSize: isLandscape ? 28 : 40,
              color: Colors.brown.shade800),
        ),
        Text(
          safeGreetings ? 'Kids' : 'My Sperms',
          style: GoogleFonts.pacifico(
            fontSize: isLandscape ? 18 : 22,
            letterSpacing: 1,
            wordSpacing: 2,
            color: Colors.brown.shade600,
          ),
        ),
        const SizedBox(
          height: 44,
        ),
        Text(
          safeGreetings ? '[fatherly vibes]' : '[screaming begins]',
          style: GoogleFonts.bitter(
            letterSpacing: 1,
            wordSpacing: 4,
            fontWeight: FontWeight.w700,
            fontSize: isLandscape ? 14 : 18,
            color: Colors.brown.shade400,
          ),
        ),
      ],
    );
  }
}
