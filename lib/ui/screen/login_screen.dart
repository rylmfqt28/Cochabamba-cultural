import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: responsive.hp(20),
                ),
                Text(
                  'BIENVENIDO',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: colorApp.primaryFont,
                    fontSize: responsive.dp(3.9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: responsive.hp(5),
                ),
                GeneralButton(
                  labelButton: 'Registrarse',
                  onPressed: () =>
                      Navigator.pushNamed(context, 'user_register_screen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
