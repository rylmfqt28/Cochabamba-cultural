import 'package:flutter/material.dart';

class BounceAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis orientation;

  const BounceAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 900),
      this.offset = 140.0,
      this.orientation = Axis.horizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        child: child,
        curve: Curves.elasticOut,
        tween: Tween(begin: 1.0, end: 0),
        duration: duration,
        builder: (context, value, child) {
          return Transform.translate(
              offset: orientation == Axis.horizontal
                  ? Offset(value * offset, 0.0)
                  : Offset(0.00, value * offset),
              child: child);
        });
  }
}
