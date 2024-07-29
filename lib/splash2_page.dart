import 'package:animated_splash/next_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CareemSplashPage extends StatefulWidget {
  const CareemSplashPage({super.key});

  @override
  State<CareemSplashPage> createState() => _CareemSplashPageState();
}

class _CareemSplashPageState extends State<CareemSplashPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _scaffoldColorAnimation;
  late Animation<double> _bikeOpacityAnimation;
  late Animation<double> _bikegrowAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _bikeMoveRightAnimation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

//scaffold color :
    _scaffoldColorAnimation =
        ColorTween(begin: const Color(0xff08B783), end: Colors.white)
            .animate(CurvedAnimation(
                parent: _animationController,
                curve: const Interval(
                  0.0,
                  0.4,
                )));
// bike opacity:
    _bikeOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.1, 0.2, curve: Curves.bounceInOut)));

    //bike grow:
    _bikegrowAnimation = Tween<double>(begin: 0.5, end: 1.1).animate(
        CurvedAnimation(
            parent: _animationController, curve: const Interval(0.2, 0.3)));

    //text disapear:
    _textOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
            parent: _animationController, curve:const Interval(0.2, 0.3)));
// bike move right :
_bikeMoveRightAnimation = Tween<Offset>(begin: Offset.zero,end:const Offset(10, 0)).animate(CurvedAnimation(parent: _animationController, curve:const Interval(0.3, 1)));
    Future.delayed(const Duration(milliseconds: 1600), _navigateToNextPage);
    _animationController.forward();
  }

  void _navigateToNextPage() {
    Navigator.of(context).pushReplacement(PageTransition(
      duration: const Duration(seconds: 1),
      type: PageTransitionType.leftToRight,
      child: const NextPage(),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _scaffoldColorAnimation,
        builder: (context, child) {
          return Container(
            color: _scaffoldColorAnimation.value,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position:_bikeMoveRightAnimation ,
                    child: ScaleTransition(
                      scale: _bikegrowAnimation,
                      child: AnimatedOpacity(
                          duration: const Duration(seconds: 0),
                          opacity: _bikeOpacityAnimation.value,
                          child: Image.asset('images/bike.png',
                              width: 100, height: 100)),
                    ),
                  ),
                  AnimatedOpacity(
                    duration:const Duration(seconds: 0),
                    opacity: _textOpacityAnimation.value,
                    child:const Text(
                      'CAREEM APP',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.green, offset: Offset(-3, 2))
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
