import 'package:flutter/material.dart';

class CustomTrackShape extends SliderTrackShape {
 final Color cicleColor;
  CustomTrackShape({
    required this.cicleColor,
  });
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 10;
    final double trackLeft = offset.dx +
        sliderTheme.overlayShape!
                .getPreferredSize(isEnabled, isDiscrete)
                .width /
            2;
    final double trackWidth = parentBox.size.width -
        sliderTheme.overlayShape!.getPreferredSize(isEnabled, isDiscrete).width;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    Offset? secondaryOffset,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Canvas canvas = context.canvas;

    final Paint trackPaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.fill;

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    canvas.drawRect(trackRect, trackPaint);

    const double circleRadius = 10;
    final Paint circlePaint = Paint()
      ..color =cicleColor
      ..style = PaintingStyle.fill;

    final double startCircle = trackRect.left;
    final double middleCircle = trackRect.center.dx;
    final double endCircle = trackRect.right;

    canvas.drawCircle(
        Offset(startCircle, trackRect.center.dy), circleRadius, circlePaint);
    canvas.drawCircle(
        Offset(middleCircle, trackRect.center.dy), circleRadius, circlePaint);
    canvas.drawCircle(
        Offset(endCircle, trackRect.center.dy), circleRadius, circlePaint);
  }
}
