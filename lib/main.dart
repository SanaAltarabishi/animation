import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DevLens',
      debugShowCheckedModeBanner: false,
      home: MagnifierEffect(),
    );
  }
}

class MagnifierEffect extends StatefulWidget {
  const MagnifierEffect({super.key});

  @override
  State<MagnifierEffect> createState() => _MagnifierEffectState();
}

class _MagnifierEffectState extends State<MagnifierEffect> {
  Offset? _mousePosition;
  final double _magnifierRadius = 150;
  Size? _imageSize;
  Offset? _imageOffset;
  ui.Image? _darkImage;

  @override
  void initState() {
    super.initState();
    _loadDarkImage();
  }

  Future<void> _loadDarkImage() async {
    final data = await DefaultAssetBundle.of(
      context,
    ).load('assets/images/dev.png');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      _darkImage = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,

      body: LayoutBuilder(
        builder: (context, constraints) {
          return MouseRegion(
            onHover: (event) {
              setState(() {
                _mousePosition = event.position; // حفظ موقع المؤشر
              });
            },
            onExit: (event) {
              setState(() {
                _mousePosition = null; // إخفاء العدسة عند الخروج
              });
            },
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // بعد أن تُرسم الصورة، نأخذ قياساتها
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final renderBox =
                              context.findRenderObject() as RenderBox?;
                          if (renderBox != null) {
                            _imageSize = renderBox.size;

                            _imageOffset = renderBox.localToGlobal(Offset.zero);
                          }
                        });

                        return Image.asset(
                          'assets/images/colorful_dev.png',
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),

                  // if (_mousePosition != null)
                  //   Positioned(
                  //     left: _mousePosition!.dx - _magnifierRadius,
                  //     top: _mousePosition!.dy - _magnifierRadius,

                  //     child: ClipOval(
                  //       child: SizedBox(
                  //         width: _magnifierRadius * 2,
                  //         height: _magnifierRadius * 2,

                  //         child: Image.asset(
                  //           'assets/images/dev.png',
                  //           fit: BoxFit.fill,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  if (_mousePosition != null &&
                      _imageSize != null &&
                      _imageOffset != null)
                    CustomPaint(
                      painter: MagnifierPainter(
                        darkImage: _darkImage,
                        mousePosition: _mousePosition!,
                        magnifierRadius: _magnifierRadius,
                        imageSize: _imageSize!,
                        imageOffset: _imageOffset!,
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

//_______________________________
class MagnifierPainter extends CustomPainter {
  final Offset mousePosition;
  final double magnifierRadius;
  final Size imageSize;
  final Offset imageOffset;
  final ui.Image? darkImage;

  MagnifierPainter({
    required this.mousePosition,
    required this.magnifierRadius,
    required this.imageSize,
    required this.imageOffset,
    required this.darkImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final localX = mousePosition.dx - imageOffset.dx;
    final localY = mousePosition.dy - imageOffset.dy;

    if (localX < 0 ||
        localX > imageSize.width ||
        localY < 0 ||
        localY > imageSize.height) {
      return;
    }


    canvas.save();
    final circlePath = Path()
      ..addOval(
        Rect.fromCircle(center: mousePosition, radius: magnifierRadius),
      );
    canvas.clipPath(circlePath);


    if (darkImage != null) {
      final srcRect = Rect.fromLTWH(
        0,
        0,
        darkImage!.width.toDouble(),
        darkImage!.height.toDouble(),
      );
      final dstRect = Rect.fromLTWH(
        imageOffset.dx,
        imageOffset.dy,
        imageSize.width,
        imageSize.height,
      );

      canvas.drawImageRect(darkImage!, srcRect, dstRect, Paint());
    }

    canvas.restore();
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(mousePosition, magnifierRadius, borderPaint);
  }

  @override
  bool shouldRepaint(MagnifierPainter oldDelegate) => true;
}
