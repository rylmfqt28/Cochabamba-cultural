import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: Container(
        color: colorApp.primaryBackground,
        child: Stack(
          children: [
            Center(
                child: ListView(
              children: [
                SizedBox(height: responsive.dp(3)),
                SvgPicture.asset(
                  'assets/Logo-app.svg',
                  height: responsive.hp(38),
                  width: responsive.wp(55),
                  //height: 300,
                  //width: 300,
                  alignment: Alignment.topCenter,
                ),
                SizedBox(height: responsive.hp(8)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
                  child: Text(
                    'BIENVENIDO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorApp.primaryFont,
                      fontSize: responsive.dp(3.9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: responsive.hp(2),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
                  child: Text(
                    'Encuentra diferentes eventos culturales que\nse llevan a cabo en Cochabamba y mantente\ninformado sobre tus eventos favoritos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorApp.secundaryFont,
                      fontSize: responsive.dp(1.9),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
                  child: GeneralButton(
                    labelButton: 'Comenzar',
                    onPressed: () =>
                        Navigator.pushNamed(context, 'login_screen'),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
//79729024
