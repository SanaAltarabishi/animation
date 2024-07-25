import 'package:flutter/material.dart';

class LeftTopCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 390;
    final double _yScaling = size.height / 450;
    path.lineTo(15.8844 * _xScaling, 122.032 * _yScaling);
    path.cubicTo(
      41.7322 * _xScaling,
      115.818 * _yScaling,
      64.4102 * _xScaling,
      96.6306 * _yScaling,
      91.895 * _xScaling,
      101.507 * _yScaling,
    );
    path.cubicTo(
      119.396 * _xScaling,
      106.385 * _yScaling,
      142.116 * _xScaling,
      131.325 * _yScaling,
      166.569 * _xScaling,
      148.764 * _yScaling,
    );
    path.cubicTo(
      190.591 * _xScaling,
      165.895 * _yScaling,
      218.969 * _xScaling,
      178.109 * _yScaling,
      235.467 * _xScaling,
      203.895 * _yScaling,
    );
    path.cubicTo(
      251.907 * _xScaling,
      229.59 * _yScaling,
      251.874 * _xScaling,
      261.261 * _yScaling,
      257.411 * _xScaling,
      290.746 * _yScaling,
    );
    path.cubicTo(
      262.655 * _xScaling,
      318.668 * _yScaling,
      268.591 * _xScaling,
      346.289 * _yScaling,
      267.371 * _xScaling,
      373.781 * _yScaling,
    );
    path.cubicTo(
      266.093 * _xScaling,
      402.598 * _yScaling,
      264.341 * _xScaling,
      432.85 * _yScaling,
      250.113 * _xScaling,
      455.259 * _yScaling,
    );
    path.cubicTo(
      235.895 * _xScaling,
      477.652 * _yScaling,
      208.962 * _xScaling,
      484.46 * _yScaling,
      187.856 * _xScaling,
      499.016 * _yScaling,
    );
    path.cubicTo(
      165.513 * _xScaling,
      514.425 * _yScaling,
      149.084 * _xScaling,
      543.374 * _yScaling,
      121.194 * _xScaling,
      544.171 * _yScaling,
    );
    path.cubicTo(
      93.2682 * _xScaling,
      544.968 * _yScaling,
      68.0885 * _xScaling,
      517.718 * _yScaling,
      41.4531 * _xScaling,
      503.197 * _yScaling,
    );
    path.cubicTo(
      17.0259 * _xScaling,
      489.879 * _yScaling,
      -7.81311 * _xScaling,
      479.216 * _yScaling,
      -30.2651 * _xScaling,
      461.596 * _yScaling,
    );
    path.cubicTo(
      -54.5776 * _xScaling,
      442.517 * _yScaling,
      -82.7712 * _xScaling,
      424.531 * _yScaling,
      -95.8271 * _xScaling,
      395.465 * _yScaling,
    );
    path.cubicTo(
      -108.883 * _xScaling,
      366.398 * _yScaling,
      -100.086 * _xScaling,
      334.852 * _yScaling,
      -100.977 * _xScaling,
      304.171 * _yScaling,
    );
    path.cubicTo(
      -101.84 * _xScaling,
      274.477 * _yScaling,
      -107.228 * _xScaling,
      244.252 * _yScaling,
      -101.029 * _xScaling,
      216.404 * _yScaling,
    );
    path.cubicTo(
      -94.5197 * _xScaling,
      187.162 * _yScaling,
      -85.6289 * _xScaling,
      156.319 * _yScaling,
      -64.217 * _xScaling,
      139.036 * _yScaling,
    );
    path.cubicTo(
      -42.8756 * _xScaling,
      121.809 * _yScaling,
      -10.8945 * _xScaling,
      128.469 * _yScaling,
      15.8844 * _xScaling,
      122.032 * _yScaling,
    );
    path.cubicTo(
      15.8844 * _xScaling,
      122.032 * _yScaling,
      15.8844 * _xScaling,
      122.032 * _yScaling,
      15.8844 * _xScaling,
      122.032 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
