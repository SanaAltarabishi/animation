import 'package:evaluate_slider_ex/core/resourses/strings.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/slider_label_widget.dart';
import 'package:flutter/material.dart';

class SliderLabelsRow extends StatelessWidget {
  const SliderLabelsRow({
    super.key,
    required this.sliderNotifier,
    required Animation<double> sliderAnimation,
  }) : _sliderAnimation = sliderAnimation;

  final SliderNotifier sliderNotifier;
  final Animation<double> _sliderAnimation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SliderLabelWidget(
          text: AppStrings.bad,
          sliderNotifier: sliderNotifier,
          value: 0.0,
          sliderAnimation: _sliderAnimation,
        ),
        SliderLabelWidget(
          text: AppStrings.notBad,
          sliderNotifier: sliderNotifier,
          value: 0.5,
          sliderAnimation: _sliderAnimation,
        ),
        SliderLabelWidget(
          text: AppStrings.good,
          sliderNotifier: sliderNotifier,
          value: 1.0,
          sliderAnimation: _sliderAnimation,
        ),
      ],
    );
  }
}
