
import 'dart:math';

import 'package:flutter/material.dart';

class StarShapeBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _createStarPath(
        rect.width / 2, rect.height / 2, 5, rect.width / 2, rect.width / 4);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // the same path as outer path, or return an empty path if inner path is not needed
    return _createStarPath(
        rect.width / 2, rect.height / 2, 5, rect.width / 2, rect.width / 4);
  }

  Path _createStarPath(double cx, double cy, int spikes, double outerRadius,
      double innerRadius) {
    final path = Path();
    double angle = pi / spikes;

    for (int i = 0; i < spikes * 2; i++) {
      double radius = (i % 2 == 0) ? outerRadius : innerRadius;
      double x = cx + cos(i * angle) * radius;
      double y = cy + sin(i * angle) * radius;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
