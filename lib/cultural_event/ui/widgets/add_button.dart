import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class AddButton extends StatelessWidget {
  final IconData iconAdd;
  final Function event;

  const AddButton({Key? key, required this.iconAdd, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    return Container(
      width: responsive.wp(20),
      height: responsive.hp(5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: colorApp.shadowColor,
            blurRadius: 8.0,
            offset: const Offset(0.0, 4),
            spreadRadius: -9)
      ]),
      child: MaterialButton(
        height: responsive.hp(5),
        child: Icon(iconAdd, size: 30, color: colorApp.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: colorApp.primaryBackground,
        onPressed: () => event(),
      ),
    );
  }
}
