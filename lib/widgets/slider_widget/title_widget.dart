import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final SliderNotifier sliderNotifier;

  const TitleWidget({
    super.key,
    required this.text,
    required this.sliderNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final color = sliderNotifier.currentState.detailsColor;
    return Text(
      text,
      style: TextStyle(
        fontSize: context.screenWidth*0.05,//20,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
