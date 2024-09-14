// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      home: ShapeMorphingProgressScreen(),
    );
  }
}

class ShapeMorphingProgressScreen extends StatefulWidget {
  const ShapeMorphingProgressScreen({super.key});

  @override
  State<ShapeMorphingProgressScreen> createState() =>
      _ShapeMorphingProgressScreenState();
}

class _ShapeMorphingProgressScreenState
    extends State<ShapeMorphingProgressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  _buildShape(progress),
            Transform.rotate(
              angle: 0,
              child: Container(
                width: 100 + progress * 100,
                height: 100 + progress * 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                  ]),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Slider(
              value: progress,
              onChanged: (value) {
                setState(
                  () {
                    progress = value;
                  },
                );
              },
              min: 0.0,
              max: 1.0,
            ),
            Text('Progress : ${(progress * 100).round()}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildShape(double progress) {
    if (progress <= 0.5) {
      return Transform.rotate(
        angle: 0,
        child: Container(
          width: 100 + progress * 100,
          height: 100 + progress * 100,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      );
    } else if (progress <= 0.75) {
      return Transform.rotate(
        angle: pi / 4,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
        ),
      );
    } else {
      return CustomPaint(
        size: const Size(100, 100),
        painter: TrianglePainter(progress: progress),
      );
    }
  }
}

class TrianglePainter extends CustomPainter {
  final double progress;
  TrianglePainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
