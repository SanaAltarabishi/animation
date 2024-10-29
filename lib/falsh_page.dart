import 'dart:math';

import 'package:flutter/material.dart';

class FalshPage extends StatefulWidget {
  const FalshPage({super.key});

  @override
  State<FalshPage> createState() => _FalshPageState();
}

class _FalshPageState extends State<FalshPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _scaleAnimation;

  bool _isActivated = false;

  final int _particleCount = 20;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    // ..addListener(() {
    //     setState(() {});
    //   });

    _colorAnimation =
        ColorTween(begin: Colors.blue.shade700, end: Colors.purple.shade300)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _activeRelic() {
    if (_isActivated) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isActivated = !_isActivated;
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
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          //Background Gradient :
          AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: _isActivated ? 1.5 : 1.0,
                    colors: _isActivated
                        ? [Colors.black, _colorAnimation.value!]
                        : [Colors.black, Colors.blue.shade800],
                  ),
                ),
              );
            },
          ),

          // relic Glow and interaction :
          GestureDetector(
            onTap: _activeRelic,
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _colorAnimation.value,
                      boxShadow: [
                        BoxShadow(
                          color: _colorAnimation.value!.withOpacity(0.8),
                          blurRadius: _isActivated ? 30 : 10,
                          spreadRadius: _isActivated ? 15 : 5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //particle effect :
          if (_isActivated)
            ...List.generate(_particleCount, (index) => const Particle()),
        ],
      ),
    );
  }
}

class Particle extends StatefulWidget {
  const Particle({super.key});

  @override
  State<Particle> createState() => _ParticleState();
}

class _ParticleState extends State<Particle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _startX, _startY;
  late Color color;

  // late double _endX, _endY;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });

    _startX = Random().nextDouble() * 200 - 100;
    _startY = Random().nextDouble() * 200 - 100;
    color = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1.0,
    );
    // _endX = _startX * 1.5;
    // _endY = _startY * 1.5;
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
        double progress = _controller.value;

        return Positioned(
          left: MediaQuery.of(context).size.width / 2 + _startX * progress,
          top: MediaQuery.of(context).size.height / 2 + _startY * progress,
          child: Opacity(
            opacity: (1 - progress).clamp(0.0, 1.0),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}
