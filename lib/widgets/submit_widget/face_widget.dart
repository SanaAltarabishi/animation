
import 'package:evaluate_slider_ex/pages/submit_page.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/eyes_section.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/mouth_widget.dart';
import 'package:flutter/material.dart';

class FaceWidget extends StatelessWidget {
  const FaceWidget({
    super.key,
    required Animation<Offset> slideAnimation,
    required Animation<double> fadeAnimation,
    required this.widget,
  }) : _slideAnimation = slideAnimation, _fadeAnimation = fadeAnimation;

  final Animation<Offset> _slideAnimation;
  final Animation<double> _fadeAnimation;
  final SubmitPage widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              EyesSection(
                sliderNotifier: widget.sliderNotifier,
              ),
              CustomMouthWidget(sliderNotifier: widget.sliderNotifier),
            ],
          ),
        ),
      ),
    );
  }
}
