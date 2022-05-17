import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class GeneralButton extends StatelessWidget {
  final String labelButton;
  final Function onPressed;

  const GeneralButton({
    Key? key,
    required this.labelButton,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    return MaterialButton(
      child: Text(
        labelButton,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorApp.buttonFontColor,
          fontSize: responsive.dp(2.7),
          fontWeight: FontWeight.normal,
        ),
      ),
      color: colorApp.primaryColor,
      height: responsive.hp(6.3),
      minWidth: responsive.hp(30),
      //minWidth: 90,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () => onPressed(),
    );
  }
}
