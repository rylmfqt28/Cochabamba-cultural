import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';
import 'package:cochabambacultural/ui/widgets/text_span_widget.dart';
import 'package:cochabambacultural/ui/widgets/logo_app.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _keyForm = GlobalKey();

  final _auth = FirebaseAuth.instance;

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

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
                      SizedBox(
                        height: responsive.hp(3),
                      ),
                      const TextFormatWidget(
                          valueText: 'Inicio de Sesión',
                          align: TextAlign.center,
                          typeText: 'Title'),
                      SizedBox(height: responsive.hp(2)),
                      LogoApp(
                          heightLogo:
                              responsive.isTablet ? 300 : responsive.hp(30),
                          widthLogo:
                              responsive.isTablet ? 300 : responsive.wp(47)),
                      SizedBox(height: responsive.hp(3)),
                      InputTextWidget(
                        labelInput: "Correo",
                        hintInput: "Ingrese su correo",
                        keyboardType: TextInputType.emailAddress,
                        inputPassword: false,
                        inputValidation: (value) {
                          if (value!.isEmpty) {
                            return 'El campo Correo es obligatorio';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Formato de correo no valido';
                          }
                          return null;
                        },
                        onChangeInput: (value) {
                          _email = value;
                        },
                      ),
                      SizedBox(height: responsive.hp(2.2)),
                      InputTextWidget(
                        labelInput: "Contraseña",
                        hintInput: "Ingrese su constraseña",
                        inputPassword: true,
                        inputValidation: (value) {
                          if (value!.isEmpty) {
                            return 'Ingrese su contraseña';
                          }
                          return null;
                        },
                        onChangeInput: (value) {
                          _password = value;
                        },
                      ),
                      SizedBox(height: responsive.hp(2.2)),
                      TextSpanWidget(
                          normalText: '',
                          spanText: '¿Olvidaste tu contraseña?',
                          eventOnTap: TapGestureRecognizer()
                            ..onTap = () {
                              print('Abrir modal Recuperar contraseña');
                            },
                          align: TextAlign.right),
                      SizedBox(height: responsive.hp(5)),
                      GeneralButton(
                        labelButton: 'Iniciar sesión',
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            signIn(_email, _password);
                          }
                        },
                      ),
                      SizedBox(height: responsive.hp(3)),
                      TextSpanWidget(
                          normalText: '¿Aún no tienes una cuenta?\n',
                          spanText: 'Registrate aquí',
                          eventOnTap: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, 'user_register_screen');
                            },
                          align: TextAlign.center),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {Navigator.pushNamed(context, 'user_home_screen')});
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          print("Formato de correo no valido");
          break;
        case "wrong-password":
          // credenciales no validas o usuario no existe
          print("Contraseña incorrecta");
          break;
        case "user-not-found":
          // credenciales no validas o usuario no existe
          print("El usuario no existe");
          break;
        case "user-disabled":
          //Usuario deshabilitado
          print("Usuario dado de baja");
          break;
        case "too-many-requests":
          print("Demasiadas solicitudes");
          break;
        case "operation-not-allowed":
          print("Operacion no permitida");
          break;
        default:
          print("Error no identificado");
      }
    }
  }
}
