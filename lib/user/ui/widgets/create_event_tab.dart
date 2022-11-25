import 'package:cochabambacultural/cultural_event/model/cultural_event_model.dart';
import 'package:cochabambacultural/cultural_event/repository/get_created_events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/event_category_button.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/event_row_widget.dart';

class CreateEventTab extends StatefulWidget {
  const CreateEventTab({Key? key}) : super(key: key);

  @override
  State<CreateEventTab> createState() => _CreateEventTabState();
}

class _CreateEventTabState extends State<CreateEventTab> {
  List<CulturalEventModel> myEvents = [];

  @override
  void initState() {
    _getEvents();
    super.initState();
  }

  Future<void> _getEvents() async {
    List<CulturalEventModel> _actualEvents = await GetCreatedEvents()
        .getMyEvents(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      myEvents = _actualEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: colorApp.primaryBackground,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: responsive.isTablet ? 430 : 360,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: responsive.hp(10)),
                  const TextFormatWidget(
                      valueText: 'Eventos creados',
                      align: TextAlign.left,
                      typeText: 'Title'),
                  SizedBox(height: responsive.hp(1)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: EventCategoryButton(
                        iconEvent: Icons.add,
                        category: ' Crear evento',
                        event: () {
                          Navigator.pushNamed(context, 'create_event_screen');
                        }),
                  ),
                  SizedBox(height: responsive.hp(3)),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(bottom: responsive.wp(2)),
                      itemCount: myEvents.length,
                      itemBuilder: (context, index) {
                        return EvenRowWidget(
                            url: myEvents[index].principalImage!,
                            eventName: myEvents[index].eventName!,
                            event: () {});
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
