/* (1) Tab home user */
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/event_category_button.dart';
import 'package:cochabambacultural/cultural_event/ui/widgets/card_event_widget.dart';
import 'package:cochabambacultural/cultural_event/model/cultural_event_model.dart';
import 'package:cochabambacultural/cultural_event/repository/upcoming_cultural_event.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:cochabambacultural/cultural_event/utils/get_string_date.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<CulturalEventModel> upcomingEvents = [];

  @override
  void initState() {
    _getUpcomingEvents();
    super.initState();
  }

  Future<void> _getUpcomingEvents() async {
    List<CulturalEventModel> _events =
        await UpcomingCulturalEvent().getUpcomingCulturalEvents();

    setState(() {
      upcomingEvents = _events;
    });
  }

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
                              event: () {}),
                          EventCategoryButton(
                              iconEvent: Icons.music_note,
                              category: " Musicales",
                              event: () {}),
                        ],
                      ),
                      SizedBox(height: responsive.hp(2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EventCategoryButton(
                              iconEvent: Icons.church,
                              category: " Religiosos",
                              event: () {}),
                          EventCategoryButton(
                              iconEvent: Icons.brush,
                              category: " Artísticos",
                              event: () {}),
                        ],
                      ),
                      SizedBox(height: responsive.hp(5)),
                      const TextFormatWidget(
                          valueText: "Proximos eventos",
                          align: TextAlign.left,
                          typeText: 'Subtitle'),
                      SizedBox(height: responsive.hp(3)),
                      SizedBox(
                        height: responsive.hp(36),
                        child: CarouselSlider(
                          options: CarouselOptions(
                              height: responsive.hp(35.1),
                              initialPage: 0,
                              viewportFraction: 0.7,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              enableInfiniteScroll: true,
                              scrollDirection: Axis.horizontal),
                          items: upcomingEvents.map((event) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: CardEventWidget(
                                    url: event.principalImage!,
                                    eventTitle: event.eventName!,
                                    eventDate: GetStringDate()
                                        .dateToDateFormatString(
                                            event.initialDateTime!),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
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
