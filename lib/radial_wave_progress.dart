import 'package:flutter/material.dart';
import 'dart:math';

class Radial extends StatelessWidget {
  const Radial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Automatic Radial Progress')),
      body: Center(
        child: RadialWaveProgress(
          size: 80,
          strokeWidth: 5,
          waveHeight: 4,
          backgroundColor: Colors.blue.withOpacity(0.3),
          progressColor: Colors.blue,
          startWaveColor:Colors.red.withOpacity(0.4),// Colors.blue.withOpacity(0.4),
          endWaveColor:Colors.green.withOpacity(0.4) //Colors.purple.withOpacity(0.4),
        ),
      ),
    );
  }
}

class RadialWaveProgress extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final double waveHeight;
  final Color backgroundColor;
  final Color progressColor;
  final Color startWaveColor;
  final Color endWaveColor;

  const RadialWaveProgress({
    super.key,
    required this.size,
    required this.strokeWidth,
    required this.waveHeight,
    required this.backgroundColor,
    required this.progressColor,
    required this.startWaveColor,
    required this.endWaveColor,
  });

  @override
  _RadialWaveProgressState createState() => _RadialWaveProgressState();
}

class _RadialWaveProgressState extends State<RadialWaveProgress>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _progressController;
  late Animation<Color?> _waveColorAnimation;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    _waveColorAnimation =
        ColorTween(begin: widget.startWaveColor, end: widget.endWaveColor)
            .animate(_waveController);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        final progress = _progressController.value;
        return CustomPaint(
          painter: RadialWavePainter(
            progress,
            _waveController,
            widget.strokeWidth,
            widget.backgroundColor,
            widget.progressColor,
            widget.waveHeight,
            _waveColorAnimation.value!,
          ),
          size: Size(widget.size, widget.size),
        );
      },
    );
  }
}

class RadialWavePainter extends CustomPainter {
  final double progress;
  final AnimationController waveController;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final double waveHeight;
  final Color waveColor;

  RadialWavePainter(
    this.progress,
    this.waveController,
    this.strokeWidth,
    this.backgroundColor,
    this.progressColor,
    this.waveHeight,
    this.waveColor,
  ) : super(repaint: waveController);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = backgroundColor;

    // Draw background circle
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    // Draw progress arc with smooth transition
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = waveColor; //progressColor;
    final progressAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2),
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );

    final wavePaint = Paint()..color = waveColor;
    final path = Path();
    final baseHeight = size.height * (1 - progress) + waveHeight;

    for (double i = 0; i <= size.width; i++) {
      final dx = i;
      final dy =
          sin((i / size.width * 2 * pi) + waveController.value * 2 * pi) *
                  waveHeight +
              baseHeight;
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.save();
    canvas.clipPath(
      Path()
        ..addOval(
          Rect.fromCircle(
              center: size.center(Offset.zero), radius: size.width / 2 - 3),
        ),
    );
    canvas.drawPath(path, wavePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
