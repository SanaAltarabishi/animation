import 'package:custom_transition/button_nav_bar/sample_widget.dart';
import 'package:custom_transition/button_nav_bar/size_config.dart';
import 'package:flutter/material.dart';

double animatedPositionedLeftValue(int currentIndex) {
  switch (currentIndex) {
    case 0:
      return AppSize.blockSizeHorizontal * 5.5;
    case 1:
      return AppSize.blockSizeHorizontal * 22.5;
    case 2:
      return AppSize.blockSizeHorizontal * 39.5;
    case 3:
      return AppSize.blockSizeHorizontal * 56.5;
    case 4:
      return AppSize.blockSizeHorizontal * 73.5;
    default:
      return 0;
  }
}

final List<Color> gradient = [
  Colors.yellow.withOpacity(0.8),
  Colors.yellow.withOpacity(0.5),
  Colors.transparent,
];

List<Widget> screens = [
  const SampleWidget(
    color: Colors.deepPurpleAccent,
    label: "HOME",
  ),
  const SampleWidget(
    color: Colors.amber,
    label: "SEARCH",
  ),
  const SampleWidget(
    color: Colors.cyan,
    label: "EXPLORE",
  ),
  const SampleWidget(
    color: Colors.deepOrangeAccent,
    label: "SETTINGS",
  ),
  const SampleWidget(
    color: Colors.blue,
    label: "PROFILE",
  ),
];
