import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  late double _width;
  late double _height;
  late double _diagonal;

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;

    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
  }

  double wp(double percent) => (_width * percent) / 100;
  double hp(double percent) => (_height * percent) / 100;
  double dp(double percent) => (_diagonal * percent) / 100;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;

  static Responsive of(BuildContext context) => Responsive(context);
}
