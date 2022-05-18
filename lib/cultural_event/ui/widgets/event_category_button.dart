import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class EventCategoryButton extends StatelessWidget {
  final IconData iconEvent;
  final String category;
  final Function event;

  const EventCategoryButton(
      {Key? key,
      required this.iconEvent,
      required this.category,
      required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    return Container(
      width: responsive.wp(45),
      height: responsive.hp(6),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: colorApp.shadowColor,
            blurRadius: 8.0,
            offset: const Offset(0.0, 0.15),
            spreadRadius: -9)
      ]),
      child: MaterialButton(
          height: responsive.hp(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(iconEvent, size: 30, color: colorApp.primaryColor),
              Text(
                category,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: colorApp.secundaryFont,
                  fontSize: responsive.dp(1.6),
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: colorApp.primaryBackground,
          onPressed: () => event()),
    );
  }
}
