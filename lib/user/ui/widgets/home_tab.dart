/* (1) Tab home user */
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      //final nameUser = state.user!.name!.split(' ');

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
                      SizedBox(height: responsive.hp(2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormatWidget(
                              valueText:
                                  "Hola, ${state.user!.name!.split(' ')[0]}",
                              align: TextAlign.left,
                              typeText: 'Title'),
                          ClipOval(
                            child: Image.network(
                              //'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg',
                              state.user!.picture!,
                              width: responsive.dp(7.5),
                              height: responsive.dp(7.5),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: responsive.hp(3)),
                      const TextFormatWidget(
                          valueText: "Categorias de eventos",
                          align: TextAlign.left,
                          typeText: 'Subtitle'),
                      SizedBox(height: responsive.hp(5)),
                      const TextFormatWidget(
                          valueText: "Proximos eventos",
                          align: TextAlign.left,
                          typeText: 'Subtitle'),
                      SizedBox(height: responsive.hp(8)),
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
    });
  }
}
