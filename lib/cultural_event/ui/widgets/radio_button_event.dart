import 'package:flutter/material.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

import 'package:cochabambacultural/utils/app_colors.dart';

class RadioButtonEvent extends StatefulWidget {
  final void Function(String value) changeCategory;
  final int actualValueRadio;

  const RadioButtonEvent(
      {Key? key, required this.changeCategory, required this.actualValueRadio})
      : super(key: key);

  @override
  State<RadioButtonEvent> createState() => _RadioButtonEventState();
}

class _RadioButtonEventState extends State<RadioButtonEvent> {
  late int _valueRadio = widget.actualValueRadio;

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();

    return Column(
      children: [
        Row(
          children: [
            Radio(
              value: 1,
              activeColor: colorApp.primaryColor,
              groupValue: _valueRadio,
              onChanged: (value) {
                setState(() {
                  _valueRadio = int.parse(value.toString());
                });
                widget.changeCategory('Gastronómico');
              },
            ),
            const TextFormatWidget(
                valueText: 'Gastronómico',
                align: TextAlign.left,
                typeText: 'Normal')
          ],
        ),
        Row(
          children: [
            Radio(
                value: 2,
                activeColor: colorApp.primaryColor,
                groupValue: _valueRadio,
                onChanged: (value) {
                  setState(() {
                    _valueRadio = int.parse(value.toString());
                  });
                  widget.changeCategory('Musical');
                }),
            const TextFormatWidget(
                valueText: 'Musical', align: TextAlign.left, typeText: 'Normal')
          ],
        ),
        Row(
          children: [
            Radio(
                value: 3,
                groupValue: _valueRadio,
                activeColor: colorApp.primaryColor,
                onChanged: (value) {
                  setState(() {
                    _valueRadio = int.parse(value.toString());
                  });
                  widget.changeCategory('Religioso');
                }),
            const TextFormatWidget(
                valueText: 'Religioso',
                align: TextAlign.left,
                typeText: 'Normal')
          ],
        ),
        Row(
          children: [
            Radio(
                value: 4,
                groupValue: _valueRadio,
                activeColor: colorApp.primaryColor,
                onChanged: (value) {
                  setState(() {
                    _valueRadio = int.parse(value.toString());
                  });
                  widget.changeCategory('Artísticos');
                }),
            const TextFormatWidget(
                valueText: 'Artísticos',
                align: TextAlign.left,
                typeText: 'Normal')
          ],
        )
      ],
    );
  }
}
