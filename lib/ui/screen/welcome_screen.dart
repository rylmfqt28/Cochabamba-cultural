import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/logo_app.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cochabambacultural/user/ui/screens/user_home.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      if (!state.existUser) {
        return WillPopScope(
          onWillPop: () async {
            // if (Platform.isAndroid) {
            //   SystemNavigator.pop();
            // }
            return false;
          },
          child: Scaffold(
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
                      SizedBox(height: responsive.hp(3.5)),
                      LogoApp(
                          heightLogo:
                              responsive.isTablet ? 300 : responsive.hp(38),
                          widthLogo:
                              responsive.isTablet ? 300 : responsive.wp(55)),
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
                      SizedBox(
                        height: responsive.hp(2),
                      ),
                      const TextFormatWidget(
                          valueText:
                              'Encuentra diferentes eventos culturales que\nse llevan a cabo en Cochabamba y mantente\ninformado sobre tus eventos favoritos.',
                          align: TextAlign.center,
                          typeText: 'Normal'),
                      SizedBox(
                        height: responsive.hp(7),
                      ),
                      GeneralButton(
                        labelButton: 'Comenzar',
                        onPressed: () =>
                            Navigator.pushNamed(context, 'login_screen'),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
        );
      } else {
        return const UserHomeScreen();
      }
    });
  }
}
