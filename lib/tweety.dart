import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class TweetyScreen extends StatefulWidget {
  const TweetyScreen({super.key});

  @override
  _TweetyScreenState createState() => _TweetyScreenState();
}

class _TweetyScreenState extends State<TweetyScreen>
    with SingleTickerProviderStateMixin {
  double eyeOffsetX = 0.0;
  double eyeOffsetY = 0.0;
  late AnimationController _controller;
  late List<SnowFlake> _snowflakes;

  @override
  void initState() {
    super.initState();

    accelerometerEventStream().listen((event) {
      setState(() {
        eyeOffsetX = (event.x * 5).clamp(-7.5, 7.5);
        eyeOffsetY = (-event.y * 5).clamp(-7.5, 7.5);
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    _snowflakes = List.generate(100, (index) => SnowFlake());

    _controller.addListener(() {
      setState(() {
        for (var snowflake in _snowflakes) {
          snowflake.update();
        }
      });
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
      backgroundColor: const Color.fromARGB(255, 198, 226, 247),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: SnowPainter(_snowflakes),
            ),
          ),
          Center(
            child: CustomPaint(
              size: const Size(200, 300),
              painter: TweetyPainter(eyeOffsetX, eyeOffsetY),
            ),
          ),
        ],
      ),
    );
  }
}

class SnowPainter extends CustomPainter {
  final List<SnowFlake> snowflakes;

  SnowPainter(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    Paint snowPaint = Paint()..color = Colors.white;

    for (var snowflake in snowflakes) {
      canvas.drawCircle(
          Offset(snowflake.x, snowflake.y), snowflake.size, snowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

//model :
class SnowFlake {
  double x, y, size, speed;
  static final Random random = Random();
  SnowFlake()
      : x = random.nextDouble() * 400,
        y = random.nextDouble() * 800,
        size = random.nextDouble() * 3 + 2,
        speed = random.nextDouble() * 2 + 1;

  void update() {
    y += speed;
    if (y > 800) {
      y = 0;
      x = random.nextDouble() * 400;
    }
  }
}

// tweety :
class TweetyPainter extends CustomPainter {
  final double eyeOffsetX;
  final double eyeOffsetY;

  TweetyPainter(this.eyeOffsetX, this.eyeOffsetY);

  @override
  void paint(Canvas canvas, Size size) {
    Paint yellowPaint = Paint()..color = Colors.yellow.shade300;
    Paint orangePaint = Paint()..color = Colors.orange;
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    // **Draw Head**
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(centerX, centerY - 50), width: 120, height: 120),
      yellowPaint,
    );

    // **Draw Body**
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX, centerY + 50), width: 180, height: 150),
        yellowPaint);

    // **Draw Eyes (White)**
    Paint eyeOffWhitePaint = Paint()
      ..color = Color.fromARGB(255, 239, 240, 233);
    double eyeSize = 40;
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX - 20, centerY - 60),
            width: 25,
            height: eyeSize),
        eyeOffWhitePaint);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX + 20, centerY - 60),
            width: 25,
            height: eyeSize),
        eyeOffWhitePaint);

    // **Draw Pupils (Black) – Moves with Phone Tilt**
    Paint eyeBlackPaint = Paint()..color = Colors.black;
    canvas.drawOval(
        Rect.fromCenter(
            center:
                Offset(centerX - 18 + eyeOffsetX, centerY - 55 + eyeOffsetY),
            width: 10,
            height: 20),
        eyeBlackPaint);
    canvas.drawOval(
        Rect.fromCenter(
            center:
                Offset(centerX + 18 + eyeOffsetX, centerY - 55 + eyeOffsetY),
            width: 10,
            height: 20),
        eyeBlackPaint);

    // **Draw Beak**
    Path beakPath = Path();
    beakPath.moveTo(centerX - 10, centerY - 30);
    beakPath.lineTo(centerX + 10, centerY - 30);
    beakPath.lineTo(centerX, centerY - 15);
    beakPath.close();
    canvas.drawPath(beakPath, orangePaint);

    // **Draw Feet**
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX - 25, centerY + 120), width: 40, height: 20),
        orangePaint);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX + 25, centerY + 120), width: 40, height: 20),
        orangePaint);
  }

  @override
  bool shouldRepaint(TweetyPainter oldDelegate) {
    return oldDelegate.eyeOffsetX != eyeOffsetX ||
        oldDelegate.eyeOffsetY != eyeOffsetY;
  }
}
