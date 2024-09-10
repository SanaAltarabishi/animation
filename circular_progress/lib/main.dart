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
      home: AnimatedCircularLoader(),
    );
  }
}

class AnimatedCircularLoader extends StatefulWidget {
  const AnimatedCircularLoader({super.key});

  @override
  State<AnimatedCircularLoader> createState() => _AnimatedCircularLoaderState();
}

class _AnimatedCircularLoaderState extends State<AnimatedCircularLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 0.0).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
  }

  void updateProgress(double newProgress) {
    _progressAnimation = Tween<double>(begin: _progress, end: newProgress)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward(from: 0.0);
    _progress = newProgress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 200),
            painter:
                CircluarProgressPainter(progress: _progressAnimation.value),
          ),
          const SizedBox(height: 50),
          Slider(
              min: 0,
              max: 100,
              value: _progress,
              onChanged: (newvalue) {
                updateProgress(newvalue);
              })
        ],
      ),
    );
  }
}

class CircluarProgressPainter extends CustomPainter {
  final double progress;
  CircluarProgressPainter({
    required this.progress,
  });
  @override
  void paint(Canvas canvas, Size size) {
    //circle paint:
    Paint circlePaint = Paint()
      ..strokeWidth = 10
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke;
    //progress paint :
    Paint progressPaint = Paint()
      ..strokeWidth = 10
      ..color = Color.lerp(Colors.blueGrey,
          const Color.fromARGB(255, 94, 44, 103), progress / 100)!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    //particles paint:
    Paint particlesPaint = Paint()..color = Colors.white;
    //Draw the background circle:
    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, circlePaint);
    // Draw progress :
    double sweepAngle = 2 * pi * (progress / 100);
    //?:This takes the progress (a percentage between 0 and 100) and converts it into a fraction of 1.
    // progress =50>> progress/100=0.5 >> half of the full circle
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        sweepAngle, false, progressPaint);

    // draw particles :
    for (int i = 0; i < 10; i++) {
      double angle = (2 * pi * i / 10) + (sweepAngle);
      //? the +(sweepAngel) gives the effect of rotational
      double particlex = center.dx + radius * cos(angle);
      double particleY = center.dy + radius * sin(angle);
      canvas.drawCircle(Offset(particlex, particleY), 4, particlesPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
