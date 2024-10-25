import 'package:custom_transition/sliding_container.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  // final Animation<double> transitionAnimation;
  // const SecondPage({
  //   super.key,
  //   required this.transitionAnimation,
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          Expanded(
            child: SlidingContainer(
              color: Colors.blueGrey,
              initialOffsetX: 1,
              intervalStart: 0,
              intervalEnd: 0.5,
            ),
          ),
          Expanded(child: SlidingContainer(
            color: Color.fromARGB(255, 24, 83, 112),
              initialOffsetX: -1,
              intervalStart: 0.5,
              intervalEnd: 1,
          ),),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: const Text('Navigate Back'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
