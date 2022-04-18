import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class TextSpanWidget extends StatelessWidget {
  final String normalText;
  final String spanText;
  final TapGestureRecognizer eventOnTap;
  final TextAlign align;

  const TextSpanWidget(
      {Key? key,
      required this.normalText,
      required this.spanText,
      required this.eventOnTap,
      required this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    return Text.rich(
      TextSpan(
          text: normalText,
          style: TextStyle(
            color: colorApp.secundaryFont,
            fontSize: responsive.dp(1.9),
          ),
          children: [
            const TextSpan(text: ""),
            TextSpan(
                text: spanText,
                style: TextStyle(
                  color: colorApp.primaryFont,
                  fontSize: responsive.dp(1.9),
                ),
                recognizer: eventOnTap),
            const TextSpan(text: " "),
          ]),
      textAlign: align,
    );
  }
}
