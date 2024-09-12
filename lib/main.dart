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
      home: CardFlipScreen(),
    );
  }
}

class CardFlipScreen extends StatefulWidget {
  const CardFlipScreen({super.key});

  @override
  State<CardFlipScreen> createState() => _CardFlipScreenState();
}

class _CardFlipScreenState extends State<CardFlipScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _flipCard() {
    setState(() {
      if (_isFront) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _isFront = !_isFront;
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
      backgroundColor: const Color.fromARGB(255, 23, 62, 81),
      body: Center(
        child: GestureDetector(
          onTap: _flipCard,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double angle = _animation.value * 3.14;
              return Transform(
                transform: Matrix4.rotationY(angle),
                alignment: Alignment.center,
                child: _isFront ? _buildFrontCard() : _buildBackCard(angle),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10),
          ]),
      child: const Center(
        child: Text('fornt side'),
      ),
    );
  }

  Widget _buildBackCard(double angle) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10),
          ]),
      child: Align(
        alignment: Alignment.center,
        child: Transform(
          alignment: Alignment.center,
            transform: Matrix4.rotationY(angle),
            child: const Text('back side')),
      ),
    );
  }
}
