
import 'package:evaluate_slider_ex/core/resourses/strings.dart';
import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:evaluate_slider_ex/pages/submit_page.dart';
import 'package:flutter/material.dart';

class FeedBackWidget extends StatelessWidget {
  const FeedBackWidget({
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
          child: Text(
            AppStrings.feedBack,
            style: TextStyle(
              fontSize: context.screenWidth*0.08,//30,
              fontWeight: FontWeight.bold,
              color: widget.sliderNotifier.currentState.detailsColor,
            ),
          ),
        ),
      ),
    );
  }
}
