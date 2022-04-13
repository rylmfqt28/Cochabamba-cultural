import 'package:flutter/material.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

class GeneralButton extends StatelessWidget {
  final String labelButton;
  final Function onPressed;

  const GeneralButton(
      {Key? key, required this.labelButton, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    return MaterialButton(
      child: Text(
        labelButton,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorApp.primaryBackground,
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
      ),
      color: colorApp.primaryFont,
      height: 50,
      minWidth: 90,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () => onPressed(),
    );
  }
}
