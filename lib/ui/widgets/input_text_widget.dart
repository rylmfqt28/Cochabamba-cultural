import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

class InputTextWidget extends StatelessWidget {
  final String labelInput;
  final String hintInput;
  final TextInputType keyboardType;
  final bool inputPassword;
  final String? Function(String? text)? inputValidation;
  final void Function(String text) onChangeInput;

  const InputTextWidget(
      {Key? key,
      required this.labelInput,
      required this.hintInput,
      this.keyboardType = TextInputType.text,
      required this.inputPassword,
      required this.inputValidation,
      required this.onChangeInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    return TextFormField(
      validator: inputValidation,
      keyboardType: keyboardType,
      obscureText: inputPassword,
      onChanged: onChangeInput,
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
          borderSide: BorderSide(color: colorApp.primaryFont),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorApp.primaryFont),
        ),
      ),
    );
  }
}
