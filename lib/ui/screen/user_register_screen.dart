import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';

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
                      SizedBox(height: responsive.dp(3)),
                      Text(
                        'Registrarse',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: responsive.dp(3),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: responsive.dp(2)),
                      Text(
                        "Los campos con un (*) son obligatorios",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: responsive.dp(1.8),
                        ),
                      ),
                      SizedBox(height: responsive.dp(3)),
                      InputTextWidget(
                          labelInput: "* Nombre",
                          hintInput: "Ingrese su nombre",
                          colorLabel: colorApp.primaryFont,
                          colorHint: colorApp.placeHolder,
                          inputPassword: false),
                      SizedBox(height: responsive.dp(3)),
                      InputTextWidget(
                          labelInput: "* Correo",
                          hintInput: "Ingrese su correo",
                          colorLabel: colorApp.primaryFont,
                          colorHint: colorApp.placeHolder,
                          keyboardType: TextInputType.emailAddress,
                          inputPassword: false),
                      SizedBox(height: responsive.dp(3)),
                      InputTextWidget(
                          labelInput: "* Contraseña",
                          hintInput: "Ingrese su constraseña",
                          colorLabel: colorApp.primaryFont,
                          colorHint: colorApp.placeHolder,
                          inputPassword: true),
                      SizedBox(height: responsive.dp(3)),
                      InputTextWidget(
                          labelInput: "* Confirmar contraseña",
                          hintInput: "Ingrese nuevamente su contraseña",
                          colorLabel: colorApp.primaryFont,
                          colorHint: colorApp.placeHolder,
                          inputPassword: true),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
