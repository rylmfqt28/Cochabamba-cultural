import 'package:flutter/cupertino.dart';

class AppColors {
  final Color _primaryBackground = const Color(0xffffffff);
  // final Color _secundaryBackground = const Color(0xff222831); dark mode

  final Color _primaryFont = const Color(0xff1bba6e);
  final Color _secondaryFont = const Color(0xff212121);
  final Color _buttonFontColor = const Color(0xffffffff);
  // final Color _primaryFont = const Color(0xff129959); dark mode
  // final Color _secondaryFont = const Color(0xffd7d7d7); dark mode
  // final Color _buttonFontColor = const Color(0xffd7d7d7);

  final Color _placeHolder = const Color(0xffb4b3b3);
  // final Color _placeHolder = const Color(0xffd7d7d7); dark mode

  final Color _successful = const Color(0xff1bba6e);
  final Color _errorColor = const Color(0xffF0627C);
  // final Color _successful = const Color(0xff129959); dark mode
  // final Color _errorColor = const Color(0xffF0627C);

  final Color _primaryColor = const Color(0xff1bba6e);
  // final Color _primaryColor = const Color(0xff129959); dark mode

  final Color _shadowColor = const Color(0xff212121);

  final Color _iconPrimary = const Color(0xffffffff);

  AppColors();

  Color get primaryBackground => _primaryBackground;
  //Color get secundaryBackground => _secundaryBackground;

  Color get primaryFont => _primaryFont;
  Color get secundaryFont => _secondaryFont;
  Color get buttonFontColor => _buttonFontColor;

  Color get placeHolder => _placeHolder;

  Color get errorColor => _errorColor;
  Color get successful => _successful;

  Color get primaryColor => _primaryColor;

  Color get shadowColor => _shadowColor;

  Color get iconPrimary => _iconPrimary;
}
