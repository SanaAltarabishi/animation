import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';

class SliderLabelWidget extends StatelessWidget {
  final String text;
  final SliderNotifier sliderNotifier;
  final double value;
  final Animation<double> sliderAnimation;

  const SliderLabelWidget({
    super.key,
    required this.text,
    required this.sliderNotifier,
    required this.value,
    required this.sliderAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = (sliderNotifier.sliderValue - value).abs() < 0.1;
    final color = isActive ? sliderNotifier.currentState.detailsColor : Colors.grey;

    return AnimatedBuilder(
      animation: sliderAnimation,
      builder: (context, child) {
        return Text(
          text,
          style: TextStyle(
            fontSize:context.screenWidth*0.05, //20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        );
      },
    );
  }
}
