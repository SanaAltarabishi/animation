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
      home: SolarSystemScreen(),
    );
  }
}

class SolarSystemScreen extends StatefulWidget {
  const SolarSystemScreen({super.key});

  @override
  State<SolarSystemScreen> createState() => _SolarSystemScreenState();
}

class _SolarSystemScreenState extends State<SolarSystemScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: SolarSystemPainter(progress: _controller.value),
            );
          },
        ),
      ),
    );
  }
}

class SolarSystemPainter extends CustomPainter {
  final double progress;
  SolarSystemPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double sunRaduis = 40.0;

    Paint sunPaint = Paint()..color = Colors.yellow;
    // Draw the sun :
    canvas.drawCircle(center, sunRaduis, sunPaint);

    final planets = [
      PlanetData(radius: 80, color: Colors.red, speed: 1.5), // Mercury
      PlanetData(radius: 120, color: Colors.orange, speed: 1.2), // Venus
      PlanetData(radius: 160, color: Colors.blue, speed: 1.0), // Earth
      PlanetData(radius: 200, color: Colors.redAccent, speed: 0.8), // Mars
      PlanetData(
          radius: 260, color: Colors.yellowAccent, speed: 0.7), // Jupiter
    ];

    Offset calculatePlanetOffset({
      required Offset center,
      required double radius,
      required double angle,
    }) {
      return Offset(
          center.dx + radius * cos(angle), center.dy + radius * sin(angle));
    }

    for (var planet in planets) {
      final planetOffset = calculatePlanetOffset(
          center: center,
          radius: planet.radius,
          angle: 2 * pi * progress * planet.speed);

      Paint planetPaint = Paint()..color = planet.color;
      Paint orbitPaint = Paint()
        ..color = planet.color.withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      // Draw the planet:
      canvas.drawCircle(planetOffset, 12.0, planetPaint);
      // Draw the orbit
      canvas.drawCircle(center, planet.radius, orbitPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PlanetData {
  final double radius;
  final Color color;
  final double speed;
  PlanetData({
    required this.radius,
    required this.color,
    required this.speed,
  });
}
