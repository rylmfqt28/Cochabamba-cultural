import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class CardEventWidget extends StatelessWidget {
  final String url;
  final String eventTitle;
  final String eventDate;

  const CardEventWidget(
      {Key? key,
      required this.url,
      required this.eventTitle,
      required this.eventDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    return SizedBox(
      height: responsive.hp(35),
      width: responsive.wp(55),
      //color: colorApp.successful,
      child: Card(
        color: colorApp.primaryBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Column(
          children: [
            SizedBox(
              height: responsive.hp(22),
              width: responsive.wp(55),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                child: Image.network(
                  url,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 6.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  eventTitle,
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: colorApp.secundaryFont,
                    fontSize: responsive.dp(1.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0.0, 0),
                  child: Icon(Icons.calendar_month,
                      color: colorApp.primaryColor, size: 20),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0.0, 0),
                  child: Text(
                    eventDate,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: colorApp.secundaryFont,
                      fontSize: responsive.dp(1.7),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
