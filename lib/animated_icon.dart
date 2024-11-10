import 'package:flutter/material.dart';

class AnimatedIconExample extends StatefulWidget {
  const AnimatedIconExample({super.key});

  @override
  State<AnimatedIconExample> createState() => _AnimatedIconExampleState();
}

class _AnimatedIconExampleState extends State<AnimatedIconExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isIconOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleIcon() {
    setState(() {
      if (_isIconOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isIconOpen = !_isIconOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "AnimatedIcon Widget",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 106, 129),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 106, 129),
      body: Center(
        child: IconButton(
          iconSize: 60,
          onPressed: _toggleIcon,
          icon: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: _controller,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
