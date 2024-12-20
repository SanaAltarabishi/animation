import 'package:evaluate_slider_ex/core/resourses/strings.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';
import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoteAndSubmitWidget extends StatelessWidget {
  const NoteAndSubmitWidget({
    super.key,
    required this.sliderNotifier,
  });

  final SliderNotifier sliderNotifier;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: context.screenHeight * 0.08, //60,
          width: context.screenWidth * 0.7, //300,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: sliderNotifier.currentState.detailsColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.note,
              style: TextStyle(
                  fontSize: context.screenHeight * 0.03, //20,
                  fontWeight: FontWeight.w400,
                  color: sliderNotifier.currentState.detailsColor),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              //Navigate to the next page
              context.push('/submit', extra: sliderNotifier);
            },
            child: Container(
              height: context.screenHeight * 0.08, // 60,
              width: context.screenWidth * 0.4, //180,
              decoration: BoxDecoration(
                color: sliderNotifier.currentState.detailsColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.submit,
                    style: TextStyle(
                      fontSize: context.screenWidth * 0.03, //20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: context.screenHeight * 0.02,
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
