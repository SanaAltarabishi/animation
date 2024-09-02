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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool toggleValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            color: toggleValue ? Colors.green.shade100 : Colors.red.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeIn,
                top: 3,
                left: toggleValue ? 60 : 0,
                right: toggleValue ? 0 : 60,
                child: InkWell(
                  onTap: toggleButton,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        // turns: animation, with RotationTransition widget
                        scale: animation,
                        child: child,
                      );
                    },
                    child: toggleValue
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 35,
                            key: UniqueKey(),
                          )
                        : Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                            size: 35,
                            key: UniqueKey(),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
