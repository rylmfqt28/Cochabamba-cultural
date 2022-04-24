import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';
import 'package:cochabambacultural/ui/widgets/text_span_widget.dart';

import 'package:cochabambacultural/user/model/user_model.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/validation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _keyForm = GlobalKey();
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  Validation validation = Validation();

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
                          SizedBox(height: responsive.hp(3)),
                          InputTextWidget(
                            labelInput: "* Nombre",
                            hintInput: "Ingrese su nombre",
                            inputPassword: false,
                            inputValidation: (value) =>
                                validation.validationField(value, "userName"),
                            onChangeInput: (value) {
                              _name = value;
                            },
                          ),
                          SizedBox(height: responsive.hp(2.2)),
                          InputTextWidget(
                            labelInput: "* Correo",
                            hintInput: "Ingrese su correo",
                            keyboardType: TextInputType.emailAddress,
                            inputPassword: false,
                            inputValidation: (value) =>
                                validation.validationField(value, 'email'),
                            onChangeInput: (value) {
                              _email = value;
                            },
                          ),
                          SizedBox(height: responsive.hp(2.2)),
                          InputTextWidget(
                            labelInput: "* Contraseña",
                            hintInput: "Ingrese su constraseña",
                            inputPassword: true,
                            inputValidation: (value) =>
                                validation.validationField(value, "passwordR"),
                            onChangeInput: (value) {
                              _password = value;
                            },
                          ),
                          SizedBox(height: responsive.hp(2.2)),
                          InputTextWidget(
                            labelInput: "* Confirmar contraseña",
                            hintInput: "Ingrese nuevamente su contraseña",
                            inputPassword: true,
                            inputValidation: (value) =>
                                validation.validationField(
                                    value, "confirmPassword", _password),
                            onChangeInput: (value) {
                              _confirmPassword = value;
                            },
                          ),
                          SizedBox(height: responsive.hp(7)),
                          GeneralButton(
                            labelButton: 'Registrar',
                            onPressed: () {
                              if (_keyForm.currentState!.validate()) {
                                signUp();
                              }
                            },
                          ),
                          SizedBox(height: responsive.dp(3)),
                          TextSpanWidget(
                              normalText: '¿Ya tienes una cuenta?\n',
                              spanText: 'Iniciar sesión',
                              eventOnTap: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, 'login_screen');
                                },
                              align: TextAlign.center),
                        ],
                      ),
                    ],
                  ),
                )),
          )),
    );
  }

  void signUp() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) => {registerUserToFirestore()})
          .catchError((e) {
        print(e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
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

  registerUserToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    userModel.uid = user!.uid;
    userModel.name = _name;
    userModel.email = user.email;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Navigator.pushNamed(context, 'user_home_screen');
  }
}
