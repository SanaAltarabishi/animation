import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/greetingPage.dart';
import 'package:app/teacherGreeting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GreetingPage(),
    );
  }
}

class GreetingPage extends StatelessWidget {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //    mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GreetingCard(),
            SizedBox(
              height: 70,
            ),
            Center(
                child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  "Mother's Day",
                  textStyle: GoogleFonts.alike(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black),
                ),
                FadeAnimatedText(
                  "Mother's Day",
                  textStyle: GoogleFonts.alike(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black),
                ),
                ScaleAnimatedText(
                  "Mother's Day",
                  textStyle: GoogleFonts.alike(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black),
                ),
                RotateAnimatedText(
                  "Mother's Day",
                  textStyle: GoogleFonts.alike(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black),
                ),
              ],
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'NEXT',
          child: Icon(Icons.arrow_forward),
          backgroundColor: Colors.yellow.shade200,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SurprisePage(),
                ));
          }),
    );
  }
}
