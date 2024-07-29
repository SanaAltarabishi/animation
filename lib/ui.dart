import 'package:flutter/material.dart';

class SimpleUi extends StatefulWidget {
  const SimpleUi({super.key});

  @override
  State<SimpleUi> createState() => _SimpleUiState();
}

class _SimpleUiState extends State<SimpleUi> with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late Animation<Offset> _slideRightAnimation;
  late Animation<Offset> _slideLeftAnimation;
  late Animation<Offset> _slideBottonAnimation;
  @override
  void initState() {
    super.initState();
    _mainAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _slideRightAnimation =
        Tween<Offset>(begin: const Offset(100, 0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _mainAnimationController,
                curve: const Interval(0.0, 0.5, curve: Curves.bounceIn)));
    _slideLeftAnimation =
        Tween<Offset>(begin: const Offset(-10, 0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _mainAnimationController,
                curve: const Interval(0.0, 0.5, curve: Curves.bounceIn)));

    _slideBottonAnimation =
        Tween<Offset>(begin: const Offset(0, 50), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _mainAnimationController,
                curve: const Interval(0.0, 0.55, curve: Curves.bounceIn)));
    _mainAnimationController.forward();
  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 156, 185, 208),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SlideTransition(
                    position: _slideLeftAnimation,
                    child: SizedBox(
                      width: 130,
                      height:screenHeight*0.2,// 110,
                      child: Image.asset(
                        'images/cloud.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _slideRightAnimation,
                    child: Image.asset(
                      'images/cloud.png',
                      width: 100,
                      height:screenHeight*0.2,// 100,
                    ),
                  ),
                ],
              ),
              SlideTransition(
                position: _slideBottonAnimation,
                child: SizedBox(
                  width: 200,
                  child: Image.asset(
                    'images/sun.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height:screenHeight*0.65, //440,
              width: double.infinity,
              color: Color.fromARGB(255, 46, 75, 91),
              child: const Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'HAPPY DAY !!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height:screenHeight* 0.45,
              width: double.infinity,
              color: const Color.fromARGB(255, 37, 60, 77),
            ),
          ),
        ],
      ),
    );
  }
}
