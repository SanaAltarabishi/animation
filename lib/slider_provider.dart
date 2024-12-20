import 'package:evaluate_slider_ex/slider_model.dart';
import 'package:flutter/material.dart';

class SliderNotifier extends ChangeNotifier {
  double _sliderValue = 1.0;
  double get sliderValue => _sliderValue;

  SliderState get currentState => SliderState(value: _sliderValue);

  void updateSliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }
}
