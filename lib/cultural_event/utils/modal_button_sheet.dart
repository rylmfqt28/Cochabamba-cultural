import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

class ModalButtonSheet {
  showModal(BuildContext context, Widget child) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.add_location_alt,
                  size: 30,
                  color: colorApp.primaryColor,
                ),
                title: const TextFormatWidget(
                  valueText: 'Seleccione la ubicación del evento.',
                  align: TextAlign.left,
                  typeText: 'Normal',
                ),
              ),
              SizedBox(height: responsive.hp(75), child: child)
            ],
          );
        });
  }
}
