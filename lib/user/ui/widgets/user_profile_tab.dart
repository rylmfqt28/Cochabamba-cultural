/* (5) Tab user profile */
import 'package:cochabambacultural/utils/snack_messages.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/validation.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';
import 'package:cochabambacultural/ui/widgets/dialog_widget.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:cochabambacultural/user/ui/widgets/field_update_account.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserProfileTab extends StatefulWidget {
  const UserProfileTab({Key? key}) : super(key: key);

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  final Validation validation = Validation();

  final SnackMessages messages = SnackMessages();
  final colorApp = AppColors();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      return Scaffold(
        backgroundColor: colorApp.primaryBackground,
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: responsive.isTablet ? 430 : 360,
            ),
            child: Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(height: responsive.hp(3)),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorApp.successful,
                          radius: responsive.dp(10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(state.user!.picture!),
                            radius: responsive.dp(9.4),
                          ),
                        ),
                        SizedBox(height: responsive.hp(1)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(""),
                            InkWell(
                              onTap: () async {
                                userBloc.add(UpdateImageUser(context: context));
                              },
                              child: Text(
                                'Cambiar foto',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: colorApp.primaryFont,
                                  fontSize: responsive.dp(2.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(""),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.hp(3)),
                    FieldUpdateAccount(
                        nameField: 'Nombre:',
                        onPressed: () {
                          _showDialog(context, state.user!.uid!);
                        },
                        valueField: state.user!.name!),
                    SizedBox(height: responsive.hp(3)),
                    FieldUpdateAccount(
                        nameField: 'Correo:',
                        onPressed: () {},
                        valueField: state.user!.email!),
                    SizedBox(height: responsive.hp(4.5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(""),
                        InkWell(
                            onTap: () {
                              _showDialogConfirmPassword(
                                  context, state.user!.email!);
                            },
                            child: const TextFormatWidget(
                                valueText: 'Cambiar contraseña',
                                align: TextAlign.left,
                                typeText: 'Normal')),
                        const Text(""),
                      ],
                    ),
                    SizedBox(height: responsive.hp(7)),
                    GeneralButton(
                        labelButton: 'Cerrar sesión',
                        onPressed: () async {
                          userBloc.add(SignOut(context: context));
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  //modal update user data
  _showDialog(BuildContext context, String uid) {
    final GlobalKey<FormState> _keyFormDialog = GlobalKey();

    final userBloc = BlocProvider.of<UserBloc>(context);

    String _newName = '';

    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: const Color(0xffffffff),
            insetPadding: const EdgeInsets.all(15),
            child: Form(
              key: _keyFormDialog,
              child: DialogWidget(
                titleText: 'Editar nombre',
                subTitle: 'Ingrese su nombre para guardar los cambios.',
                labelInputDialog: '* Nombre',
                hintInputDialog: 'Ingrese su nombre',
                keyboardType: TextInputType.text,
                isPassword: false,
                inputValidation: (value) =>
                    validation.validationField(value, 'userName'),
                onChangeInput: (value) {
                  _newName = value;
                },
                labelButtonModal: 'Guardar',
                onPressed: () async {
                  if (_keyFormDialog.currentState!.validate()) {
                    userBloc.add(UpdateNameUser(
                        uidUser: uid,
                        newName: _newName.trim(),
                        context: context));
                  }
                },
              ),
            )));
  }

  //Update password
  _showDialogConfirmPassword(BuildContext context, String email) {
    final GlobalKey<FormState> _keyFormDialog = GlobalKey();

    String _password = '';

    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: const Color(0xffffffff),
            insetPadding: const EdgeInsets.all(15),
            child: Form(
              key: _keyFormDialog,
              child: DialogWidget(
                titleText: 'Contraseña actual',
                subTitle: 'Ingrese su contraseña actual para continuar.',
                labelInputDialog: '* Contraseña',
                hintInputDialog: 'Ingrese su contraseña actual',
                keyboardType: TextInputType.text,
                isPassword: true,
                inputValidation: (value) {
                  if (value!.isEmpty) {
                    return 'El campo Contraseña es obligatorio';
                  }
                  return null;
                },
                onChangeInput: (value) {
                  _password = value;
                },
                labelButtonModal: 'Confirmar',
                onPressed: () async {
                  if (_keyFormDialog.currentState!.validate()) {
                    await _confirm(email, _password);
                  }
                },
              ),
            )));
  }

  //Confirm password dialog
  Future<void> _confirm(String email, String password) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      var credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user?.reauthenticateWithCredential(credential).then((value) {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        _showDialogUpdatePassword(context);
      });
    } on FirebaseAuthException catch (error) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
          "La contraseña no es correcta.", colorApp.errorColor, context, 190));
    }
  }

  //Update password dialog
  _showDialogUpdatePassword(BuildContext context) {
    final GlobalKey<FormState> _keyFormDialog = GlobalKey();

    final userBloc = BlocProvider.of<UserBloc>(context);

    String _newPassword = '';

    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: const Color(0xffffffff),
            insetPadding: const EdgeInsets.all(15),
            child: Form(
              key: _keyFormDialog,
              child: DialogWidget(
                titleText: 'Editar contraseña',
                subTitle: 'Ingrese la contraseña nueva.',
                labelInputDialog: '* Contraseña',
                hintInputDialog: 'Contraseña nueva',
                keyboardType: TextInputType.text,
                isPassword: true,
                inputValidation: (value) =>
                    validation.validationField(value, 'passwordR"'),
                onChangeInput: (value) {
                  _newPassword = value;
                },
                labelButtonModal: 'Guardar',
                onPressed: () async {
                  if (_keyFormDialog.currentState!.validate()) {
                    userBloc.add(UpdateUserPassword(
                        newPassword: _newPassword, context: context));
                  }
                },
              ),
            )));
  }
}
