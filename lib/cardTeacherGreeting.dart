import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardFlipPage extends StatefulWidget {
  const CardFlipPage({super.key});

  @override
  State<CardFlipPage> createState() => _CardFlipPageState();
}

class CardFront extends StatelessWidget {
  const CardFront({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "It's Teacher's Day",
        style: GoogleFonts.annieUseYourTelescope(
            fontWeight: FontWeight.bold, fontSize: 50, color: Colors.black),
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  const CardBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Happy Teacher's Day",
            style: GoogleFonts.annieUseYourTelescope(
            fontWeight: FontWeight.bold, fontSize: 50, color: Colors.black) ,
          ),
          Icon(Icons.star_border,size: 40,),
          Icon(Icons.star_border,size: 40,),
      
        ],
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  final double value;
  const CardContainer({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(value < 0.5 ? pi * value : (pi * (1 + value))),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(20),
        child: Container(
          height: 200,
          padding: EdgeInsets.all(25),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.yellow.shade200, Colors.purple.shade100])),
          child: (value < 0.5) ? CardFront() : CardBack(),
        ),
      ),
    );
  }
}

class _CardFlipPageState extends State<CardFlipPage> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed:(){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.black,),),
         SizedBox(height: 250,),
          Center(
            child: CardContainer(
              value: value,
            ),
          ),
          Center(
            child: Slider(
              activeColor: Colors.yellow.shade200,
              value: value,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ),
          ),
        ],
      ),
    ));
  }
}
