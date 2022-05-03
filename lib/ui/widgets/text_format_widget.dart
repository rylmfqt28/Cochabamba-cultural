import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class TextFormatWidget extends StatelessWidget {
  final String valueText;
  final TextAlign align;
  final String typeText;

  const TextFormatWidget(
      {Key? key,
      required this.valueText,
      required this.align,
      required this.typeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    if (typeText == 'Title') {
      return Text(
        valueText,
        textAlign: align,
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: colorApp.secundaryFont,
          fontSize: responsive.dp(3),
          fontWeight: FontWeight.bold,
        ),
      );
    }

    // if typeText is equal to 'Subtitle'
    if (typeText == 'Subtitle') {
      return Text(
        valueText,
        textAlign: align,
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: colorApp.secundaryFont, fontSize: responsive.dp(2.5)),
      );
    }

    // if typeText is equal to 'Litle'
    if (typeText == 'Litle') {
      return Text(
        valueText,
        textAlign: align,
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: colorApp.secundaryFont, fontSize: responsive.dp(1.4)),
      );
    }

    // if typeText is equal to 'Normal'
    return Text(
      valueText,
      textAlign: align,
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: colorApp.secundaryFont,
        fontSize: responsive.dp(1.9),
      ),
    );
  }
}
