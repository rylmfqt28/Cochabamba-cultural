import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/logo_app.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: colorApp.primaryBackground,
      body: Center(
          child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: responsive.dp(3)),
                LogoApp(
                    heightLogo: responsive.isTablet ? 300 : responsive.hp(38),
                    widthLogo: responsive.isTablet ? 300 : responsive.wp(55)),
                SizedBox(height: responsive.hp(8)),
                Text(
                  'BIENVENIDO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorApp.primaryFont,
                    fontSize: responsive.dp(3.9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: responsive.hp(2),
                ),
                Text(
                  'Encuentra diferentes eventos culturales que\nse llevan a cabo en Cochabamba y mantente\ninformado sobre tus eventos favoritos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorApp.secundaryFont,
                    fontSize: responsive.dp(1.9),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: responsive.hp(7),
                ),
                GeneralButton(
                  labelButton: 'Comenzar',
                  textSize: responsive.dp(2.7),
                  onPressed: () => Navigator.pushNamed(context, 'login_screen'),
                  heightButton: responsive.hp(6.3),
                  widthButton: responsive.hp(30),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
