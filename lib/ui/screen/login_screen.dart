import 'package:cochabambacultural/ui/animation/bounce_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';
import 'package:cochabambacultural/ui/widgets/text_span_widget.dart';
import 'package:cochabambacultural/ui/widgets/logo_app.dart';
import 'package:cochabambacultural/ui/widgets/dialog_widget.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/validation.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cochabambacultural/user/ui/screens/user_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AppColors colorApp = AppColors();

  final GlobalKey<FormState> _keyForm = GlobalKey();

  final Validation validation = Validation();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      if (!state.existUser) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushNamed(context, 'welcome_screen');
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
                            SizedBox(
                              height: responsive.hp(3),
                            ),
                            BounceAnimation(
                              orientation: Axis.vertical,
                              curveEffect: Curves.bounceOut,
                              child: LogoApp(
                                  heightLogo: responsive.isTablet
                                      ? 300
                                      : responsive.hp(24),
                                  widthLogo: responsive.isTablet
                                      ? 300
                                      : responsive.wp(41)),
                            ),
                            SizedBox(height: responsive.hp(3)),
                            const BounceAnimation(
                              child: TextFormatWidget(
                                  valueText: 'Inicio de Sesión',
                                  align: TextAlign.left,
                                  typeText: 'Title'),
                            ),
                            SizedBox(height: responsive.hp(2)),
                            BounceAnimation(
                              duration: const Duration(milliseconds: 980),
                              child: InputTextWidget(
                                labelInput: "Correo",
                                hintInput: "Ingrese su correo",
                                keyboardType: TextInputType.emailAddress,
                                inputPassword: false,
                                inputValidation: (value) =>
                                    validation.validationField(value, 'email'),
                                controllerText: _email,
                              ),
                            ),
                            SizedBox(height: responsive.hp(2)),
                            BounceAnimation(
                              duration: const Duration(milliseconds: 980),
                              child: InputTextWidget(
                                labelInput: "Contraseña",
                                hintInput: "Ingrese su constraseña",
                                inputPassword: true,
                                inputValidation: (value) {
                                  if (value!.isEmpty) {
                                    return 'Ingrese su contraseña';
                                  }
                                  return null;
                                },
                                controllerText: _password,
                              ),
                            ),
                            SizedBox(height: responsive.hp(2.2)),
                            TextSpanWidget(
                                normalText: '',
                                spanText: '¿Olvidaste tu contraseña?',
                                eventOnTap: TapGestureRecognizer()
                                  ..onTap = () {
                                    _showDialog(context);
                                  },
                                align: TextAlign.right),
                            SizedBox(height: responsive.hp(5)),
                            BounceAnimation(
                              orientation: Axis.vertical,
                              child: GeneralButton(
                                labelButton: 'Iniciar sesión',
                                onPressed: () async {
                                  if (_keyForm.currentState!.validate()) {
                                    userBloc.add(SignIn(
                                        email: _email.text,
                                        password: _password.text,
                                        context: context));
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: responsive.hp(3)),
                            BounceAnimation(
                              orientation: Axis.vertical,
                              duration: const Duration(milliseconds: 1000),
                              child: TextSpanWidget(
                                  normalText: '¿Aún no tienes una cuenta?\n',
                                  spanText: 'Registrate aquí',
                                  eventOnTap: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, 'user_register_screen');
                                    },
                                  align: TextAlign.center),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        return const UserHomeScreen();
      }
    });
  }

  _showDialog(BuildContext context) {
    final GlobalKey<FormState> _keyFormDialog = GlobalKey();

    final userBloc = BlocProvider.of<UserBloc>(context);

    final _sendEmail = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: colorApp.primaryBackground,
            insetPadding: const EdgeInsets.all(15),
            child: Form(
              key: _keyFormDialog,
              child: DialogWidget(
                titleText: 'Restablecer contraseña',
                subTitle:
                    'Ingrese su correo y se le enviara un mensaje para reestablecer su contraseña.',
                labelInputDialog: 'Correo',
                hintInputDialog: 'Ingrese su correo',
                keyboardType: TextInputType.emailAddress,
                isPassword: false,
                inputValidation: (value) =>
                    validation.validationField(value, 'email'),
                controller: _sendEmail,
                labelButtonModal: 'Enviar',
                onPressed: () async {
                  if (_keyFormDialog.currentState!.validate()) {
                    userBloc.add(ResetPassword(
                        email: _sendEmail.text, context: context));
                  }
                },
              ),
            )));
  }
}
