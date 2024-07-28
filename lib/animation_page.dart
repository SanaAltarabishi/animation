import 'package:flutter/material.dart';

class AnimationUiPage extends StatefulWidget {
  const AnimationUiPage({super.key});

  @override
  State<AnimationUiPage> createState() => _AnimationUiPageState();
}

class _AnimationUiPageState extends State<AnimationUiPage>
    with TickerProviderStateMixin {
  late Animation<Offset> _slideAnimation;
  late AnimationController _mainController;
  late Animation<double> _flipAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _moveUpAnimation;
  late Animation<Offset> _slideButtonAnimation;
  @override
  void initState() {
    _mainController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _mainController,
                curve: const Interval(0.0, 0.1, curve: Curves.easeOut)));

    _flipAnimation = Tween<double>(begin: 0, end: 3.14).animate(CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.15, 0.25, curve: Curves.easeInOut)));

    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.45, curve: Curves.easeInOut)));

    _moveUpAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.4)).animate(
            CurvedAnimation(
                parent: _mainController,
                curve: const Interval(0.5, 0.65, curve: Curves.easeInCubic)));

    _slideButtonAnimation =
        Tween<Offset>(begin: const Offset(0, 15), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: _mainController,
                curve: const Interval(0.5, 0.65, curve: Curves.easeInCubic)));
    // _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
    //     CurvedAnimation(parent: _buttonController, curve: Curves.easeIn));
    _mainController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _mainController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Color.fromARGB(255, 177, 217, 250)],
          ),
        ),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SlideTransition(
                position: _slideAnimation,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.rotationY(_flipAnimation.value),
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: SlideTransition(
                      position: _moveUpAnimation,
                      child: Image.asset(
                        'images/wheel.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                )),
            SlideTransition(
              position: _slideButtonAnimation,
              child: Column(
                children: [
                  const Text(
                    'Animation ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    'trying to make this animation ....',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Button 1",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Button 2",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
