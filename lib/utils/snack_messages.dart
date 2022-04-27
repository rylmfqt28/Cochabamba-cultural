import 'package:flutter/material.dart';

class SnackMessages {
  getSnack(String message, Color statusColor) {
    final dynamic snackBar = SnackBar(
        duration: const Duration(seconds: 10),
        content: Text(message),
        backgroundColor: statusColor,
        action: SnackBarAction(
          label: "Cerrar",
          textColor: Colors.white,
          onPressed: () {},
        ));
    return snackBar;
  }
}
