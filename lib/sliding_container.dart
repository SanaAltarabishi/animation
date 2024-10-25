
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlidingContainer extends StatelessWidget {
  final Color color;
  final double initialOffsetX;
  final double intervalStart;
  final double intervalEnd;
  const SlidingContainer({
    super.key, required this.color, required this.initialOffsetX, required this.intervalStart, required this.intervalEnd,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin:  Offset(initialOffsetX, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve:  Interval(intervalStart,intervalEnd, curve: Curves.easeInOutCubic),
            ),
          ),
          child: child,
        );
      },
      child: Container(
        color:color,
      ),
    );
  }
}
