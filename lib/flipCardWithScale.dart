import 'package:flutter/material.dart';

class CardFlipWithScale extends StatefulWidget {
  const CardFlipWithScale({super.key});

  @override
  State<CardFlipWithScale> createState() => _CardFlipWithScaleState();
}

class _CardFlipWithScaleState extends State<CardFlipWithScale>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _flipped = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleCard() {
    setState(() {
      _flipped = !_flipped;
      if (_flipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 62, 81),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _toggleCard,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double angle = _animation.value * 3.14;
              final scale = 1 + _animation.value * 0.1;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.005)
                  ..rotateY(angle)
                  ..scale(scale),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                        )
                      ]),
                  child: Center(
                      child: _flipped
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(angle),
                              child: const Text('Back Side'))
                          : const Text('fornt side ')),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
