import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_year/particle.dart';
import 'package:new_year/particle_explosion_painter.dart';

class NewYearPage extends StatefulWidget {
  const NewYearPage({super.key});

  @override
  _NewYearPageState createState() => _NewYearPageState();
}

class _NewYearPageState extends State<NewYearPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide4;
  late Animation<Offset> _slide5;
  late Animation<Offset> _slideText;
  late Animation<double> _opacity4;
  late Animation<double> _opacity5;
  late Animation<Color?> _backgroundColor;

  final List<Particle> _particles = [];
  final int particleCount = 100;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _slide4 = Tween<Offset>(begin: Offset.zero, end: Offset(0, -5)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.2),
      ),
    );

    _slide5 = Tween<Offset>(begin: Offset(0, 5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3),
      ),
    );

    _slideText = Tween<Offset>(begin: Offset(-5, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.25, 0.4),
      ),
    );

    _opacity4 = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.2),
      ),
    );

    _opacity5 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.4),
      ),
    );

    _backgroundColor = ColorTween(
      begin: Colors.black,
      end: const Color.fromARGB(255, 155, 196, 187),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    for (int i = 0; i < particleCount; i++) {
      _particles.add(
        Particle(
          position: Offset(
            Random().nextDouble() *
                MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .width,
            Random().nextDouble() *
                MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .height,
          ),
        ),
      );
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _backgroundColor.value,
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "2 0 2 ",
                          style: TextStyle(
                            fontSize: 100,
                            fontFamily: 'RubikVinyl',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // "4" Exiting
                            SlideTransition(
                              position: _slide4,
                              child: Opacity(
                                opacity: _opacity4.value,
                                child: Text(
                                  "4",
                                  style: TextStyle(
                                    fontSize: 100,
                                    fontFamily: 'RubikVinyl',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            // "5" Entering
                            SlideTransition(
                              position: _slide5,
                              child: Opacity(
                                opacity: _opacity5.value, //_controller.value,
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                    fontSize: 100,
                                    fontFamily: 'RubikVinyl',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SlideTransition(
                    position: _slideText,
                    child: Opacity(
                      opacity: _controller.value,
                      child: Text(
                        'The Year of Brilliance',
                        style: TextStyle(
                          shadows: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                          fontSize: 30,
                          fontFamily: 'RubikVinyl',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_controller.value > 0.4)
                CustomPaint(
                  painter: ParticleExplosionPainter(
                    particles: _particles,
                    progress: max(
                      0.0,
                      min(1.0, (_controller.value - 0.4) / 0.4),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
