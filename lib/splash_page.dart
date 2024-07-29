import 'package:animated_splash/next_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late Animation<Color?> _colorAnimation;
 // late Animation<double> _depthOpacityAnimation;
  late Animation<double> _bikeOpacityAnimation;
  late Animation<Offset> _moveUpAnimation;
  late Animation<double> _bikeGrowAnimation;
  late Animation<Offset> _moveleftAnimation;
  late Animation<double> _bikeShrinkAnimation;
  late Animation<Offset> _movedownAnimation;
  late Animation<Offset> _slideTextAnimation;
  late Animation<Offset> _moverightAnimation;
  late Animation<double> _textShrinkAnimation;
  @override
  void initState() {
    super.initState();
//controller:
    _mainAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
//depth opacity
    // _depthOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
    //     CurvedAnimation(
    //         parent: _mainAnimationController,
    //         curve: const Interval(0.0, 0.2, curve: Curves.linear)));
    //scaffold color
    _colorAnimation =
        ColorTween(begin: Colors.white, end: const Color(0xff08B783)).animate(
            CurvedAnimation(
                parent: _mainAnimationController,
                curve: const Interval(0.35, 1, curve: Curves.linear)));
//bike opacity:
    _bikeOpacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: _mainAnimationController,
        curve: const Interval(0.0, 0.2, curve: Curves.bounceInOut)));
// bike move up :
    _moveUpAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
            CurvedAnimation(
                parent: _mainAnimationController,
                curve: const Interval(0.2, 0.4, curve: Curves.easeInOut)));

// bike scale (grow):
    _bikeGrowAnimation = Tween<double>(begin: 0.7, end: 1).animate(
        CurvedAnimation(
            parent: _mainAnimationController,
            curve: const Interval(0.4, 0.6, curve: Curves.easeInOut)));
    //moveleft :
    _moveleftAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0)).animate(
            CurvedAnimation(
                parent: _mainAnimationController,
                curve: const Interval(0.6, 0.7, curve: Curves.linear)));
    //bike scale (shrink)
    _bikeShrinkAnimation = Tween<double>(begin: 1, end: 0.8).animate(
        CurvedAnimation(
            parent: _mainAnimationController,
            curve: const Interval(0.7, 0.8, curve: Curves.linear)));
//move down :
    _movedownAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1)).animate(
            CurvedAnimation(
                parent: _mainAnimationController,
                curve: const Interval(0.8, 0.9, curve: Curves.linear)));
    //text appears :
    _slideTextAnimation =
        Tween<Offset>(begin: const Offset(100, 0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _mainAnimationController,
                curve: const Interval(0.8, 0.9, curve: Curves.linear)));
//bike move right:
    _moverightAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(5, 0)).animate(
            CurvedAnimation(
                parent: _mainAnimationController,
                curve: const Interval(0.9, 1, curve: Curves.linear)));
//text disapears:
    _textShrinkAnimation = Tween<double>(begin: 1, end: 0.0).animate(
        CurvedAnimation(
            parent: _mainAnimationController,
            curve: const Interval(0.9, 1, curve: Curves.linear)));
    _mainAnimationController.forward();
    Future.delayed(const Duration(seconds: 4), _navigateToNextPage);
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
    _mainAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Container(
            color: _colorAnimation.value,
            child: Stack(
              children: [
                // Align(
                //     alignment: Alignment.center,
                //     child: AnimatedOpacity(
                //       duration: const Duration(milliseconds: 10),
                //       opacity: _depthOpacityAnimation.value,
                //       child: Container(
                //         width: 120,
                //         height: 80,
                //         decoration: BoxDecoration(
                //         //  boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2,offset: Offset(0, -2))],
                //             color: const Color(0xff08B783),
                //             borderRadius: BorderRadius.circular(50)),
                //       ),
                //     )),
                Align(
                  alignment: Alignment.center,
                  child: SlideTransition(
                    position: _moverightAnimation,
                    child: SlideTransition(
                      position: _movedownAnimation,
                      child: ScaleTransition(
                        scale: _bikeShrinkAnimation,
                        child: SlideTransition(
                          position: _moveleftAnimation,
                          child: ScaleTransition(
                            scale: _bikeGrowAnimation,
                            child: SlideTransition(
                              position: _moveUpAnimation,
                              child: AnimatedOpacity(
                                duration: const Duration(seconds: 1),
                                opacity: _bikeOpacityAnimation.value,
                                child: Image.asset(
                                  'images/bike.png',
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.3, 0.05),
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 0),
                    opacity: _textShrinkAnimation.value,
                    child: SlideTransition(
                      position: _slideTextAnimation,
                      child: const Text(
                        'CAREEM APP',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(color: Colors.grey, offset: Offset(-1, -1))
                            ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
