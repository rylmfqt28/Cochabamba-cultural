import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

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
                child: Form(
                  key: _keyForm,
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          SizedBox(height: responsive.hp(3)),
                          const TextFormatWidget(
                              valueText: 'Registrarse',
                              align: TextAlign.center,
                              typeText: 'Title'),
                          SizedBox(height: responsive.hp(2)),
                          const TextFormatWidget(
                              valueText:
                                  'Los campos con un (*) son obligatorios',
                              align: TextAlign.left,
                              typeText: "Normal"),
                          SizedBox(height: responsive.hp(4)),
                          InputTextWidget(
                            labelInput: "* Nombre",
                            hintInput: "Ingrese su nombre",
                            inputPassword: false,
                            inputValidation: (value) {
                              if (value!.isEmpty) {
                                return 'El campo Nombre es obligatorio';
                              }
                              if (value.length < 3 || value.length > 60) {
                                return 'El campo Nombre requiere el ingreso de entre 3 a 60 caracteres';
                              }
                              return null;
                            },
                            onChangeInput: (value) {
                              _name = value;
                            },
                          ),
                          SizedBox(height: responsive.hp(3)),
                          InputTextWidget(
                            labelInput: "* Correo",
                            hintInput: "Ingrese su correo",
                            keyboardType: TextInputType.emailAddress,
                            inputPassword: false,
                            inputValidation: (value) {
                              if (value!.isEmpty) {
                                return 'El campo Correo es obligatorio';
                              }
                              if (!value.contains("@")) {
                                return 'Formato de correo no valido';
                              }
                              return null;
                            },
                            onChangeInput: (value) {
                              _email = value;
                            },
                          ),
                          SizedBox(height: responsive.hp(3)),
                          InputTextWidget(
                            labelInput: "* Contraseña",
                            hintInput: "Ingrese su constraseña",
                            inputPassword: true,
                            inputValidation: (value) {
                              if (value!.isEmpty) {
                                return 'El campo Contraseña es obligatorio';
                              }
                              if (value.length < 3 || value.length > 60) {
                                return 'El campo Contraseña requiere el ingreso de entre 8 a 15 caracteres';
                              }
                              return null;
                            },
                            onChangeInput: (value) {
                              _password = value;
                            },
                          ),
                          SizedBox(height: responsive.hp(3)),
                          InputTextWidget(
                            labelInput: "* Confirmar contraseña",
                            hintInput: "Ingrese nuevamente su contraseña",
                            inputPassword: true,
                            inputValidation: (value) {
                              if (value!.isEmpty) {
                                return 'El campo Confirmar contraseña es obligatorio';
                              }
                              if (value != _password) {
                                return 'La contraseña no coincide';
                              }
                              return null;
                            },
                            onChangeInput: (value) {
                              _confirmPassword = value;
                            },
                          ),
                          SizedBox(height: responsive.hp(7)),
                          GeneralButton(
                            labelButton: 'Registrar',
                            onPressed: () {
                              if (_keyForm.currentState!.validate()) {
                                print('Validado');
                              } else {
                                print('No validado');
                              }
                            },
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
                                  const TextSpan(text: ""),
                                  TextSpan(
                                      text: "Iniciar sesión",
                                      style: TextStyle(
                                          color: colorApp.primaryFont,
                                          fontSize: responsive.dp(1.9),
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, 'login_screen');
                                        }),
                                  const TextSpan(text: " "),
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          )),
    );
  }
}
