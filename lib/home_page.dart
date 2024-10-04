import 'package:flutter/material.dart';
import 'package:swipeable_button_animation_ui/next_page.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipeable button view'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 143, 110, 98),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            "assets/therp.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: SwipeableButtonView(
              buttonText: "SLIDE TO UNLOCK",
              buttonWidget: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.brown,
              ),
              activeColor: Colors.brown,
              isFinished: isFinished,
              onWaitingProcess: () {
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    isFinished = true;
                  });
                });
              },
              onFinish: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NextPage(),
                  ),
                );
                setState(
                  () {
                    isFinished = false;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
