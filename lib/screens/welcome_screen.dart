import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeId = 'welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    Hero(
                      tag: 'mustache',
                      child: SvgPicture.asset(
                        'assets/vectors/mustache.svg',
                        fit: BoxFit.fitWidth,
                        width: 240,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: 240,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Hello there!',
                          style: GoogleFonts.pacifico(
                            letterSpacing: 0.4,
                            wordSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'My Sperms',
                      style: GoogleFonts.pacifico(
                        fontSize: 22,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.brown.shade800,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Text(
                  'World\'s Best Dad v0.0.1',
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
  }
}
