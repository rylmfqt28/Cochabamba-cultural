/* (1) Tab home user */
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/event_category_button.dart';
import 'package:cochabambacultural/cultural_event/ui/widgets/card_event_widget.dart';

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
                      SizedBox(height: responsive.hp(2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormatWidget(
                              valueText:
                                  "Hola, ${state.user!.name!.split(' ')[0]}",
                              align: TextAlign.left,
                              typeText: 'Title'),
                          CircleAvatar(
                            backgroundColor: colorApp.primaryColor,
                            radius: responsive.dp(3.2),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(state.user!.picture!),
                              radius: responsive.dp(2.9),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsive.hp(3)),
                      const TextFormatWidget(
                          valueText: "Categorias de eventos",
                          align: TextAlign.left,
                          typeText: 'Subtitle'),
                      SizedBox(height: responsive.hp(3)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EventCategoryButton(
                              iconEvent: Icons.restaurant,
                              category: " Gastronomicos",
                              event: () {
                                print('ver gastronomicos');
                              }),
                          EventCategoryButton(
                              iconEvent: Icons.music_note,
                              category: " Musicales",
                              event: () {
                                print("ver musicales");
                              }),
                        ],
                      ),
                      SizedBox(height: responsive.hp(2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EventCategoryButton(
                              iconEvent: Icons.church,
                              category: " Religiosos",
                              event: () {
                                print('ver religiosos');
                              }),
                          EventCategoryButton(
                              iconEvent: Icons.brush,
                              category: " Artesanales",
                              event: () {
                                print("ver artesanales");
                              }),
                        ],
                      ),
                      SizedBox(height: responsive.hp(5)),
                      const TextFormatWidget(
                          valueText: "Proximos eventos",
                          align: TextAlign.left,
                          typeText: 'Subtitle'),
                      SizedBox(height: responsive.hp(3)),
                      SizedBox(
                        height: responsive.hp(35.1),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(width: responsive.wp(2.5)),
                            const CardEventWidget(
                                url:
                                    'https://img3.travelagenciesfinder.com/470/556/2355618434705569.jpg',
                                eventTitle:
                                    'XVI Feria del pescado y aniversario de Villa Tunari.',
                                eventDate: '30/04/2022'),
                            SizedBox(width: responsive.wp(4)),
                            const CardEventWidget(
                                url:
                                    'https://img3.travelagenciesfinder.com/470/556/2355618434705569.jpg',
                                eventTitle:
                                    'XXVIII Feria Apicola y sus derivados.',
                                eventDate: '31/04/2022'),
                            SizedBox(width: responsive.wp(4)),
                            const CardEventWidget(
                                url:
                                    'https://img3.travelagenciesfinder.com/470/556/2355618434705569.jpg',
                                eventTitle:
                                    'Feria artesanal por el dia del trabajo.',
                                eventDate: '01/05/2022'),
                            SizedBox(width: responsive.wp(2.5)),
                          ],
                        ),
                      ),
                      SizedBox(height: responsive.hp(3)),
                    ],
                  ),
                ],
              )),
        ),
      );
    });
  }
}
