/* (3) Tab create event event */
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

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
                  Text(
                    'Crear Evento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorApp.primaryFont,
                      fontSize: responsive.dp(3.9),
                      fontWeight: FontWeight.bold,
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
