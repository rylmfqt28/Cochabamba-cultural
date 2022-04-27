import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/utils/responsive.dart';

class DialogWidget extends StatelessWidget {
  final String titleText;
  final String subTitle;
  final String labelInputDialog;
  final String hintInputDialog;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String? text)? inputValidation;
  final void Function(String text) onChangeInput;
  final String labelButtonModal;
  final Function onPressed;

  const DialogWidget(
      {Key? key,
      required this.titleText,
      required this.subTitle,
      required this.labelInputDialog,
      required this.hintInputDialog,
      required this.keyboardType,
      required this.isPassword,
      required this.inputValidation,
      required this.onChangeInput,
      required this.labelButtonModal,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: responsive.isTablet ? 430 : 360,
          ),
          height: responsive.hp(38),
          child: Stack(children: [
            ListView(
              children: [
                SizedBox(height: responsive.hp(2)),
                TextFormatWidget(
                    valueText: titleText,
                    align: TextAlign.center,
                    typeText: 'Title'),
                SizedBox(height: responsive.hp(2)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextFormatWidget(
                      valueText: subTitle,
                      align: TextAlign.left,
                      typeText: 'Normal'),
                ),
                SizedBox(height: responsive.hp(2)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: InputTextWidget(
                    labelInput: labelInputDialog,
                    hintInput: hintInputDialog,
                    keyboardType: keyboardType,
                    inputPassword: isPassword,
                    inputValidation: inputValidation,
                    onChangeInput: onChangeInput,
                  ),
                ),
                SizedBox(height: responsive.hp(4)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: GeneralButton(
                    labelButton: labelButtonModal,
                    onPressed: () => onPressed(),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
