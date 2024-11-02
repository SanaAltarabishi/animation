// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class DownloadButtonAnimation extends StatefulWidget {
  const DownloadButtonAnimation({super.key});

  @override
  State<DownloadButtonAnimation> createState() =>
      _DownloadButtonAnimationState();
}

class _DownloadButtonAnimationState extends State<DownloadButtonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
//for width change:
  late final Animation<double> width =
      Tween<double>(begin: 250, end: 110).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.3, curve: Curves.fastOutSlowIn),
    ),
  );

//for fontSize change:
  late final Animation<double> fontSize =
      Tween<double>(begin: 30, end: 0).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.3, curve: Curves.fastOutSlowIn),
    ),
  );

//for opacity change:
  late final Animation opacity = TweenSequence(
    [
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 1).chain(
          CurveTween(curve: Curves.fastOutSlowIn),
        ),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0).chain(
          CurveTween(curve: Curves.fastOutSlowIn),
        ),
        weight: 50,
      ),
    ],
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.03, 0.5, curve: Curves.fastOutSlowIn),
    ),
  );

//for circle arc:
  late final Animation<double> arc =
      Tween<double>(begin: 0.0, end: 2 * pi).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.3, 0.8, curve: Curves.fastOutSlowIn),
    ),
  );
//for liner:
  Offset firstDot = const Offset(-15, 5);
  Offset firstCommon = const Offset(-5, 15);
  Offset secondDot = const Offset(20, -10);

  late final Animation<Offset> first =
      Tween<Offset>(begin: firstDot, end: firstCommon).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.9, 0.99, curve: Curves.fastOutSlowIn),
    ),
  );

  late final Animation<Offset> second =
      Tween<Offset>(begin: firstCommon, end: secondDot).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.9, 0.99, curve: Curves.fastOutSlowIn),
    ),
  );

// for animation center dot :

  late final Animation<Offset> centerDot =
      Tween<Offset>(begin: Offset.zero, end: firstDot).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.8, 0.9, curve: Curves.fastOutSlowIn),
    ),
  );

//for animationg dot size :
  late final Animation<double> dotSize =
      Tween<double>(begin: 8.0, end: 3.0).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.8, 0.9, curve: Curves.fastOutSlowIn),
    ),
  );

//for animationg dot opacity :
  late final Animation<double> dotOpacity =
      Tween<double>(begin: 0, end: 1.0).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.3, 0.3, curve: Curves.fastOutSlowIn),
    ),
  );

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            controller.forward();
          },
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width.value,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(
                        color: Colors.blue,
                        width: 5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Download',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize.value,
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: opacity.value,
                    child: const Icon(
                      Icons.arrow_downward,
                      size: 55,
                      color: Colors.black,
                    ),
                  ),
                  CustomPaint(
                    painter: ArcPaint(
                      startAngle: -pi / 2,
                      endAngle: arc.value,
                    ),
                  ),
                  CustomPaint(
                    painter: LinePaint(
                      first: first,
                      second: second,
                      firstDot: firstDot,
                      firstCommon: firstCommon,
                      secondDot: secondDot,
                    ),
                  ),
                  Opacity(
                    opacity: dotOpacity.value,
                    child: CustomPaint(
                      painter: DotPainter(
                        radius: dotSize.value,
                        offset: centerDot.value,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

//paint class :

class ArcPaint extends CustomPainter {
  final double startAngle;
  final double endAngle;
  ArcPaint({
    required this.startAngle,
    required this.endAngle,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset.zero;
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    final rect = Rect.fromCircle(center: center, radius: 40);

    canvas.drawArc(rect, startAngle, endAngle, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

//
class LinePaint extends CustomPainter {
  final Animation<Offset> first;
  final Animation<Offset> second;
  final Offset firstDot;
  final Offset firstCommon;
  final Offset secondDot;
  LinePaint({
    required this.first,
    required this.second,
    required this.firstDot,
    required this.firstCommon,
    required this.secondDot,
  });
  @override
  void paint(Canvas canvas, Size size) {
    double radius =3;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    if (first.value != firstDot) {
      canvas.drawCircle(firstDot, radius, paint);
    }
    canvas.drawLine(firstDot, first.value, paint);
    if (first.value != firstDot) {
      canvas.drawCircle(firstCommon, radius, paint);
    }
    canvas.drawLine(firstCommon, second.value, paint);
    if (second.value != firstCommon) {
      canvas.drawCircle(second.value, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

//
class DotPainter extends CustomPainter {
  final double radius;
  final Offset offset;
  DotPainter({
    required this.radius,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offset, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
