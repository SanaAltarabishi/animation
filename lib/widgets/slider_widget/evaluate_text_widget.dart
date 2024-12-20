import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';
import 'package:flutter/material.dart';

class EvaluateTextWidget extends StatelessWidget {
  const EvaluateTextWidget({
    super.key,
    required this.sliderNotifier,
  });

  final SliderNotifier sliderNotifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight*0.1,//80,
      width: context.screenWidth*1,
      child: AnimatedSwitcher(
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(2, 0),
              end: Offset.zero,
            ).animate(animation),
            // opacity: animation,
            child: child,
          );
        },
        child: Text(
          sliderNotifier.currentState.text,
          key: ValueKey(sliderNotifier.currentState.text),
          style: TextStyle(
            fontSize:context.screenWidth*0.15, //60,
            fontWeight: FontWeight.bold,
            color: sliderNotifier.currentState.detailsColor.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
