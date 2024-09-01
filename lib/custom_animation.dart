import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_ui/socialShareIcon.dart';

class CustomAnimation extends StatefulWidget {
  const CustomAnimation({super.key});

  @override
  State<CustomAnimation> createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _alignAnimation;
  late Animation<double> _borderRaduisAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _iconRotateAnimation;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    final CurveAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.ease);

    _scaleAnimation = Tween(begin: 59.0, end: 200.0).animate(CurveAnimation);
    _alignAnimation = Tween(begin: 0.0, end: -1.0).animate(CurveAnimation);
    _borderRaduisAnimation =
        Tween(begin: 100.0, end: 15.0).animate(CurveAnimation);
    _iconScaleAnimation = Tween(begin: 0.0, end: 30.0).animate(CurveAnimation);
    _iconRotateAnimation = Tween(begin: 0.0, end: pi).animate(CurveAnimation);
  }

  void toggleMenu() {
    setState(
      () {
        if (isOpen) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
        isOpen = !isOpen;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Container(
         // color: Colors.yellow,
          height: 235,
          width: 200,
          child: Stack(
            children: [
              _buildAnimationContainer(),
              _buildMenuIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimationContainer() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Align(
          alignment: Alignment(_alignAnimation.value, _alignAnimation.value),
          child: Container(
            height: _scaleAnimation.value,
            width: _scaleAnimation.value,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_borderRaduisAnimation.value),
            ),
            child: child,
          ),
        );
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SeveralIcon(
              title: 'star',
              icon: Icons.star,
              color: const Color.fromARGB(181, 90, 84, 32),
              isOpen: isOpen,
              index: 1,
            ),
            SeveralIcon(
              title: 'favorite',
              icon: Icons.favorite,
              color: Colors.red.shade200,
              isOpen: isOpen,
              index: 2,
            ),
            SeveralIcon(
              title: 'snow',
              icon: Icons.ac_unit_sharp,
              color: Colors.blue.shade200,
              isOpen: isOpen,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

//menu icon:

  Widget _buildMenuIcon() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Align(
          alignment:
              Alignment(_animationController.value, _animationController.value),
          child: InkWell(
            onTap: () {
              toggleMenu();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: _iconRotateAnimation.value,
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                    size: _iconScaleAnimation.value,
                  ),
                ),
                if (_animationController.isDismissed)
                  const Icon(
                    Icons.menu,
                    size: 40,
                    color: Colors.black,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
