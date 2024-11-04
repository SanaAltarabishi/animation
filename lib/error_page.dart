import 'package:custom_transition/hover_effect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Flutter404Animation extends StatefulWidget {
  const Flutter404Animation({super.key});

  @override
  State<Flutter404Animation> createState() => _Flutter404AnimationState();
}

class _Flutter404AnimationState extends State<Flutter404Animation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _animationController.forward();
          }
        },
      );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor:context.watch<ColorPaletteState>().selectedColor.color,
      // const Color.fromARGB(255, 116, 46, 128),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 46, 128),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: height / 4.4,
            right: height / 20,
            child: AnimatedBuilder(
              animation: _animationController,
              child: Image.asset(
                'assets/light.png',
                height: height * 1.3,
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: -_animationController.value,
                  alignment: Alignment.bottomCenter,
                  child: child,
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: height / 2.7,
            child: Image.asset(
              'assets/source.png',
              width: height / 4.6,
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "404",
                  style: TextStyle(
                    fontSize: height / 5,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 116, 46, 128),
                  ),
                ),
                Text(
                  "Page Not Found",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: height * 0.05,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 116, 46, 128),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
