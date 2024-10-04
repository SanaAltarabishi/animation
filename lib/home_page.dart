import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:open_container_ui/next_page.dart';
//import 'package:open_container_ui/star_shape_border.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: const Duration(
            milliseconds: 600,
          ),
          closedBuilder: (context, action) {
            return GestureDetector(
              onTap: action,
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'OPEN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            );
          },
          openBuilder: (context, action) {
            return const NextPage();
          },
          closedShape:
              // UnderlineInputBorder(
              //   borderSide: BorderSide(color: Colors.blue),
              // ),
//1): RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              //2): StarShapeBorder(),
              const CircleBorder(),
          openShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onClosed: (data) {
            print('container closed !');
          },
        ),
      ),
    );
  }
}
