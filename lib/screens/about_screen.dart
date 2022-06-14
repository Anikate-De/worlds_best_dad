import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/providers/favourites_provider.dart';
import 'package:worlds_best_dad/providers/user_settings_provider.dart';
import 'package:worlds_best_dad/screens/welcome_screen.dart';

class DualToneTextBlock extends StatelessWidget {
  final String main;
  final String desc;
  const DualToneTextBlock({required this.main, required this.desc, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 28,
        ),
        Text(
          main,
          style: GoogleFonts.varelaRound(
            fontSize: 18,
            wordSpacing: 0.6,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          desc,
          style: GoogleFonts.varelaRound(
            fontSize: 14,
            wordSpacing: 0.6,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade300,
          ),
        ),
      ],
    );
  }
}

class AboutScreen extends StatelessWidget {
  static String routeId = 'about';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber.shade50,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.brown),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/mustache.svg',
                            fit: BoxFit.fitWidth,
                            width: 100,
                            color: Colors.brown,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'World\'s Best Dad',
                            style: GoogleFonts.varelaRound(
                              fontSize: 30,
                              letterSpacing: 0.8,
                              wordSpacing: 1,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade900,
                            ),
                          ),
                          Text(
                            'v0.0.4',
                            style: GoogleFonts.varelaRound(
                              fontSize: 18,
                              letterSpacing: 0.4,
                              wordSpacing: 1,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade400,
                            ),
                          ),
                          const DualToneTextBlock(
                              main: 'May 23rd, 2022',
                              desc: 'When it all started'),
                          const DualToneTextBlock(
                              main: 'Anikate De • 17yrs',
                              desc:
                                  'Designer\nProgrammer\nInnovator\nThe mind behind this app'),
                          const DualToneTextBlock(
                              main: 'Flutter 3', desc: 'Built with'),
                          const DualToneTextBlock(
                              main: 'June 9th, 2022', desc: 'Version Log'),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                      const Attributions()
                    ],
                  ),
                  const EndNote(),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Consumer2<UserSettingsProvider, FavouritesProvider>(
                        builder: (context, userSettingsProvider,
                                favouritesProvider, child) =>
                            TextButton.icon(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                overlayColor: MaterialStateProperty.all(
                                    Colors.red.shade100),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 3),
                                    action: SnackBarAction(
                                        label: 'CONFIRM',
                                        onPressed: () {
                                          userSettingsProvider.resetProgress();
                                          favouritesProvider.getFavourites();
                                          userSettingsProvider
                                              .getUserSettings();
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              WelcomeScreen.routeId,
                                              (route) => false);
                                        },
                                        textColor: Colors.red),
                                    content: const Text(
                                      'This action will reset any progress you\'ve made so far, including your favourites collection',
                                      style: TextStyle(
                                        fontSize: 12,
                                        wordSpacing: 0.6,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete_forever_rounded),
                              label: Text(
                                'Reset App Configurations',
                                style: GoogleFonts.varelaRound(
                                  fontSize: 12,
                                  wordSpacing: 0.6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class Attributions extends StatelessWidget {
  const Attributions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Special Thanks to',
          style: GoogleFonts.varelaRound(
            fontSize: 28,
            letterSpacing: 0.8,
            wordSpacing: 1,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade800,
          ),
        ),
        const DualToneTextBlock(main: 'You', desc: 'For downloading my app'),
        const DualToneTextBlock(
            main: 'JokeAPI Dataset • Sven Fehler',
            desc: 'MIT License • Open Source'),
        Text(
          'https://sv443.net/jokeapi/v2/',
          style: GoogleFonts.varelaRound(
            fontSize: 14,
            wordSpacing: 0.6,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.brown.shade300,
          ),
        ),
        const DualToneTextBlock(
            main: 'Official Jokes API Dataset • 15Dkatz', desc: 'Open Source'),
        Text(
          'https://github.com/15Dkatz/official_joke_api',
          style: GoogleFonts.varelaRound(
            fontSize: 14,
            wordSpacing: 0.6,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.brown.shade300,
          ),
        ),
      ],
    );
  }
}

class EndNote extends StatelessWidget {
  const EndNote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'For everyone who misses their Dad',
            textAlign: TextAlign.center,
            style: GoogleFonts.pacifico(
              fontSize: 18,
              letterSpacing: 0.8,
              wordSpacing: 1,
              color: Colors.brown.shade400,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
