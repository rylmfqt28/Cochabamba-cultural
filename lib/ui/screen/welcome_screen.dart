import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    return Scaffold(
      body: Container(
        color: colorApp.primaryBackground,
        child: Stack(
          children: [
            Center(
                child: ListView(
              children: [
                const SizedBox(height: 40),
                SvgPicture.asset(
                  'assets/Logo-app.svg',
                  height: 300,
                  width: 300,
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
                  child: Text(
                    'BIENVENIDO',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: colorApp.primaryFont,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
                  child: Text(
                    'Encuentra diferentes eventos culturales que se llevan a cabo en Cochabamba y mantente informado sobre tus eventos favoritos.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: colorApp.secundaryFont,
                      fontSize: 18,
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
