import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';

class EvenRowWidget extends StatelessWidget {
  final String url;
  final String eventName;
  final Function event;

  const EvenRowWidget(
      {Key? key,
      required this.url,
      required this.eventName,
      required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    return InkWell(
      onTap: () => event(),
      child: Row(
        children: [
          SizedBox(
            height: responsive.hp(7),
            width: responsive.wp(10),
            child: Image.network(
              url,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: responsive.hp(1),
          ),
          SizedBox(
            width: responsive.wp(70),
            height: responsive.hp(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormatWidget(
                  valueText: eventName,
                  align: TextAlign.left,
                  typeText: 'Normal'),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.edit,
              color: colorApp.primaryColor,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
