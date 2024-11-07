import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({super.key});

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 40,
            spawnMinRadius: 15,
            particleCount: 75,
            spawnMinSpeed: 5,
            spawnMaxSpeed: 25,
           spawnOpacity: 0.8,
            baseColor: Colors.blueGrey,
            image: Image(
              image: AssetImage(
                'assets/star.png',
              ),
            ),
          ),
        ),
        vsync: this,
        child: const Center(
          child: Text(
            'Animated Background',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
