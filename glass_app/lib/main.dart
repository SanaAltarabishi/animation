import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GlassOfLiquidDemo(),
    );
  }
}


class GlassOfLiquidDemo extends StatefulWidget {
  const GlassOfLiquidDemo({super.key});

  @override
  State<GlassOfLiquidDemo> createState() => _GlassOfLiquidDemoState();
}

class _GlassOfLiquidDemoState extends State<GlassOfLiquidDemo> {
  double skew = .2;
  double ratio = 0.7;
  double fullness = 0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              // ignore: sized_box_for_whitespace
              child: Container(
                width: 120,
                height: 180,
                child: CustomPaint(
                  painter: GlassOfLiquid(skew: skew, ratio: ratio, fullness),
                ),
              ),
            ),
          ),
          Slider(
            activeColor: Colors.black,
            value: skew,
            onChanged: (newVal) {
              setState(() {
                skew = newVal;
              });
            },
          ),
          Slider(
            activeColor: Colors.black,
            value: ratio,
            onChanged: (newVal) {
              setState(() {
                ratio = newVal;
              });
            },
          ),
          Slider(
            activeColor: Colors.black,
            value: fullness,
            onChanged: (newVal) {
              setState(() {
                fullness = newVal;
              });
            },
          ),
        ],
      ),
    );
  }
}

class GlassOfLiquid extends CustomPainter {
  final double skew;
  final double ratio; // how much the buttom smaller from the tap
  final double fullness;
  GlassOfLiquid(
    this.fullness, {
    required this.ratio,
    required this.skew,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // define the colors :
    Paint glass = Paint()
      ..color = Colors.white.withAlpha(150)
      ..style = PaintingStyle.fill;
    Paint milkTopPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Paint milkColor = Paint()
      ..color =const Color.fromARGB(255, 235, 235, 235)
      ..style = PaintingStyle.fill;
    Paint black = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    // the top and the buttom of the glass :
    Rect top = Rect.fromLTRB(0, 0, size.width, size.width * skew);
    // drawing the the top of the glass :

    Rect bottom = Rect.fromCenter(
        center: Offset(
            size.width * .5, size.height - size.width * 0.5 * skew * ratio),
        width: size.width * ratio,
        height: size.width * skew * ratio);

    dynamic liquidTop = Rect.lerp(bottom, top, fullness);
    // to draw the border of the cup from left and right :
    Path cupPath = Path()
      ..moveTo(top.left, top.top + top.height * .5)
      ..arcTo(top, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * 0.5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(top.left, top.top + top.height * .5);
    Path liquidPath = Path()
      ..moveTo(liquidTop.left, liquidTop.top + liquidTop.height * .5)
      ..arcTo(liquidTop, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * 0.5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(liquidTop.left, liquidTop.top + liquidTop.height * .5);

    canvas.drawOval(top, glass);
    canvas.drawOval(bottom, glass);
    canvas.drawPath(cupPath, glass);
    canvas.drawPath(liquidPath, milkColor);
    canvas.drawOval(liquidTop, milkTopPaint);
    canvas.drawPath(cupPath, black);
    canvas.drawOval(top, black);
  }

  @override
  bool shouldRepaint(GlassOfLiquid oldDelegate) {
    return oldDelegate.ratio != ratio ||
        oldDelegate.fullness != fullness ||
        oldDelegate.skew != skew;
  }
}
