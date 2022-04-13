import 'package:flutter/cupertino.dart';

class AppColors {
  final Color _primaryBackground = const Color(0xffffffff);
  //final Color _secundaryBackground = const Color(0xff222831);

  final Color _primaryFont = const Color(0xff1bba6e);
  final Color _secondaryFont = const Color(0xff212121);

  final Color _placeHolder = const Color(0xffb4b3b3);

  AppColors();

  Color get primaryBackground => _primaryBackground;
  //Color get secundaryBackground => _secundaryBackground;

  Color get primaryFont => _primaryFont;
  Color get secundaryFont => _secondaryFont;

  Color get placeHolder => _placeHolder;
}
