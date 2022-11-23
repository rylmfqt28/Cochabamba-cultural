import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

class TagChip extends StatelessWidget {
  final String labelTag;
  final Function deleteEvent;

  const TagChip({Key? key, required this.labelTag, required this.deleteEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    return Padding(
        padding: EdgeInsets.only(right: responsive.wp(3)),
        child: Chip(
          backgroundColor: colorApp.primaryBackground,
          elevation: 5,
          shadowColor: colorApp.shadowColor,
          label: TextFormatWidget(
              valueText: labelTag, align: TextAlign.left, typeText: 'Normal'),
          onDeleted: () => deleteEvent(),
          deleteIconColor: colorApp.iconSecondary,
        ));
  }
}
