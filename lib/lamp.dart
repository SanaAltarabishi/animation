import 'package:flutter/material.dart';
import 'dart:async';

class ChainReactionLamps extends StatefulWidget {
  const ChainReactionLamps({super.key});

  @override
  State<ChainReactionLamps> createState() => _ChainReactionLampsState();
}

class _ChainReactionLampsState extends State<ChainReactionLamps> {
  static const int lampCount = 5;
  int _activeLampIndex = 0;
  bool _isForward = true;
  List<bool> lampStates = List.generate(lampCount, (index) => index == 0);

  @override
  void initState() {
    super.initState();
    _startChainReaction();
  }

  void _startChainReaction() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted == true) {
        setState(() {
          lampStates[_activeLampIndex] = false;

          if (_isForward) {
            _activeLampIndex++;
            if (_activeLampIndex >= lampCount) {
              _activeLampIndex = lampCount - 2;
              _isForward = false;
            }
          } else {
            _activeLampIndex--;
            if (_activeLampIndex < 0) {
              _activeLampIndex = 1;
              _isForward = true;
            }
          }
          lampStates[_activeLampIndex] = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lamps",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 67, 67, 67),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(lampCount, (index) {
            return AnimatedLamp(
              isOn: lampStates[index],
              moveright: index == _activeLampIndex,
            );
          }),
        ),
      ),
    );
  }
}

class AnimatedLamp extends StatefulWidget {
  final bool isOn;
  final bool moveright;

  const AnimatedLamp({super.key, required this.isOn, required this.moveright});

  @override
  State<AnimatedLamp> createState() => _AnimatedLampState();
}

class _AnimatedLampState extends State<AnimatedLamp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
// final VoidCallback onCompleted;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _positionAnimation = Tween<Offset>(
            begin: Offset.zero, end: const Offset(0.2, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          }
        },
      );

    if (widget.moveright) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedLamp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.moveright && !oldWidget.moveright) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAnimation,
      child: Column(
        children: [
          Container(
            width: 2,
            color: widget.isOn ? Colors.yellow : Colors.grey,
            height: 280,
          ),
          Icon(
            Icons.light,
            color: widget.isOn ? Colors.yellow : Colors.grey,
            size: 60,
          ),
        ],
      ),
    );
  }
}
