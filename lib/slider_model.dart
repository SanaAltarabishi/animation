import 'package:flutter/material.dart';

class SliderState {
  final double value;
  SliderState({
    required this.value,
  });

  Color get backgroundColor {
    if (value < 0.33) return const Color.fromARGB(255, 255, 147, 139);

    if (value < 0.66) return const Color.fromARGB(255, 240, 224, 135);
    return const Color.fromARGB(255, 178, 231, 129);
  }

  Color get detailsColor {
    if (value < 0.33) return const Color.fromARGB(255, 177, 40, 30);

    if (value < 0.66) return const Color.fromARGB(255, 155, 72, 42);
    return const Color.fromARGB(255, 38, 59, 39);
  }

  Color get textColor {
    if (value < 0.33) return const Color(0xffFC5A8D);
    if (value < 0.66) return const Color(0xffFFE135);
    return const Color(0xff8EE53F);
  }

  double get borderRaduis {
    if (value < 0.33) return 50;
    if (value < 0.66) return 25;
    return 50;
  }

  double get width {
    if (value < 0.33) return 50;
    if (value < 0.66) return 90;
    return 100;
  }

  double get height {
    if (value < 0.33) return 50;
    if (value < 0.66) return 30;
    return 100;
  }

  String get text {
    if (value < 0.33) return 'BAD';

    if (value < 0.66) return 'NOT BAD';
    return 'GOOD';
  }

  String get smileType {
    if (value < 0.33) return 'sad';
    if (value < 0.66) return 'neutral';
    return 'happy';
  }

  String get message {
    if (value < 0.33) return 'We’re sorry for your experience.';
    if (value < 0.66) return 'Thank you for your feedback.';
    return 'Thank you for your kind words!';
  }
}
