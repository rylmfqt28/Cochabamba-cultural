import 'package:flutter/material.dart';

class SnackMessages {
  getSnack(
      String message, Color statusColor, BuildContext context, double margin) {
    //margin: sin menu->150, con menu->190
    final dynamic snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(message),
        backgroundColor: statusColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - margin,
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
