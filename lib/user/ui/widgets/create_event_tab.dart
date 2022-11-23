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
    myEvents = await GetCreatedEvents()
        .getMyEvents(FirebaseAuth.instance.currentUser!.uid);
    print(myEvents[0].address);
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
              ListView(
                children: [
                  SizedBox(height: responsive.hp(3)),
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
                  EvenRowWidget(
                    url:
                        'https://firebasestorage.googleapis.com/v0/b/cochabamba-cultural.appspot.com/o/events%2Fimg-event-dev.jpg?alt=media&token=631d4aec-d4b1-44b1-8dfa-88a40bdbfc7f',
                    eventName:
                        'XVI Feria del pescado y aniversario de Villa Tunari.',
                    event: () {},
                  ),
                  SizedBox(height: responsive.hp(2)),
                  EvenRowWidget(
                    url:
                        'https://firebasestorage.googleapis.com/v0/b/cochabamba-cultural.appspot.com/o/events%2Fimg-event-dev.jpg?alt=media&token=631d4aec-d4b1-44b1-8dfa-88a40bdbfc7f',
                    eventName:
                        'XVI Feria del pescado y aniversario de Villa Tunari.',
                    event: () {},
                  ),
                  SizedBox(height: responsive.hp(2)),
                  EvenRowWidget(
                    url:
                        'https://firebasestorage.googleapis.com/v0/b/cochabamba-cultural.appspot.com/o/events%2Fimg-event-dev.jpg?alt=media&token=631d4aec-d4b1-44b1-8dfa-88a40bdbfc7f',
                    eventName:
                        'XVI Feria del pescado y aniversario de Villa Tunari.',
                    event: () {},
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
