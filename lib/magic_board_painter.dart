import 'dart:math';
import 'package:flutter/material.dart';
import 'package:magic_board_animation/trail_point.dart';

class MagicBoardPainter extends CustomPainter {
  final List<TrailPoint> points;
  // final Random random = Random();
  final Color lineColor;
  final double sparkleRadius = 15;
  double sparkleAngle = 0;

  MagicBoardPainter(
    this.points,
    this.lineColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    for (int i = 0; i < points.length - 1; i++) {
      double opacity = (i / points.length);
      paint.color = lineColor.withOpacity(opacity.clamp(0.0, 1.0));
      canvas.drawLine(points[i].position, points[i + 1].position, paint);
    }

    if (points.isNotEmpty) {
      drawStarShape(canvas, points.last.position);
      drawRotatingMiniStars(canvas, points.last.position);
    }
  }

  void drawStarShape(Canvas canvas, Offset position) {
    Paint starPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, 6, starPaint);
  }

  void drawRotatingMiniStars(Canvas canvas, Offset center) {
    Paint miniStarPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 3; i++) {
      double angle = sparkleAngle + (i * 2 * pi / 3);
      double x = center.dx + sparkleRadius * cos(angle);
      double y = center.dy + sparkleRadius * sin(angle);
      drawMiniStar(canvas, Offset(x, y), miniStarPaint);
    }
    sparkleAngle += 0.1;
  }

  // to Draw  Mini Star
  void drawMiniStar(Canvas canvas, Offset position, Paint paint) {
    Path miniStarPath = Path();
    double outerRadius = 7;
    double innerRadius = 2;
    for (int i = 0; i < 10; i++) {
      double angle = pi / 5 * i;
      double radius = (i % 2 == 0) ? outerRadius : innerRadius;
      double x = position.dx + radius * cos(angle);
      double y = position.dy + radius * sin(angle);
      if (i == 0) {
        miniStarPath.moveTo(x, y);
      } else {
        miniStarPath.lineTo(x, y);
      }
    }
    miniStarPath.close();
    canvas.drawPath(miniStarPath, paint);
  }

  @override
  bool shouldRepaint(MagicBoardPainter oldDelegate) => true;
}
