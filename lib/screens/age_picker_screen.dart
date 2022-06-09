import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worlds_best_dad/providers/user_settings_provider.dart';
import 'package:worlds_best_dad/screens/joke_screen.dart';
import 'package:worlds_best_dad/widgets/logo_svg.dart';

class AgePickerScreen extends StatefulWidget {
  static String routeId = 'age_picker';

  const AgePickerScreen({Key? key}) : super(key: key);

  @override
  State<AgePickerScreen> createState() => _AgePickerScreenState();
}

class _AgePickerScreenState extends State<AgePickerScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> opacityh1;
  late Animation<double> opacityh2;
  late Animation<double> opacityh3;
  late Animation<double> opacityh4;
  late Animation<double> opacityOptions;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 7000),
      vsync: this,
    );

    opacityh1 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.085,
          curve: Curves.ease,
        ),
      ),
    );
    opacityh2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.14,
          0.21,
          curve: Curves.ease,
        ),
      ),
    );
    opacityh3 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.37,
          0.45,
          curve: Curves.ease,
        ),
      ),
    );
    opacityh4 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.59,
          0.68,
          curve: Curves.ease,
        ),
      ),
    );
    opacityOptions = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.87,
          1.00,
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscapeOriented =
        MediaQuery.of(context).orientation == Orientation.landscape;
    controller.forward();
    return Consumer<UserSettingsProvider>(
      builder: (context, userSettingsProvider, child) {
        return Scaffold(
          backgroundColor: Colors.amber.shade50,
          appBar: AppBar(
            centerTitle: true,
            title: isLandscapeOriented
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
            actionsIconTheme: const IconThemeData(
              color: Colors.brown,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isLandscapeOriented
                            ? const SizedBox.shrink()
                            : const LogoSVG(mini: true),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Opacity(
                                opacity: opacityh1.value,
                                child: AutoSizeText(
                                  'So...',
                                  minFontSize: 8,
                                  maxFontSize: 22,
                                  style: GoogleFonts.varelaRound(
                                      letterSpacing: 0.4,
                                      wordSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.brown.shade400),
                                ),
                              ),
                              Opacity(
                                opacity: opacityh2.value,
                                child: AutoSizeText(
                                  'How old are you, again?',
                                  minFontSize: 16,
                                  maxFontSize: 28,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.varelaRound(
                                      letterSpacing: 0.4,
                                      wordSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      color: Colors.brown.shade800),
                                ),
                              ),
                              Opacity(
                                opacity: opacityh3.value,
                                child: AutoSizeText(
                                  '"Dad! You forgot my birthday?!"',
                                  textAlign: TextAlign.center,
                                  minFontSize: 8,
                                  maxFontSize: 22,
                                  style: GoogleFonts.varelaRound(
                                      letterSpacing: 0.4,
                                      wordSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.brown.shade400),
                                ),
                              ),
                              Opacity(
                                opacity: opacityh4.value,
                                child: AutoSizeText(
                                  'Uhhh..',
                                  textAlign: TextAlign.center,
                                  minFontSize: 8,
                                  maxFontSize: 22,
                                  style: GoogleFonts.varelaRound(
                                      letterSpacing: 0.4,
                                      wordSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.brown.shade400),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Opacity(
                          opacity: opacityOptions.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  'Please select the appropriate option based on your age.',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.varelaRound(
                                      letterSpacing: -0.8,
                                      wordSpacing: 2,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.brown.shade400),
                                ),
                              ),
                              SizedBox(
                                height: isLandscapeOriented ? 4 : 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (kDebugMode) {
                                    print(
                                        'User wants to see Data Collection, Privacy Policy & T&C');
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: isLandscapeOriented ? 0 : 2),
                                      child: const Icon(
                                        Icons.info_rounded,
                                        color: Colors.brown,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              'Find out why we need this data, the ',
                                          style: GoogleFonts.varelaRound(
                                              letterSpacing: -0.8,
                                              wordSpacing: 2,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Colors.brown.shade400),
                                          children: const <TextSpan>[
                                            TextSpan(
                                                text: 'Privacy Statement',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0,
                                                    decoration: TextDecoration
                                                        .underline)),
                                            TextSpan(text: ' & '),
                                            TextSpan(
                                                text: 'T&C',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0,
                                                    decoration: TextDecoration
                                                        .underline)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: PillShapedElevatedButton(
                                      text: 'I\'m young',
                                      overlayColor: Colors.brown.shade100,
                                      callback: () {
                                        userSettingsProvider.addSetting(
                                            'adult', false);
                                        Navigator.pushReplacementNamed(
                                            context, JokeScreen.routeId);
                                      },
                                      isLandscape: isLandscapeOriented,
                                    ),
                                  ),
                                  SizedBox(
                                    width: isLandscapeOriented ? 30 : 15,
                                  ),
                                  Expanded(
                                    child: PillShapedElevatedButton(
                                      text: 'I\'m over 18',
                                      backgroundColor: Colors.brown,
                                      textColor: Colors.white,
                                      callback: () {
                                        userSettingsProvider.addSetting(
                                            'adult', true);
                                        Navigator.pushReplacementNamed(
                                            context, JokeScreen.routeId);
                                      },
                                      isLandscape: isLandscapeOriented,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        isLandscapeOriented
                            ? const SizedBox.shrink()
                            : const SizedBox(
                                height: 20,
                              )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PillShapedElevatedButton extends StatelessWidget {
  final Color backgroundColor;
  final Color? overlayColor;
  final String text;
  final Color? textColor;
  final VoidCallback callback;
  final bool isLandscape;

  const PillShapedElevatedButton({
    this.backgroundColor = Colors.white,
    this.overlayColor,
    required this.text,
    this.textColor,
    required this.callback,
    this.isLandscape = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(overlayColor ?? Colors.white24),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
        ),
      ),
      onPressed: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: AutoSizeText(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: GoogleFonts.varelaRound(
              letterSpacing: 0.4,
              wordSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: isLandscape ? 14 : 18,
              color: textColor ?? Colors.brown.shade400),
        ),
      ),
    );
  }
}
