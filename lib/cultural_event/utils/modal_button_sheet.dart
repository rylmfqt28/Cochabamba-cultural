import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/responsive.dart';

class ModalButtonSheet {
  showModal(BuildContext context, Widget child) {
    final Responsive responsive = Responsive.of(context);

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (context) {
          return SizedBox(
            height: responsive.hp(85),
            child: child,
          );
        });
  }
}
