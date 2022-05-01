/* (5) Tab user profile */
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:cochabambacultural/user/ui/widgets/field_update_account.dart';

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
                        ClipOval(
                          child: Image.network(
                            state.user!.picture!,
                            width: responsive.dp(20),
                            height: responsive.dp(20),
                          ),
                        ),
                        SizedBox(height: responsive.hp(1)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(""),
                            InkWell(
                              onTap: () {
                                print("Open select new user picture profile");
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
                    //aqui
                    // Column(
                    //   children: [
                    //     const Align(
                    //       alignment: Alignment.topLeft,
                    //       child: TextFormatWidget(
                    //           valueText: 'Nombre:',
                    //           align: TextAlign.left,
                    //           typeText: 'Litle'),
                    //     ),
                    //     Container(
                    //       height: responsive.hp(6),
                    //       width: responsive.isTablet ? 430 : 360,
                    //       decoration: BoxDecoration(
                    //           border: Border(
                    //               bottom: BorderSide(
                    //         color: colorApp.successful,
                    //       ))),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           TextFormatWidget(
                    //               valueText: state.user!.name!,
                    //               align: TextAlign.left,
                    //               typeText: 'Normal'),
                    //           InkWell(
                    //             onTap: () {
                    //               print("Editar nombre");
                    //             },
                    //             child: Icon(
                    //               Icons.edit,
                    //               color: colorApp.successful,
                    //               size: 25,
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ) //fin
                    //   ],
                    // ),
                    FieldUpdateAccount(
                        nameField: 'Nombre:',
                        onPressed: () {
                          print('Abrir editar nombre');
                        },
                        valueField: state.user!.name!),
                    SizedBox(height: responsive.hp(3)),
                    FieldUpdateAccount(
                        nameField: 'Correo:',
                        onPressed: () {
                          print('Abrir editar correo');
                        },
                        valueField: state.user!.email!),
                    SizedBox(height: responsive.hp(4.5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(""),
                        InkWell(
                            onTap: () {
                              print("Abrir editar contraseña");
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
}
