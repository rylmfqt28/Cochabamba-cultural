import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/validation.dart';

class DialogWidget extends StatelessWidget {
  final String titleText;
  final String subTitle;
  final String labelInputDialog;
  final String hintInputDialog;
  final TextInputType keyboardType;
  final String labelButtonModal;
  final Function onPressed;

  const DialogWidget(
      {Key? key,
      required this.titleText,
      required this.subTitle,
      required this.labelInputDialog,
      required this.hintInputDialog,
      required this.keyboardType,
      required this.labelButtonModal,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final GlobalKey<FormState> _keyFormDialog = GlobalKey();

    Validation validation = Validation();

    String _sendEmail = '';

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: responsive.isTablet ? 430 : 360,
          ),
          height: responsive.hp(38),
          child: Form(
            key: _keyFormDialog,
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
                      inputPassword: false,
                      inputValidation: (value) =>
                          validation.validationField(value, 'email'),
                      onChangeInput: (value) {
                        _sendEmail = value;
                      },
                    ),
                  ),
                  SizedBox(height: responsive.hp(4)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: GeneralButton(
                      labelButton: labelButtonModal,
                      onPressed: () {
                        /***ver q se hace aqui */
                        if (_keyFormDialog.currentState!.validate()) {
                          print("Enviar mensaje a $_sendEmail");
                          //cerrar dialog
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
