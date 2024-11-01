import 'package:flutter/material.dart';
import 'dart:async';

class ChainReactionLamps extends StatefulWidget {
  const ChainReactionLamps({Key? key}) : super(key: key);

  @override
  State<ChainReactionLamps> createState() => _ChainReactionLampsState();
}

class _ChainReactionLampsState extends State<ChainReactionLamps> {
  static const int lampCount = 5; // Number of lamps in the chain
  int _activeLampIndex = 0; // Track which lamp is currently on

  // Initialize the on/off states for each lamp
  List<bool> _lampStates = List.generate(lampCount, (index) => index == 0);

  @override
  void initState() {
    super.initState();
    _startChainReaction();
  }

  void _startChainReaction() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted == true) {
        setState(() {
          // Turn off the current lamp
          _lampStates[_activeLampIndex] = false;

          // Move to the next lamp, looping back to the start if necessary
          _activeLampIndex = (_activeLampIndex + 1) % lampCount;

          // Turn on the next lamp
          _lampStates[_activeLampIndex] = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chain Reaction Lamps")),
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(lampCount, (index) {
            return AnimatedLamp(
              isOn: _lampStates[index],
              moveUp: index == _activeLampIndex,
            );
          }),
        ),
      ),
    );
  }
}

class AnimatedLamp extends StatelessWidget {
  final bool isOn;
  final bool moveUp;

  const AnimatedLamp({Key? key, required this.isOn, required this.moveUp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: EdgeInsets.only(bottom: moveUp ? 20 : 0),
      child: Icon(
        Icons.lightbulb_rounded,
        color: isOn ? Colors.yellow : Colors.grey,
        size: 60,
      ),
    );
  }
}
