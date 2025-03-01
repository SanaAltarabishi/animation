import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HangingBillboardScreen extends StatefulWidget {
  const HangingBillboardScreen({super.key});

  @override
  _HangingBillboardScreenState createState() => _HangingBillboardScreenState();
}

class _HangingBillboardScreenState extends State<HangingBillboardScreen> {
  double angle = 0.0; // Rotation angle of the billboard
  double offsetX = 0.0; // Horizontal movement effect

  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((event) {
      setState(() {
        offsetX = event.x * 2; // Tilt effect based on phone movement
        angle = event.x * 0.04; // Rotation effect
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double lineWidth = screenWidth * 0.5;
    double billboardWidth = screenWidth * 0.7;
    double billboardHeight = 100;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double topY = screenHeight * 0.2; // Start of the ropes

    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: RopePainter(offsetX, lineWidth, topY),
            ),
          ),

          // Billboard (Text Container)
          Positioned(
            top: topY + 150, // Adjust billboard position
            left:
                (screenWidth - billboardWidth) / 2 + offsetX, // Adjust for tilt
            child: Transform.rotate(
              angle: angle, // Tilt effect
              child: Container(
                width: billboardWidth,
                height: billboardHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
                ),
                alignment: Alignment.center,
                child: Text(
                  "Ramadan Mubarak",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🎨 Draws the ropes from the top of the screen to the billboard
class RopePainter extends CustomPainter {
  final double offsetX;
  final double billboardWidth;
  final double topY;
  RopePainter(this.offsetX, this.billboardWidth, this.topY);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4;

    double leftX = size.width / 2 - billboardWidth / 2 + offsetX;
    double rightX = size.width / 2 + billboardWidth / 2 + offsetX;
    double bottomY = topY + 200; // Billboard top position

    // Draw ropes from top of screen to the top corners of the billboard
    canvas.drawLine(
        Offset(size.width / 2 - 100, 0), Offset(leftX, bottomY), paint);
    canvas.drawLine(
        Offset(size.width / 2 + 100, 0), Offset(rightX, bottomY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
