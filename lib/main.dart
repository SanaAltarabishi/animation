import 'package:animation_ui/animation_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimationUiPage(),
    );
  }
}

// TODO:
//first : enter from top to center
//then : flip hori
//then : reduce the size + move up ---- the texts ,buttons will appears from bottom to center
