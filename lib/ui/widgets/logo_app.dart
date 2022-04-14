import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoApp extends StatelessWidget {
  final double heightLogo;
  final double widthLogo;

  const LogoApp({Key? key, required this.heightLogo, required this.widthLogo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/Logo-app.svg',
      height: heightLogo,
      width: widthLogo,
      //height: 300,
      //width: 300,
      alignment: Alignment.topCenter,
    );
  }
}
