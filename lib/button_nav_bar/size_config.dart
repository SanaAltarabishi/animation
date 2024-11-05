import 'package:flutter/material.dart';

class AppSize {
  static late MediaQueryData _mediaQueryDate;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void initState(BuildContext context) {
    _mediaQueryDate = MediaQuery.of(context);
    screenWidth = _mediaQueryDate.size.width;
    screenHeight = _mediaQueryDate.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;


  }
}
