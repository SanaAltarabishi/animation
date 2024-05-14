import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/cardTeacherGreeting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SurprisePage extends StatefulWidget {
  const SurprisePage({super.key});

  @override
  State<SurprisePage> createState() => _SurprisePageState();
}

class _SurprisePageState extends State<SurprisePage> {
  bool isButtonPressed = false;
  void buttonPressed() {
    setState(() {
      isButtonPressed = !isButtonPressed;
      Navigator.push(context, MaterialPageRoute(builder:(context) => CardFlipPage(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
          IconButton(onPressed:(){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        SizedBox(height: 300,),
          Center(
            child: NewButton(
              isButtonPressed: isButtonPressed,
              onTap: buttonPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class NewButton extends StatelessWidget {
  final onTap;
  bool isButtonPressed;
  NewButton({super.key, this.onTap, required this.isButtonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(
          microseconds: 200,
        ),
        height: 150,
        width: 300,
        child:Center(
          child: AnimatedTextKit(
           // pause: Duration(milliseconds: 200),
            animatedTexts:[
            TyperAnimatedText('What is today??',textStyle:isButtonPressed?
            GoogleFonts.alike(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black38): 
                        GoogleFonts.alike(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black), )
          ]),
        ) ,
        // child: Icon(
        //   Icons.star,
        //   color:
        //       isButtonPressed ? Colors.yellow.shade100 : Colors.yellow.shade200,
        //   size: 60,
        // ),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.yellow.shade200, Colors.purple.shade100]),
           
            border: Border.all(
              color:
                  isButtonPressed ? Colors.grey.shade100 : Colors.grey.shade200,
            ),
            boxShadow: isButtonPressed
                ? []
                : [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(6, 6),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6, -6),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ]),
      ),
    );
  }
}
