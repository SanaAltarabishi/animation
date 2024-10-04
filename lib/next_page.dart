
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 14, 81, 174),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'Close',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
