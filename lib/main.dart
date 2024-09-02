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
  bool opened = true;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 300,
            ),
            left: opened ? screenWidth / 2 - 40 : screenWidth / 2 - 120,
            top: opened ? (screenHeight / 2) - 30 : (screenHeight / 2) + 50,
            child: _buildOption(const Icon(Icons.abc), Colors.orange.shade100),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 300,
            ),
            left: opened ? screenWidth / 2 - 40 : screenWidth / 2 + 60,
            top: opened ? (screenHeight / 2) - 30 : (screenHeight / 2) + 50,
            child: _buildOption(const Icon(Icons.abc), Colors.grey.shade100),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 300,
            ),
            left: opened ? screenWidth / 2 - 40 : screenWidth / 2 + 60,
            top: opened ? (screenHeight / 2) - 30 : (screenHeight / 2) - 110,
            child: _buildOption(const Icon(Icons.abc), Colors.yellow.shade100),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 300,
            ),
            left: opened ? screenWidth / 2 - 40 : screenWidth / 2 - 120,
            top: opened ? (screenHeight / 2) - 30 : (screenHeight / 2) - 120,
            child: _buildOption(const Icon(Icons.abc), Colors.brown.shade100),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 300,
            ),
            left: opened ? screenWidth / 2 - 40 : screenWidth / 2 - 30,
            top: opened ? (screenHeight / 2) - 30 : (screenHeight / 2) - 140,
            child: _buildOption(const Icon(Icons.abc), Colors.green.shade100),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 300,
            ),
            left: opened ? screenWidth / 2 - 40 : screenWidth / 2 - 30,
            top: opened ? (screenHeight / 2) - 30 : (screenHeight / 2) + 70,
            child: _buildOption(const Icon(Icons.abc), Colors.blue.shade100),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 300,
            ),
            left: opened ? screenWidth / 2 - 40 : screenWidth / 2 + 90,
            top: (screenHeight / 2) - 30,
            child: _buildOption(const Icon(Icons.abc), Colors.purple.shade100),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 300,
            ),
            left: opened ? screenWidth / 2 - 40 : screenWidth / 2 - 150,
            top: (screenHeight / 2) - 30,
            child: _buildOption(const Icon(Icons.abc), Colors.pink.shade100),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: opened
                  ? GestureDetector(
                      key:
                          UniqueKey(), // we add this to make the animation happeaned clear
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.blue,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          opened = false;
                        });
                      },
                    )
                  : GestureDetector(
                      key: UniqueKey(),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.yellow,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          opened = true;
                        });
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(Icon icon, Color iconColor) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return RotationTransition(
          turns: animation,
          child: child,
        );
      },
      child: InkWell(
        key: UniqueKey(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: iconColor,
            ),
            child: Center(
              child: icon,
            ),
          ),
        ),
        onTap: () {
          setState(() {
            opened = false;
          });
        },
      ),
    );
  }
}
