/* (5) Tab user profile */
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileTab extends StatefulWidget {
  const UserProfileTab({Key? key}) : super(key: key);

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    final userBloc = BlocProvider.of<UserBloc>(context);

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
                  Text(
                    'Perfil de usuario',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorApp.primaryFont,
                      fontSize: responsive.dp(3.9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: responsive.hp(5)),
                  GeneralButton(
                      labelButton: 'Salir',
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
  }
}
