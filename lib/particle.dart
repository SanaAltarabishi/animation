import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  final Offset position;
  final Offset velocity;
  final Color color;
  final double size;

  Particle({required this.position})
      : velocity = Offset(
              (Random().nextDouble() - 0.5) * 2,
              (Random().nextDouble() - 0.5) * 2,
            ) *
            500,
        color = Color.fromARGB(
          255,
          Random().nextInt(256),
          Random().nextInt(256),
          Random().nextInt(256),
        ),
        size = Random().nextDouble() * 30 + 5;
}
