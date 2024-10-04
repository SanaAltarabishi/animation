import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SlideAction(
            text: 'Navigate to the next page ',
            borderRadius: 12,
            elevation: 0,
            outerColor: const Color.fromARGB(255, 144, 74, 156),
            onSubmit: () =>
                //when add this even if we don't add nothing it gives us the full animation
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NextPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 144, 74, 156),
      appBar: AppBar(),
      body: const Center(
        child: Text('Next page here !!'),
      ),
    );
  }
}
