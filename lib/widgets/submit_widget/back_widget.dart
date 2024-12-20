import 'package:evaluate_slider_ex/pages/submit_page.dart';
import 'package:evaluate_slider_ex/core/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({
    super.key,
    required this.widget,
  });

  final SubmitPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: context.screenWidth * 0.02),
      width: context.screenWidth * 0.1, //40,
      height: context.screenWidth * 0.1, // 40,
      decoration: BoxDecoration(
        color: widget.sliderNotifier.currentState.detailsColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.close),
      ),
    );
  }
}
