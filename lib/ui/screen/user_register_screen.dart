import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    return Scaffold(
      backgroundColor: colorApp.primaryBackground,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: responsive.isTablet ? 430 : 360,
              ),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      SizedBox(height: responsive.hp(3)),
                      Text(
                        'Registrarse',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorApp.secundaryFont,
                          fontSize: responsive.dp(3),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: responsive.hp(2)),
                      Text(
                        "Los campos con un (*) son obligatorios",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: colorApp.secundaryFont,
                          fontSize: responsive.dp(1.9),
                        ),
                      ),
                      SizedBox(height: responsive.hp(4)),
                      InputTextWidget(
                          labelInput: "* Nombre",
                          hintInput: "Ingrese su nombre",
                          colorLabel: colorApp.primaryFont,
                          colorHint: colorApp.placeHolder,
                          inputPassword: false,
                          fontSizeInput: responsive.dp(1.9)),
                      SizedBox(height: responsive.hp(3)),
                      InputTextWidget(
                          labelInput: "* Correo",
                          hintInput: "Ingrese su correo",
                          colorLabel: colorApp.primaryFont,
                          colorHint: colorApp.placeHolder,
                          keyboardType: TextInputType.emailAddress,
                          inputPassword: false,
                          fontSizeInput: responsive.dp(1.9)),
                      SizedBox(height: responsive.hp(3)),
                      InputTextWidget(
                          labelInput: "* Contraseña",
                          hintInput: "Ingrese su constraseña",
                          colorLabel: colorApp.primaryFont,
                          colorHint: colorApp.placeHolder,
                          inputPassword: true,
                          fontSizeInput: responsive.dp(1.9)),
                      SizedBox(height: responsive.hp(3)),
                      InputTextWidget(
                          labelInput: "* Confirmar contraseña",
                          hintInput: "Ingrese nuevamente su contraseña",
                          colorLabel: colorApp.primaryFont,
                          colorHint: colorApp.placeHolder,
                          inputPassword: true,
                          fontSizeInput: responsive.dp(1.9)),
                      SizedBox(height: responsive.hp(7)),
                      GeneralButton(
                        labelButton: 'Registrar',
                        textSize: responsive.dp(2.7),
                        onPressed: () => print('Registrar'),
                        //Navigator.pushNamed(context, 'login_screen'),
                        heightButton: responsive.hp(6.3),
                        widthButton: responsive.hp(30),
                      ),
                      SizedBox(height: responsive.dp(3)),
                      Text.rich(
                        TextSpan(
                            text: "¿Ya tienes una cuenta?\n",
                            style: TextStyle(
                              color: colorApp.secundaryFont,
                              fontSize: responsive.dp(1.9),
                            ),
                            children: [
                              TextSpan(
                                  text: "Inicia sesión",
                                  style: TextStyle(
                                      color: colorApp.primaryFont,
                                      fontSize: responsive.dp(1.9),
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, 'login_screen');
                                    })
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
