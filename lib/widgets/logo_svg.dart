import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoSVG extends StatelessWidget {
  final bool mini;
  const LogoSVG({
    this.mini = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mini ? 130 : 200,
      child: SvgPicture.asset(
        'assets/vectors/mustache.svg',
        fit: BoxFit.fitWidth,
        width: mini ? 180 : 240,
        color: Colors.brown,
      ),
    );
  }
}
