import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
            fontSize: 22,
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
            fontSize: 16,
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
    bool segmentedUI =
        MediaQuery.of(context).orientation == Orientation.landscape ||
            MediaQuery.of(context).size.width >= 600 &&
                MediaQuery.of(context).size.width <= 900;
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
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: segmentedUI
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    direction: segmentedUI ? Axis.horizontal : Axis.vertical,
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
                            'v0.0.3',
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
                              main: 'May 27th, 2022', desc: 'Version Log'),
                          segmentedUI
                              ? const SizedBox.shrink()
                              : const SizedBox(
                                  height: 30,
                                ),
                        ],
                      ),
                      segmentedUI
                          ? const SizedBox(
                              width: 30,
                            )
                          : const SizedBox.shrink(),
                      segmentedUI
                          ? const Flexible(child: Attributions())
                          : const Attributions(),
                    ],
                  ),
                  const EndNote()
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
        const DualToneTextBlock(
            main: 'JokeAPI • Sven Fehler',
            desc: 'MIT License • Permitted to Commercial Use'),
        Text(
          'https://sv443.net/jokeapi/v2/',
          style: GoogleFonts.varelaRound(
            fontSize: 16,
            wordSpacing: 0.6,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.brown.shade300,
          ),
        ),
        const DualToneTextBlock(main: 'You', desc: 'For downloading my app'),
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
