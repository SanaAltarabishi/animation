import 'package:flutter/material.dart';


class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor:  const Color(0xff08B783), // Button color
          ),
          child: const Text('Continue'),
        ),
      ),
    );
  }
}