import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/evaluate_text_widget.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/eyes_section.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/mouth_widget.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/note_and_submit_widget.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/slider_labels_row.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/slider_section.dart';
import 'package:evaluate_slider_ex/widgets/slider_widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderAnimationPage extends StatefulWidget {
  const SliderAnimationPage({super.key});

  @override
  State<SliderAnimationPage> createState() => _SliderAnimationPageState();
}

class _SliderAnimationPageState extends State<SliderAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sliderAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _sliderAnimation =
        Tween<double>(begin: 1, end: 0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    final sliderNotifier = Provider.of<SliderNotifier>(context);
    final currentState = sliderNotifier.currentState;

    return Scaffold(
      body: AnimatedContainer(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        color: currentState.backgroundColor,
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.screenHeight * 0.05,
                    ),
                    TitleWidget(
                      text: 'How was your experince?',
                      sliderNotifier: sliderNotifier,
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.1,
                    ),
                    EyesSection(sliderNotifier: sliderNotifier),
                    CustomMouthWidget(
                      sliderNotifier: sliderNotifier,
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.05,
                    ),
                    EvaluateTextWidget(sliderNotifier: sliderNotifier),
                    SizedBox(
                      height: context.screenHeight * 0.06,
                    ),
                    SliderSection(
                      sliderNotifier: sliderNotifier,
                      sliderAnimation: _sliderAnimation,
                      onChanged: (value) {
                        _animateSlider(sliderNotifier.sliderValue, value);
                        sliderNotifier.updateSliderValue(value);
                      },
                    ),
                    SliderLabelsRow(
                      sliderNotifier: sliderNotifier,
                      sliderAnimation: _sliderAnimation,
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.1,
                    ),
                    NoteAndSubmitWidget(sliderNotifier: sliderNotifier),
                    SizedBox(
                      height: context.screenHeight * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _animateSlider(double start, double end) {
    _sliderAnimation = Tween<double>(begin: start, end: end).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
