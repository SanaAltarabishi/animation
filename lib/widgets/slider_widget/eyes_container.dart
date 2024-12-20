import 'package:evaluate_slider_ex/slider_provider.dart';
import 'package:flutter/material.dart';

class EyeWidget extends StatelessWidget {
  const EyeWidget({
    super.key,
    required this.sliderNotifier,
  });

  final SliderNotifier sliderNotifier;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 500,
      ),
      width: sliderNotifier.currentState.width,
      height: sliderNotifier.currentState.height,
      decoration: BoxDecoration(
        color: sliderNotifier.currentState.detailsColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            sliderNotifier.currentState.borderRaduis,
          ),
        ),
      ),
    );
  }
}
