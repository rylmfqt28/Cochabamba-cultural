import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';

class DateTimePicker {
  final colorApp = AppColors();

  Future<DateTime?> pickDate(BuildContext context, DateTime initialDate) =>
      showDatePicker(
          context: context,
          cancelText: 'Cancelar',
          confirmText: 'Continuar',
          helpText: 'Seleccionar fecha',
          errorFormatText: 'No cumple con el formato de fecha adecuado.',
          errorInvalidText: 'El valor ingresado no es una fecha seleccionable.',
          fieldHintText: 'Ingrese una fecha',
          fieldLabelText: 'Fecha',
          initialDate: initialDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return _setThemeDialogDateTimePicker(context, child);
          });

  Future<TimeOfDay?> pickTime(BuildContext context, DateTime initialTime) =>
      showTimePicker(
          context: context,
          cancelText: 'Cancelar',
          confirmText: 'Continuar',
          helpText: 'Seleccionar hora',
          errorInvalidText: 'Hora seleccionada no valida.',
          hourLabelText: 'Hora',
          minuteLabelText: 'Minuto',
          initialEntryMode: TimePickerEntryMode.input,
          initialTime:
              TimeOfDay(hour: initialTime.hour, minute: initialTime.minute),
          builder: (context, child) {
            return _setThemeDialogDateTimePicker(context, child);
          });

  Theme _setThemeDialogDateTimePicker(BuildContext context, Widget? child) {
    return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: colorApp.primaryColor, // header background color
            onPrimary: colorApp.buttonFontColor, // header text color
            onSurface: colorApp.secundaryFont, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: colorApp.primaryFont, // button text color
            ),
          ),
          timePickerTheme: TimePickerThemeData(
            dialBackgroundColor: colorApp.primaryBackground,
            hourMinuteShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: Color(0xff1bba6e)),
            ),
            dayPeriodBorderSide: const BorderSide(color: Color(0xff1bba6e)),
            hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? const Color(0xff1bba6e)
                    : Colors.white),
            hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.white
                    : const Color(0xff1bba6e)),
          ),
        ),
        child: child!);
  }
}
