import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class TextSlide extends StatelessWidget {
  const TextSlide({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.brown,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/coffe.png',
            fit: BoxFit.cover,
            height: height,
          ),
          Container(
            color: Colors.brown,
            margin: EdgeInsets.only(top: height * 0.8),
            height: 45,
            child: Marquee(
              velocity: 30,//the speed of the scroll
              blankSpace: 0,//the space between the repeate
              text: "My Name is Sana Al Tarabishi || ",
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 196, 146, 103),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
