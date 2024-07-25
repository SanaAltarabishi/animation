import 'package:flutter/material.dart';

class LeftBtmCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 770;
    final double _yScaling = size.height / 940;
    path.lineTo(-85.8912 * _xScaling, 142.388 * _yScaling);
    path.cubicTo(
      -34.0201 * _xScaling,
      130.413 * _yScaling,
      11.0669 * _xScaling,
      91.6761 * _yScaling,
      66.5766 * _xScaling,
      102.544 * _yScaling,
    );
    path.cubicTo(
      122.119 * _xScaling,
      113.418 * _yScaling,
      168.648 * _xScaling,
      165.375 * _yScaling,
      218.439 * _xScaling,
      201.97 * _yScaling,
    );
    path.cubicTo(
      267.351 * _xScaling,
      237.919 * _yScaling,
      324.885 * _xScaling,
      263.894 * _yScaling,
      358.91 * _xScaling,
      317.401 * _yScaling,
    );
    path.cubicTo(
      392.814 * _xScaling,
      370.716 * _yScaling,
      393.723 * _xScaling,
      435.808 * _yScaling,
      405.784 * _xScaling,
      496.579 * _yScaling,
    );
    path.cubicTo(
      417.205 * _xScaling,
      554.128 * _yScaling,
      430.011 * _xScaling,
      611.078 * _yScaling,
      428.401 * _xScaling,
      667.544 * _yScaling,
    );
    path.cubicTo(
      426.713 * _xScaling,
      726.733 * _yScaling,
      424.117 * _xScaling,
      788.854 * _yScaling,
      396.149 * _xScaling,
      834.472 * _yScaling,
    );
    path.cubicTo(
      368.2 * _xScaling,
      880.059 * _yScaling,
      314.161 * _xScaling,
      893.222 * _yScaling,
      272.099 * _xScaling,
      922.488 * _yScaling,
    );
    path.cubicTo(
      227.569 * _xScaling,
      953.471 * _yScaling,
      195.369 * _xScaling,
      1012.46 * _yScaling,
      139.219 * _xScaling,
      1013.24 * _yScaling,
    );
    path.cubicTo(
      82.9956 * _xScaling,
      1014.02 * _yScaling,
      31.44 * _xScaling,
      957.239 * _yScaling,
      -22.6558 * _xScaling,
      926.574 * _yScaling,
    );
    path.cubicTo(
      -72.2668 * _xScaling,
      898.45 * _yScaling,
      -122.625 * _xScaling,
      875.769 * _yScaling,
      -168.39 * _xScaling,
      838.865 * _yScaling,
    );
    path.cubicTo(
      -217.948 * _xScaling,
      798.903 * _yScaling,
      -275.289 * _xScaling,
      761.069 * _yScaling,
      -302.481 * _xScaling,
      700.928 * _yScaling,
    );
    path.cubicTo(
      -329.673 * _xScaling,
      640.785 * _yScaling,
      -312.924 * _xScaling,
      576.222 * _yScaling,
      -315.664 * _xScaling,
      513.137 * _yScaling,
    );
    path.cubicTo(
      -318.316 * _xScaling,
      452.081 * _yScaling,
      -330.1 * _xScaling,
      389.794 * _yScaling,
      -318.471 * _xScaling,
      332.749 * _yScaling,
    );
    path.cubicTo(
      -306.26 * _xScaling,
      272.851 * _yScaling,
      -289.302 * _xScaling,
      209.733 * _yScaling,
      -246.707 * _xScaling,
      174.87 * _yScaling,
    );
    path.cubicTo(
      -204.252 * _xScaling,
      140.122 * _yScaling,
      -139.631 * _xScaling,
      154.795 * _yScaling,
      -85.8912 * _xScaling,
      142.388 * _yScaling,
    );
    path.cubicTo(
      -85.8912 * _xScaling,
      142.388 * _yScaling,
      -85.8912 * _xScaling,
      142.388 * _yScaling,
      -85.8912 * _xScaling,
      142.388 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
