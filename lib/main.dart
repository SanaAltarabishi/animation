import 'package:animated_splash/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashPage());
  }
}
//TODO:
//? first :
// opacity form 0 to 1
//+ slide from center to up
//+tween "for the scaffold color"
//+ tween "for the depth"
//? sec:
//scale bigger in the center
//? third:
//move from center to left
//+ smaller again
//+ the text will appears