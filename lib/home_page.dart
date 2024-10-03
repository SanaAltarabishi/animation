import 'package:button_animation/play_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 32, 47),
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: PlayButton(
            playIcon: const Icon(
              Icons.play_arrow,
              size: 90,
              color: Colors.black,
            ),
            pauseIcon: const Icon(
              Icons.pause,
              size: 90,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
