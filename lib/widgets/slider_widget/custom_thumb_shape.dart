import 'package:evaluate_slider_ex/core/resourses/strings.dart';
import 'package:flutter/material.dart';

class CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final String smileType;

  CustomThumbShape({this.thumbRadius = 20.0, required this.smileType});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint backgroundPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.grey
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, backgroundPaint);
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final Path path = Path();

    if (smileType == AppStrings.happy) {
      path.arcTo(
        Rect.fromCircle(center: center, radius: thumbRadius / 2.5),
        3.14,
        -3.14,
        false,
      );
    } else if (smileType == AppStrings.sad) {
      path.arcTo(
        Rect.fromCircle(center: center, radius: thumbRadius / 2.5),
        0.0,
        -3.14,
        false,
      );
    } else {
      path.moveTo(center.dx - thumbRadius / 2, center.dy);
      path.lineTo(center.dx + thumbRadius / 2, center.dy);
    }

    canvas.drawPath(path, paint);
  }
}
