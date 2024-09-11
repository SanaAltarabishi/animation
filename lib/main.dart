// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      home: BouncingBallAnimation(),
    );
  }
}

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _bounceAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut))
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);
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
        child: CustomPaint(
          size: const Size(300, 300),
          painter: BallPainter(progress: _bounceAnimation.value),
        ),
      ),
    );
  }
}

class BallPainter extends CustomPainter {
  final double progress;
  BallPainter({
    required this.progress,
  });
  @override
  void paint(Canvas canvas, Size size) {
    //Draw box:
    Paint boxPaint = Paint()..color = Colors.blueGrey[200]!;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), boxPaint);
    // Ball:
    Paint ballPaint = Paint()
      ..color = Color.lerp(
          Colors.orange, const Color.fromARGB(255, 86, 34, 255), progress)!;
    double ballRadius = 30.0;
    double ballx = size.width / 2;
    double ballY = size.height * progress;

    canvas.drawCircle(Offset(ballx, ballY - ballRadius), ballRadius, ballPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
