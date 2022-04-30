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
      width: responsive.wp(42),
      height: responsive.hp(6),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black54,
            blurRadius: 8.0,
            offset: Offset(0.0, 0.15),
            spreadRadius: -9)
      ]),
      child: MaterialButton(
          height: responsive.hp(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(iconEvent, size: 30, color: colorApp.successful),
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
          color: Colors.white,
          onPressed: () => event()),
    );
  }
}
