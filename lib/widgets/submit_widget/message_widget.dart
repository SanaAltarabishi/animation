
import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:evaluate_slider_ex/pages/submit_page.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required Animation<Offset> textSlideAnimation,
    required Animation<double> fadeAnimation,
    required this.widget,
  }) : _textSlideAnimation = textSlideAnimation, _fadeAnimation = fadeAnimation;

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
            widget.sliderNotifier.currentState.message,
            style: TextStyle(
              fontSize:context.screenWidth*0.04, //15,
              fontWeight: FontWeight.bold,
              color: widget.sliderNotifier.currentState.detailsColor,
            ),
          ),
        ),
      ),
    );
  }
}
