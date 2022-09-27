import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/validation_event.dart';

import 'package:cochabambacultural/cultural_event/utils/date_time_picker.dart';

class InputFieldDate extends StatefulWidget {
  final String labelInput;
  final String hintInput;
  final DateTime initialDateTime;
  final TextEditingController controllerDateTime;

  const InputFieldDate(
      {Key? key,
      required this.labelInput,
      required this.hintInput,
      required this.initialDateTime,
      required this.controllerDateTime})
      : super(key: key);

  @override
  State<InputFieldDate> createState() => _InputFieldDateState();
}

class _InputFieldDateState extends State<InputFieldDate> {
  final DateTimePicker _dateTimePicker = DateTimePicker();

  final TextEditingController controllerTextInput = TextEditingController();

  late DateTime _selectedDateTime = widget.initialDateTime;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    final validate = ValidationEvent();

    return TextFormField(
      controller: controllerTextInput,
      style: TextStyle(fontSize: responsive.dp(1.9)),
      validator: (value) =>
          validate.validateDateField(value!, widget.labelInput),
      showCursor: false,
      readOnly: true,
      onTap: () async {
        _pickDateTime(context, _selectedDateTime);
      },
      decoration: InputDecoration(
        hintText: widget.hintInput,
        hintStyle:
            TextStyle(color: colorApp.placeHolder, fontWeight: FontWeight.w500),
        labelText: '* ${widget.labelInput}',
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

  Future _pickDateTime(BuildContext context, DateTime date) async {
    DateTime? newDate = await _dateTimePicker.pickDate(context, date);
    if (newDate == null) return;

    TimeOfDay? newTime = await _dateTimePicker.pickTime(context, date);
    if (newTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(newDate.year, newDate.month, newDate.day,
          newTime.hour, newTime.minute);

      controllerTextInput.text =
          "Fecha: ${newDate.day}-${newDate.month}-${newDate.year}   Hora: ${newTime.hour}:${newTime.minute}";

      widget.controllerDateTime.text =
          "${newDate.year}-${newDate.month}-${newDate.day}T${newTime.hour}:${newTime.minute}";
    });
  }
}
