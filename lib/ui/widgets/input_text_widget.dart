import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String labelInput;
  final String hintInput;
  final Color colorLabel;
  final Color colorHint;
  final TextInputType keyboardType;
  final bool inputPassword;
  final double fontSizeInput;

  const InputTextWidget(
      {Key? key,
      required this.labelInput,
      required this.hintInput,
      required this.colorLabel,
      required this.colorHint,
      this.keyboardType = TextInputType.text,
      required this.inputPassword,
      required this.fontSizeInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: inputPassword,
      style: TextStyle(fontSize: fontSizeInput),
      decoration: InputDecoration(
        hintText: hintInput,
        hintStyle: TextStyle(color: colorHint, fontWeight: FontWeight.w500),
        labelText: labelInput,
        labelStyle: TextStyle(color: colorHint),
        floatingLabelStyle:
            TextStyle(color: colorLabel, fontWeight: FontWeight.w500),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorLabel),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorLabel),
        ),
      ),
    );
  }
}
