/* (2) Tab search event */
import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';

class SearchEventTab extends StatefulWidget {
  const SearchEventTab({Key? key}) : super(key: key);

  @override
  State<SearchEventTab> createState() => _SearchEventTabState();
}

class _SearchEventTabState extends State<SearchEventTab> {
  @override
  Widget build(BuildContext context) {
    final colorApp = AppColors();
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: colorApp.primaryBackground,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: responsive.isTablet ? 430 : 360,
          ),
          child: Stack(
            children: [
              ListView(
                children: [
                  Text(
                    'Buscar Evento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorApp.primaryFont,
                      fontSize: responsive.dp(3.9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
