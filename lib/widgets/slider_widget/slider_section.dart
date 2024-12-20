import 'package:flutter/material.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/custom_thumb_shape.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/custom_track_shape.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';

class SliderSection extends StatelessWidget {
  final SliderNotifier sliderNotifier;
  final Animation<double> sliderAnimation;
  final void Function(double)? onChanged;

  const SliderSection({
    super.key,
    required this.sliderNotifier,
    required this.sliderAnimation,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
          thumbShape: CustomThumbShape(
            thumbRadius: 20,
            smileType: sliderNotifier.currentState.smileType,
          ),
          trackShape: CustomTrackShape(
            cicleColor: Colors.grey,
          ),
          // sliderNotifier.currentState.detailsColor.withOpacity(0.5)),
          trackHeight: 13,
          thumbColor: sliderNotifier.currentState.detailsColor,
          activeTrackColor: Colors.grey,
          inactiveTrackColor: Colors.grey,
          activeTickMarkColor: Colors.grey,
          inactiveTickMarkColor: Colors.grey),
      child: AnimatedBuilder(
        animation: sliderAnimation,
        builder: (context, child) {
          return Slider(
            min: 0,
            max: 1,
            divisions: 2,
            value: sliderAnimation.value,
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}
