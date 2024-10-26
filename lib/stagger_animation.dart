import 'package:flutter/material.dart';

enum AnimProps {
  opacity,
  width,
  height,
  padding,
  borderRadius,
  color,
}

class StaggerAnimationPage extends StatefulWidget {
  const StaggerAnimationPage({super.key});

  @override
  State<StaggerAnimationPage> createState() => _StaggerAnimationPageState();
}

class _StaggerAnimationPageState extends State<StaggerAnimationPage>
    with SingleTickerProviderStateMixin {
   late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _widthAnimation;
  late Animation<double> _heightAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration:const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );

    _widthAnimation = Tween<double>(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.5, curve: Curves.easeInOut),
      ),
    );

    _heightAnimation = Tween<double>(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeInOut),
      ),
    );

    _colorAnimation = ColorTween(begin: Colors.blue, end: const Color.fromARGB(255, 179, 24, 158)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
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
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                width: _widthAnimation.value,
                height: _heightAnimation.value,
                color: _colorAnimation.value,
              ),
            );
          },
        ),
      ),
    );
  }
}