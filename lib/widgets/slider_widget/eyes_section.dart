import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/eyes_container.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';
import 'package:flutter/material.dart';

class EyesSection extends StatelessWidget {
  const EyesSection({
    super.key,
    required this.sliderNotifier,
  });

  final SliderNotifier sliderNotifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:context.screenHeight*0.15, //100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EyeWidget(sliderNotifier: sliderNotifier),
           SizedBox(
            width:context.screenWidth*0.05, //25,
          ),
          EyeWidget(sliderNotifier: sliderNotifier),
        ],
      ),
    );
  }
}
