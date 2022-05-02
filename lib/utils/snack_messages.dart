import 'package:flutter/material.dart';

class SnackMessages {
  getSnack(String message, Color statusColor, BuildContext context) {
    final dynamic snackBar = SnackBar(
        duration: const Duration(seconds: 10),
        content: Text(message),
        backgroundColor: statusColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 15,
            right: 15),
        action: SnackBarAction(
          label: "Cerrar",
          textColor: Colors.white,
          onPressed: () {},
        ));
    return snackBar;
  }
}
