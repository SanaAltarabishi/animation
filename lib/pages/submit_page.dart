import 'package:evaluate_slider_ex/slider_provider.dart';
import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:evaluate_slider_ex/widgets/submit_widget/back_widget.dart';
import 'package:evaluate_slider_ex/widgets/submit_widget/continue_widget.dart';
import 'package:evaluate_slider_ex/widgets/submit_widget/face_widget.dart';
import 'package:evaluate_slider_ex/widgets/submit_widget/feed_back_widget.dart';
import 'package:evaluate_slider_ex/widgets/submit_widget/message_widget.dart';
import 'package:evaluate_slider_ex/widgets/submit_widget/thanks_widget.dart';
import 'package:flutter/material.dart';

class SubmitPage extends StatefulWidget {
  final SliderNotifier sliderNotifier;
  const SubmitPage({super.key, required this.sliderNotifier});

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation = Tween<Offset>(
            begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _textSlideAnimation = Tween<Offset>(
            begin: const Offset(0, 2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.sliderNotifier.currentState.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.screenHeight * 0.02,
            ),
            BackWidget(widget: widget),
            SizedBox(
              height: context.screenHeight * 0.05,
            ),
            FaceWidget(
                slideAnimation: _slideAnimation,
                fadeAnimation: _fadeAnimation,
                widget: widget),
            SizedBox(
              height: context.screenHeight * 0.15,
            ),
            ThanksWidget(
                textSlideAnimation: _textSlideAnimation,
                fadeAnimation: _fadeAnimation,
                widget: widget),
            FeedBackWidget(
                textSlideAnimation: _textSlideAnimation,
                fadeAnimation: _fadeAnimation,
                widget: widget),
            SizedBox(
              height: context.screenHeight * 0.02,
            ),
            MessageWidget(
                textSlideAnimation: _textSlideAnimation,
                fadeAnimation: _fadeAnimation,
                widget: widget),
            SizedBox(
              height: context.screenHeight * 0.1,
            ),
            ContinueContainerWidget(
              textSlideAnimation: _textSlideAnimation,
              fadeAnimation: _fadeAnimation,
              widget: widget,
            ),
            SizedBox(
              height: context.screenHeight * 0.02,
            )
          ],
        ),
      ),
    );
  }
}
