import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/snack_messages.dart';

class ExceptionFirestore {
  final AppColors colorApp = AppColors();

  SnackMessages messages = SnackMessages();

  showMessageException(String error, BuildContext context, double margin) {
    switch (error) {
      case "wrong-password":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo electrónico o la contraseña son incorrectas.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "user-not-found":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo electrónico ingresado no se encuentra registrado.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "user-disabled":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Su cuenta se encuentra suspendida.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "invalid-email":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo electrónico ingresado no es válido.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "email-already-in-use":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "El correo electrónico ingresado ya se encuentra registrado.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "operation-not-allowed":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "La operación que desea realizar no se encuentra disponible.",
            colorApp.errorColor,
            context,
            margin));
        break;
      case "too-many-requests":
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Se están realizando demasiadas solicitudes.",
            colorApp.errorColor,
            context,
            margin));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(messages.getSnack(
            "Ha ocurrido un error intente de nuevo.",
            colorApp.errorColor,
            context,
            margin));
    }
  }
}
