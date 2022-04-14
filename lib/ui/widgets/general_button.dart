import 'package:flutter/material.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

class GeneralButton extends StatelessWidget {
  final String labelButton;
  final Function onPressed;
  final double textSize;
  final double heightButton;
  final double widthButton;

  const GeneralButton(
      {Key? key,
      required this.labelButton,
      required this.onPressed,
      required this.textSize,
      required this.heightButton,
      required this.widthButton})
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
          fontSize: textSize,
          fontWeight: FontWeight.normal,
        ),
      ),
      color: colorApp.primaryFont,
      height: heightButton,
      minWidth: widthButton,
      //minWidth: 90,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () => onPressed(),
    );
  }
}
