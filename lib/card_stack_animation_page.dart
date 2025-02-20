import 'dart:math';
import 'package:flutter/material.dart';
import 'package:card_stack_animation/card_widget.dart';

class CardStackAnimationPage extends StatefulWidget {
  const CardStackAnimationPage({super.key});

  @override
  _CardStackAnimationPageState createState() => _CardStackAnimationPageState();
}

class _CardStackAnimationPageState extends State<CardStackAnimationPage>
    with SingleTickerProviderStateMixin {
  List<Color> cardColors = [
    Colors.red.shade200,
    Colors.blue.shade200,
    Colors.green.shade200,
    Colors.orange.shade200,
    Colors.purple.shade200,
  ];

  late AnimationController _controller;
  late Animation<double> _jumpAnimation;
  late Animation<double> _rotationAnimation;
  // late Animation<double> _moveToBackAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _moveDownAnimation;

  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _jumpAnimation = Tween<double>(begin: 0, end: -300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeInOut),
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.7, curve: Curves.linear),
      ),
    );

    // _moveToBackAnimation = Tween<double>(begin: 0, end: -300).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Interval(0.5, 0.8, curve: Curves.easeInOut),
    //   ),
    // );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    _moveDownAnimation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _completeSwipe();
      }
    });
  }

  void _startSwipe() {
    if (isAnimating) return;
    setState(() => isAnimating = true);
    _controller.forward();
  }

  void _completeSwipe() {
    setState(() {
      isAnimating = false;
      _controller.reset();

      Color swipedCard = cardColors.removeLast();
      cardColors.insert(0, swipedCard);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 38, 38),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.12),
              child: Text(
                'CARDS',
                style: TextStyle(
                  fontSize: width * 0.1,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                      color: Colors.white70,
                      offset: Offset(-2, 2),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: width * 0.9,
                height: height * 0.4,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: cardColors.asMap().entries.map((entry) {
                    int index = entry.key;
                    Color color = entry.value;
                    bool isTopCard = index == cardColors.length - 1;

                    double scaleFactor = isTopCard
                        ? 1.0
                        : (1.0 - ((cardColors.length - 1 - index) * 0.04));

                    return Positioned(
                      bottom: index * -20.0 + 100,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002)
                          ..rotateX(index * 0.04),
                        alignment: Alignment.center,
                        child: isTopCard
                            ? GestureDetector(
                                onTap: _startSwipe,
                                onVerticalDragEnd: (details) {
                                  if (details.primaryVelocity! < -100) {
                                    _startSwipe();
                                  }
                                },
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    return SizedBox(
                                      width: width * 0.8,
                                      height: height * 0.2,
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..setEntry(3, 2, 0.002)
                                          // ..translate(
                                          //     0.0,
                                          //     0.0,
                                          //     (_moveToBackAnimation.value /
                                          //         100))
                                          ..scale(_scaleAnimation.value)
                                          ..scale(
                                            1.0 -
                                                (_moveDownAnimation.value /
                                                    100),
                                          ),
                                        child: Transform.translate(
                                          offset:
                                              Offset(0, _jumpAnimation.value),
                                          child: Transform.rotate(
                                            angle: _rotationAnimation.value,
                                            child: CardWidget(
                                              color: color,
                                              scaleFactor: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : CardWidget(
                                color: color,
                                scaleFactor: scaleFactor,
                              ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
