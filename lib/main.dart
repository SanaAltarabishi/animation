import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CardSwipeScreen(),
    );
  }
}

class CardSwipeScreen extends StatefulWidget {
  const CardSwipeScreen({super.key});

  @override
  _CardSwipeScreenState createState() => _CardSwipeScreenState();
}

class _CardSwipeScreenState extends State<CardSwipeScreen> {
  final List<String> originalImages = [
    'assets/panda.jpg',
    'assets/coffe.png',
    'assets/aesthetic-laptop-minimalist-wallpapers-wallpaper-cave.png',
  ];

  List<String> images = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    images = List.from(originalImages); // Initialize images list
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.transparent,
          height: screenHeight / 2,
          width: screenWidth / 2,
          child: Stack(
            children: [
              Positioned(
                left: 10,
                right: _currentIndex * 10,
                top: 0,
                bottom: 0,
                child: Dismissible(
                  key: ValueKey<String>(images[_currentIndex]),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    String message = direction == DismissDirection.endToStart
                        ? "Not Available"
                        : "Available";
                    Color snackBarColor =
                        direction == DismissDirection.endToStart
                            ? Colors.red
                            : Colors.green;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 1),
                      content: Text(message),
                      backgroundColor: snackBarColor,
                    ));

                    setState(() {
                      // Update the current index
                      _currentIndex = (_currentIndex + 1) % images.length;
                    });
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Add border radius
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: Image.asset(
                              images[_currentIndex],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                // Optional: Manually trigger swipe left
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text("Not Available"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                setState(() {
                                  _currentIndex =
                                      (_currentIndex + 1) % images.length;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () {
                                // Optional: Manually trigger swipe right
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text("Available"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                setState(() {
                                  _currentIndex =
                                      (_currentIndex + 1) % images.length;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 0.1.seconds, delay: 0.1.seconds),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
