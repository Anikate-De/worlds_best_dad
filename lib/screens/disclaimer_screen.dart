import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DisclaimerScreen extends StatelessWidget {
  static String routeId = 'disclaimer';

  const DisclaimerScreen({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'logo',
                  child: SvgPicture.asset(
                    'assets/vectors/mustache.svg',
                    fit: BoxFit.fitWidth,
                    width: 100,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.varelaRound(
                        fontSize: 16,
                        letterSpacing: -0.2,
                        wordSpacing: 2,
                        fontWeight: FontWeight.w500,
                        color: Colors.brown.shade400),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'What should you choose?\n\n',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          )),
                      TextSpan(
                          text:
                              '''Please select the option 'I'm young' if you are under the age of 18 OR you do not wish to see potentially 'unsafe jokes' (See Disclaimer(i) for more info). Else select the option 'I'm over 18' if you're above the age of 18 AND agree to seeing such potentially unsafe content.\n\n\n'''),
                      TextSpan(
                          text: 'Data Collection\n\n',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          )),
                      TextSpan(
                          text:
                              '''The data of the user's INEXACT age is collected locally, only to ensure content safety of individuals under the age of 18. The data is ONLY stored locally in the user's device and is NOT shared with any individual or organisation under any circumstances. All individuals using this app are treated as 'anonymous'.\n\n\n'''),
                      TextSpan(
                          text: 'Disclaimer\n\n',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          )),
                      TextSpan(
                          text:
                              '''(i) The user will be allowed access to ADDITIONAL content if they confirm that they are adults. Some of these jokes might be unsafe for children, or individuals under the age of 18. They have been categorised as 'NSFW (as in Not Safe For Work)', 'Religious', 'Political', 'Sexist', 'Explicit', 'Racist'. Please attempt to read these jokes at your own risk/discretion.\n\n(ii) The jokes provided in this app are not intended to offend the feelings/sentiments of any individual/caste/creed/community/race/religion/etc. Any reference to public figures, whether living or not, is not intended to insult or to demean them.\n\n(iii) From the Developer of this app - I will hereby not claim any legal responsibility or liability for this app, `World's Best Dad`, and the jokes served by it. I can't be held accountable if the jokes offered by this app are used with malicious intent OR if someone gets offended by them.
I have attached child filters and I will not be held responsible if users legally under the category of 'minors', spoof their age in order to access potentially 'unsafe' content in this app.\n\n\n'''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
