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
      home: ParticleExplosionScreen(),
    );
  }
}

class ParticleExplosionScreen extends StatefulWidget {
  const ParticleExplosionScreen({super.key});

  @override
  State<ParticleExplosionScreen> createState() =>
      _ParticleExplosionScreenState();
}

class _ParticleExplosionScreenState extends State<ParticleExplosionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final int particleCount = 100;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _triggerExplosion(Offset position) {
    _particles.clear();

    for (int i = 0; i < particleCount; i++) {
      _particles.add(Particle(position: position));
    }
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _triggerExplosion(details.localPosition);
      },
      child: Scaffold(
        backgroundColor: Colors.pink.shade100,
        body: CustomPaint(
          painter: ParticleExplosionPainter(
            progress: _controller.value,
            particles: _particles,
          ),
        ),
      ),
    );
  }
}

class ParticleExplosionPainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;
  ParticleExplosionPainter({
    required this.particles,
    required this.progress,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    for (var particle in particles) {
      paint.color = particle.color.withOpacity(1.0 - progress);
      final currentposition = Offset(
          particle.position.dx + particle.velocity.dx * progress,
          particle.position.dy + particle.velocity.dy * progress);
      canvas.drawCircle(
          currentposition, particle.radius * (1 - progress), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Particle {
  final Offset position;
  final Offset velocity;
  final Color color;
  final double radius;
  Particle({
    required this.position,
  })  : velocity = Offset((Random().nextDouble() - 0.5) * 2,
                (Random().nextDouble() - 0.5) * 2) *
            500,
        color = Color.fromARGB(225, Random().nextInt(256),
            Random().nextInt(256), Random().nextInt(256)),
        radius = Random().nextDouble() * 5 + 2;
}
