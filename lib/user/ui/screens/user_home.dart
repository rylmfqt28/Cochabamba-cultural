import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/user/model/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userSignin = UserModel();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      if (state.existUser) {
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
                        SizedBox(height: responsive.hp(8)),
                        Text(
                          'BIENVENIDO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorApp.primaryFont,
                            fontSize: responsive.dp(3.9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: responsive.hp(5)),
                        TextFormatWidget(
                            valueText: "Nombre: ${state.user!.name}",
                            align: TextAlign.left,
                            typeText: "Normal"),
                        SizedBox(height: responsive.hp(3)),
                        TextFormatWidget(
                            valueText: "Correo: ${state.user!.email}",
                            align: TextAlign.left,
                            typeText: "Normal"),
                        SizedBox(height: responsive.hp(5)),
                        GeneralButton(
                          labelButton: 'Salir',
                          onPressed: () async {
                            userBloc.add(SignOut(context: context));
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: colorApp.primaryBackground,
        );
      }
    });
  }
}
