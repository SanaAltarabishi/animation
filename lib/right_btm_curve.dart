import 'package:flutter/material.dart';

class RightTopCurveBtn extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 310;
    final double _yScaling = size.height / 380;
    path.lineTo(197.31 * _xScaling, -94.0542 * _yScaling);
    path.cubicTo(
      218.384 * _xScaling,
      -98.9195 * _yScaling,
      236.702 * _xScaling,
      -114.658 * _yScaling,
      259.255 * _xScaling,
      -110.242 * _yScaling,
    );
    path.cubicTo(
      281.821 * _xScaling,
      -105.825 * _yScaling,
      300.725 * _xScaling,
      -84.715 * _yScaling,
      320.955 * _xScaling,
      -69.847 * _yScaling,
    );
    path.cubicTo(
      340.827 * _xScaling,
      -55.2416 * _yScaling,
      364.202 * _xScaling,
      -44.688 * _yScaling,
      378.026 * _xScaling,
      -22.9491 * _yScaling,
    );
    path.cubicTo(
      391.801 * _xScaling,
      -1.28774 * _yScaling,
      392.17 * _xScaling,
      25.1582 * _yScaling,
      397.07 * _xScaling,
      49.8486 * _yScaling,
    );
    path.cubicTo(
      401.71 * _xScaling,
      73.2298 * _yScaling,
      406.913 * _xScaling,
      96.368 * _yScaling,
      406.259 * _xScaling,
      119.309 * _yScaling,
    );
    path.cubicTo(
      405.574 * _xScaling,
      143.357 * _yScaling,
      404.519 * _xScaling,
      168.596 * _yScaling,
      393.156 * _xScaling,
      187.13 * _yScaling,
    );
    path.cubicTo(
      381.8 * _xScaling,
      205.651 * _yScaling,
      359.845 * _xScaling,
      210.999 * _yScaling,
      342.756 * _xScaling,
      222.889 * _yScaling,
    );
    path.cubicTo(
      324.664 * _xScaling,
      235.477 * _yScaling,
      311.582 * _xScaling,
      259.445 * _yScaling,
      288.769 * _xScaling,
      259.761 * _yScaling,
    );
    path.cubicTo(
      265.926 * _xScaling,
      260.078 * _yScaling,
      244.98 * _xScaling,
      237.008 * _yScaling,
      223.001 * _xScaling,
      224.549 * _yScaling,
    );
    path.cubicTo(
      202.845 * _xScaling,
      213.123 * _yScaling,
      182.385 * _xScaling,
      203.908 * _yScaling,
      163.791 * _xScaling,
      188.915 * _yScaling,
    );
    path.cubicTo(
      143.657 * _xScaling,
      172.679 * _yScaling,
      120.36 * _xScaling,
      157.307 * _yScaling,
      109.312 * _xScaling,
      132.873 * _yScaling,
    );
    path.cubicTo(
      98.2642 * _xScaling,
      108.438 * _yScaling,
      105.069 * _xScaling,
      82.2063 * _yScaling,
      103.956 * _xScaling,
      56.5758 * _yScaling,
    );
    path.cubicTo(
      102.879 * _xScaling,
      31.7698 * _yScaling,
      98.0909 * _xScaling,
      6.46339 * _yScaling,
      102.816 * _xScaling,
      -16.7134 * _yScaling,
    );
    path.cubicTo(
      107.777 * _xScaling,
      -41.0492 * _yScaling,
      114.666 * _xScaling,
      -66.6928 * _yScaling,
      131.972 * _xScaling,
      -80.8573 * _yScaling,
    );
    path.cubicTo(
      149.221 * _xScaling,
      -94.9751 * _yScaling,
      175.476 * _xScaling,
      -89.0135 * _yScaling,
      197.31 * _xScaling,
      -94.0542 * _yScaling,
    );
    path.cubicTo(
      197.31 * _xScaling,
      -94.0542 * _yScaling,
      197.31 * _xScaling,
      -94.0542 * _yScaling,
      197.31 * _xScaling,
      -94.0542 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
