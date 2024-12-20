import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';
import 'package:flutter/material.dart';

class CustomMouthWidget extends StatelessWidget {
  final SliderNotifier sliderNotifier;
  const CustomMouthWidget({
    super.key,
    required this.sliderNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight*0.04,//50,
      child: CustomPaint(
        painter: _MouthPainter(
          thumbRadius: 60,
          smileType: sliderNotifier.currentState.smileType,
          smileColor: sliderNotifier.currentState.detailsColor,
        ),
      ),
    );
  }
}

class _MouthPainter extends CustomPainter {
  final double thumbRadius;
  final String smileType;
  final Color smileColor;

  _MouthPainter({
    required this.smileColor,
    required this.thumbRadius,
    required this.smileType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = smileColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    final Path path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    if (smileType == 'happy') {
      path.arcTo(
        Rect.fromCircle(center: center, radius: thumbRadius / 2.5),
        2.6,
        -3.14,
        false,
      );
    } else if (smileType == 'sad') {
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

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
