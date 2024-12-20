
import 'package:evaluate_slider_ex/core/resourses/strings.dart';
import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:evaluate_slider_ex/pages/submit_page.dart';
import 'package:flutter/material.dart';

class ContinueContainerWidget extends StatelessWidget {
  const ContinueContainerWidget({
    super.key,
    required Animation<Offset> textSlideAnimation,
    required Animation<double> fadeAnimation,
    required this.widget,
  })  : _textSlideAnimation = textSlideAnimation,
        _fadeAnimation = fadeAnimation;

  final Animation<Offset> _textSlideAnimation;
  final Animation<double> _fadeAnimation;
  final SubmitPage widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _textSlideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            width: context.screenWidth * 0.8, //350,
            height: context.screenHeight * 0.08, //50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: widget.sliderNotifier.currentState.detailsColor,
            ),
            child:  Center(
              child: Text(
                AppStrings.continuetext,
                style: TextStyle(
                  fontSize:context.screenHeight*0.04, //20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
