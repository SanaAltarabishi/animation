import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagneticCircleScreen extends StatefulWidget {
  const MagneticCircleScreen({super.key});

  @override
  _MagneticCircleScreenState createState() => _MagneticCircleScreenState();
}

class _MagneticCircleScreenState extends State<MagneticCircleScreen>
    with SingleTickerProviderStateMixin {
  double offsetY = 0.0;
  double lastOffset = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Setup the animation curve
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // Listen to accelerometer events
    accelerometerEvents.listen((event) {
      double newOffsetY = event.y * 10; // Adjust sensitivity

      // Check if the new offset is significantly different from the last one
      if ((newOffsetY - lastOffset).abs() > 0.1) {
        // Update the offset and set the controller to play the animation
        setState(() {
          offsetY = newOffsetY;
          lastOffset = newOffsetY; // Update the last offset
        });

        // Trigger animation if not already playing
        if (!_controller.isAnimating) {
          _controller.forward(from: 0);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double centerY = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            double animatedOffset = offsetY * _animation.value * 2;

            return CustomPaint(
              size: Size(200, 400), // حجم المساحة التي سيتم الرسم فيها
              painter: MagneticPainter(animatedOffset),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MagneticPainter extends CustomPainter {
  final double offsetY;
  MagneticPainter(this.offsetY);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blueAccent;

    double circleRadius = 50;
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    // رسم الدائرة الثابتة (المغناطيس)
    canvas.drawCircle(Offset(centerX, centerY), circleRadius, paint);

    // رسم تأثير التمدد للدائرة المتحركة
    Path path = Path();

    // تحديد موقع الدائرة المتحركة
    double movingCircleY = centerY + offsetY;
    double stretchFactor =
        (offsetY.abs() / 50).clamp(0, 1); // للتحكم في الامتداد

    // نقطة البداية (الدائرة الثابتة)
    path.moveTo(centerX - circleRadius, centerY);
    path.arcToPoint(Offset(centerX + circleRadius, centerY),
        radius: Radius.circular(circleRadius));

    // رسم الامتداد المنحني بين الدائرتين (تأثير السحب المغناطيسي)
    path.quadraticBezierTo(centerX, centerY + (offsetY / 2),
        centerX + circleRadius, movingCircleY);

    path.arcToPoint(Offset(centerX - circleRadius, movingCircleY),
        radius: Radius.circular(circleRadius));

    path.quadraticBezierTo(
        centerX, centerY + (offsetY / 2), centerX - circleRadius, centerY);

    canvas.drawPath(path, paint);

    // رسم الدائرة المتحركة
    paint.color = Colors.redAccent;
    canvas.drawCircle(Offset(centerX, movingCircleY), circleRadius, paint);
  }

  @override
  bool shouldRepaint(MagneticPainter oldDelegate) {
    return oldDelegate.offsetY != offsetY;
  }
}
