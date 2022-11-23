import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

class InputTextAreaWidget extends StatelessWidget {
  final String labelInput;
  final String hintInput;
  final String? Function(String? text)? inputValidation;
  final TextEditingController controllerText;
  final int maxCharacters;

  const InputTextAreaWidget(
      {Key? key,
      required this.labelInput,
      required this.hintInput,
      required this.inputValidation,
      required this.controllerText,
      required this.maxCharacters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    return TextFormField(
      validator: inputValidation,
      keyboardType: TextInputType.multiline,
      obscureText: false,
      controller: controllerText,
      maxLength: maxCharacters,
      maxLines: null,
      style: TextStyle(fontSize: responsive.dp(1.9)),
      decoration: InputDecoration(
        hintText: hintInput,
        hintStyle:
            TextStyle(color: colorApp.placeHolder, fontWeight: FontWeight.w500),
        labelText: labelInput,
        labelStyle: TextStyle(color: colorApp.placeHolder),
        floatingLabelStyle:
            TextStyle(color: colorApp.primaryFont, fontWeight: FontWeight.w500),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorApp.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorApp.primaryColor),
        ),
      ),
    );
  }
}
