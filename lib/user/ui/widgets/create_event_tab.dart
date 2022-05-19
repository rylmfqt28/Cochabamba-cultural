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
                        category: '   Crear evento',
                        event: () {
                          Navigator.pushNamed(context, 'create_event_screen');
                        }),
                  ),
                  SizedBox(height: responsive.hp(3)),
                  EvenRowWidget(
                    url:
                        'https://img3.travelagenciesfinder.com/470/556/2355618434705569.jpg',
                    eventName:
                        'XVI Feria del pescado y aniversario de Villa Tunari.',
                    event: () {},
                  ),
                  SizedBox(height: responsive.hp(2)),
                  EvenRowWidget(
                    url:
                        'https://img3.travelagenciesfinder.com/470/556/2355618434705569.jpg',
                    eventName:
                        'XVI Feria del pescado y aniversario de Villa Tunari.',
                    event: () {},
                  ),
                  SizedBox(height: responsive.hp(2)),
                  EvenRowWidget(
                    url:
                        'https://img3.travelagenciesfinder.com/470/556/2355618434705569.jpg',
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
