import 'package:flutter/material.dart';

class HeroExample extends StatelessWidget {
  const HeroExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HeroDetailsPage(),
              ),
            );
          },
          child: Hero(
            tag: 'hero-shape',
            child: ClipOval(
              child: Container(
                color: Colors.brown,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroDetailsPage extends StatelessWidget {
  const HeroDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'hero-shape',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.brown,
              width: 300,
              height: 300,
            ),
          ),
        ),
      ),
    );
  }
}
