import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';
import 'package:cochabambacultural/ui/widgets/text_span_widget.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/validation.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cochabambacultural/user/ui/screens/user_home.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final GlobalKey<FormState> _keyForm = GlobalKey();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  Validation validation = Validation();

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      if (!state.existUser) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushNamed(context, 'login_screen');
            return false;
          },
          child: Scaffold(
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
                                  inputValidation: (value) => validation
                                      .validationField(value, "userName"),
                                  controllerText: _name,
                                ),
                                SizedBox(height: responsive.hp(2.2)),
                                InputTextWidget(
                                  labelInput: "* Correo",
                                  hintInput: "Ingrese su correo",
                                  keyboardType: TextInputType.emailAddress,
                                  inputPassword: false,
                                  inputValidation: (value) => validation
                                      .validationField(value, 'email'),
                                  controllerText: _email,
                                ),
                                SizedBox(height: responsive.hp(2.2)),
                                InputTextWidget(
                                  labelInput: "* Contraseña",
                                  hintInput: "Ingrese su constraseña",
                                  inputPassword: true,
                                  inputValidation: (value) => validation
                                      .validationField(value, "passwordR"),
                                  controllerText: _password,
                                ),
                                SizedBox(height: responsive.hp(2.2)),
                                InputTextWidget(
                                  labelInput: "* Confirmar contraseña",
                                  hintInput: "Ingrese nuevamente su contraseña",
                                  inputPassword: true,
                                  inputValidation: (value) =>
                                      validation.validationField(value,
                                          "confirmPassword", _password.text),
                                  controllerText: _confirmPassword,
                                ),
                                SizedBox(height: responsive.hp(7)),
                                GeneralButton(
                                  labelButton: 'Registrar',
                                  onPressed: () {
                                    if (_keyForm.currentState!.validate()) {
                                      userBloc.add(SignUp(
                                          name: _name.text,
                                          email: _email.text,
                                          password: _password.text,
                                          context: context));
                                    }
                                  },
                                ),
                                SizedBox(height: responsive.dp(3)),
                                TextSpanWidget(
                                    normalText: '¿Ya tienes una cuenta?\n',
                                    spanText: 'Iniciar sesión',
                                    eventOnTap: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, 'login_screen');
                                      },
                                    align: TextAlign.center),
                              ],
                            ),
                          ],
                        ),
                      )),
                )),
          ),
        );
      } else {
        return const UserHomeScreen();
      }
    });
  }
}
