import 'package:flutter/material.dart';
import 'package:new_year/particle.dart';

class ParticleExplosionPainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticleExplosionPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paintOffset = Offset(
        particle.position.dx + particle.velocity.dx * progress,
        particle.position.dy + particle.velocity.dy * progress,
      );

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(Icons.star.codePoint),
          style: TextStyle(
            fontSize: particle.size,
            color: particle.color.withOpacity(1.0 - progress),
            fontFamily: Icons.star.fontFamily,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
          canvas, paintOffset - Offset(particle.size / 2, particle.size / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
