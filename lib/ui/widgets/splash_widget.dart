import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: colorApp.primaryColor,
      body: Center(
        child: SvgPicture.asset(
          'assets/logo-splash.svg',
          height: responsive.isTablet ? 300 : responsive.hp(38),
          width: responsive.isTablet ? 300 : responsive.wp(55),
        ),
      ),
    );
  }
}
