import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

class FieldUpdateAccount extends StatefulWidget {
  final String nameField;
  final String valueField;
  final Function onPressed;

  const FieldUpdateAccount(
      {Key? key,
      required this.nameField,
      required this.onPressed,
      required this.valueField})
      : super(key: key);

  @override
  State<FieldUpdateAccount> createState() => _FieldUpdateAccountState();
}

class _FieldUpdateAccountState extends State<FieldUpdateAccount> {
  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: TextFormatWidget(
              valueText: widget.nameField,
              align: TextAlign.left,
              typeText: 'Litle'),
        ),
        Container(
          height: responsive.hp(6),
          width: responsive.isTablet ? 430 : 360,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: colorApp.successful, width: responsive.hp(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormatWidget(
                  valueText: widget.valueField,
                  align: TextAlign.left,
                  typeText: 'Normal'),
              InkWell(
                onTap: () => widget.onPressed(),
                child: Icon(
                  Icons.edit,
                  color: colorApp.successful,
                  size: 25,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
