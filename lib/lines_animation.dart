import 'dart:math';

import 'package:flutter/material.dart';

class WindyLines extends StatefulWidget {
  const WindyLines({super.key});

  @override
  State<WindyLines> createState() => _WindyLinesState();
}

class _WindyLinesState extends State<WindyLines> with TickerProviderStateMixin {
  static const double initialHeight = 450.0;
  static const double maxHeightChange = 10.0;
  static const double maxOffsetChange = 200.0;
  static const int lineCount = 40;
  Offset _lastMousePosition = Offset.zero;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _heightAnimations;
  late List<Animation<Offset>> _offsetAnimations;
  late List<double> _targetHeights;
  //  List.generate(lineCount, (_) => initialHeight);
  final List<Offset> _targetOffset =
      List.generate(lineCount, (_) => Offset.zero);

  // final Random _random = Random();

  @override
  void initState() {
    super.initState();

    final random = Random();
    _targetHeights =
        List.generate(lineCount, (_) => random.nextDouble() * initialHeight);

    _controllers = List.generate(
      lineCount,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      ),
    );

    _heightAnimations = List.generate(
      lineCount,
      (i) => Tween<double>(begin: _targetHeights[i], end: _targetHeights[i]).animate(
        CurvedAnimation(parent: _controllers[i], curve: Curves.easeOut),
      ),
    );

    _offsetAnimations = List.generate(
      lineCount,
      (i) => Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(
        CurvedAnimation(parent: _controllers[i], curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

 void _updateLine(int index, PointerEvent event) {
  final screenWidth = MediaQuery.sizeOf(context).width;
  final screenHeight = MediaQuery.sizeOf(context).height;

  double dxDirection = (event.position.dx > _lastMousePosition.dx) ? 1 : -1;

  // Calculate the change factor based on mouse Y-position and the screen height
  final dyFactor = ((screenHeight - event.position.dy) / screenHeight);

  // Update the target height based on each line's unique initial height in _targetHeights
  _targetHeights[index] = _targetHeights[index] + (dyFactor * maxHeightChange);

  // Calculate the horizontal offset based on mouse X-position and screen width
  final dx = dxDirection * ((event.position.dx - screenWidth / 2) / (screenWidth / 2)) * maxOffsetChange;
  _targetOffset[index] = Offset(dx, 0);

  // Animate height change based on each line’s unique height
  _heightAnimations[index] = Tween<double>(
          begin: _heightAnimations[index].value, end: _targetHeights[index])
      .animate(
    CurvedAnimation(parent: _controllers[index], curve: Curves.easeOut),
  );

  _offsetAnimations[index] = Tween<Offset>(
          begin: _offsetAnimations[index].value, end: _targetOffset[index])
      .animate(
    CurvedAnimation(parent: _controllers[index], curve: Curves.easeOut),
  );

  // Trigger the animation
  _controllers[index].forward(from: 0);
}


  void _resetLine(int index) {
    if (_controllers[index].isAnimating) return; // Prevent overlapping resets

    _heightAnimations[index] = Tween<double>(
      begin: _heightAnimations[index].value,
      end: initialHeight,
    ).animate(
      CurvedAnimation(parent: _controllers[index], curve: Curves.easeOut),
    );

    _offsetAnimations[index] = Tween<Offset>(
      begin: _offsetAnimations[index].value,
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _controllers[index], curve: Curves.easeOut));

    _controllers[index].forward(from: 0).whenComplete(() {
      print("Line $index reset complete");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: List.generate(lineCount, (index) {
            return Positioned(
              left: 20.0 * index,
              child: MouseRegion(
                onHover: (event) => _updateLine(index, event),
                onEnter: (event) => _resetLine(index),
                child: AnimatedBuilder(
                  animation: _controllers[index],
                  builder: (context, child) {
                    return CustomPaint(
                      painter: LinePainter(
                        lineHeight: _heightAnimations[index].value,
                        offset: _offsetAnimations[index].value,
                        color: Colors.grey,
                        circleColor: Colors.yellowAccent,
                      ),
                      size: const Size(50, initialHeight),
                    );
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final double lineHeight;
  final Offset offset;
  final Color color;
  final Color circleColor;

  LinePainter({
    required this.lineHeight,
    required this.offset,
    required this.color,
    required this.circleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    final circlePaint = Paint()..color = circleColor;

    final startPoint = Offset(size.width / 2, 0);
    final lineEnd = Offset(
      startPoint.dx + offset.dx,
      lineHeight + offset.dy,
    );

    // Draw the line
    canvas.drawLine(startPoint, lineEnd, linePaint);

    // Draw the circle at the end of the line
    canvas.drawCircle(lineEnd, 5, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
