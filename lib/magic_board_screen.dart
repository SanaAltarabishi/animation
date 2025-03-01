import 'dart:async';
import 'package:flutter/material.dart';
import 'package:magic_board_animation/magic_board_painter.dart';
import 'package:magic_board_animation/trail_point.dart';

class MagicBoardScreen extends StatefulWidget {
  const MagicBoardScreen({super.key});

  @override
  _MagicBoardScreenState createState() => _MagicBoardScreenState();
}

class _MagicBoardScreenState extends State<MagicBoardScreen> {
  final ValueNotifier<List<TrailPoint>> _points = ValueNotifier([]);
  final ValueNotifier<bool> _isDarkMode = ValueNotifier(true);
  late ValueNotifier<Color> _lineColor;
  late Timer _fadeTimer;

  @override
  void initState() {
    super.initState();
    _lineColor = ValueNotifier(Colors.white);

    _fadeTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (_points.value.isNotEmpty) {
        _points.value = List.of(_points.value)..removeAt(0);
      }
    });
  }

  void _changeColor(Color color) {
    _lineColor.value = color;
  }

  void _toggleMode() {
    _isDarkMode.value = !_isDarkMode.value;
    _lineColor.value = _isDarkMode.value
        ? Colors.white
        : Colors.black; // Change line color dynamically
  }

  @override
  void dispose() {
    _fadeTimer.cancel();
    _points.dispose();
    _lineColor.dispose();
    _isDarkMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDarkMode,
      builder: (_, isDarkMode, __) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            leading: IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: _toggleMode,
            ),
          ),
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          body: GestureDetector(
            onPanStart: (details) {
              _points.value = [
                TrailPoint(details.localPosition, DateTime.now(), true)
              ];
            },
            onPanUpdate: (details) {
              _points.value = List.of(_points.value)
                ..add(TrailPoint(details.localPosition, DateTime.now(), false));
            },
            child: ValueListenableBuilder<List<TrailPoint>>(
              valueListenable: _points,
              builder: (_, points, __) {
                return ValueListenableBuilder<Color>(
                  valueListenable: _lineColor,
                  builder: (_, lineColor, __) {
                    return CustomPaint(
                      size: Size.infinite,
                      painter: MagicBoardPainter(points, lineColor),
                    );
                  },
                );
              },
            ),
          ),
          bottomNavigationBar: _buildBottomBar(isDarkMode),
        );
      },
    );
  }

  Widget _buildBottomBar(bool isDarkMode) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 5,
              color: Colors.grey.shade300,
            ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildColorPickerButtons(isDarkMode),
        ),
      ),
    );
  }

  List<Widget> _buildColorPickerButtons(bool isDarkMode) {
    final colors = [
      isDarkMode ? Colors.white : Colors.black,
      isDarkMode ? Colors.blueGrey : Colors.blueGrey.shade200,
      isDarkMode ? Colors.brown : Colors.brown.shade200,
      isDarkMode ? Colors.green : Colors.green.shade200,
      isDarkMode ? Colors.red : Colors.red.shade200,
      isDarkMode ? Colors.yellow : Colors.yellow.shade200,
      isDarkMode ? Colors.deepPurpleAccent : Colors.deepPurpleAccent.shade100,
      isDarkMode ? Colors.blue : Colors.blue.shade200,
      isDarkMode ? Colors.pink : Colors.pink.shade200,
    ];

    return colors.map((color) => _colorPickerButton(color)).toList();
  }

  Widget _colorPickerButton(Color color) {
    return GestureDetector(
      onTap: () => _changeColor(color),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
          boxShadow: [
            BoxShadow(
              color: _isDarkMode.value ? Colors.white10 : Colors.black12,
              blurRadius: 2,
              offset: Offset(-3, -3),
            )
          ],
        ),
        width: 50,
        height: 50,
      ),
    );
  }
}
