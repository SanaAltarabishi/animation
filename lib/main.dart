import 'package:curves_ui/clip_shadow_path.dart';
import 'package:curves_ui/left_btm_curve.dart';
import 'package:curves_ui/left_top_curve.dart';
import 'package:curves_ui/right_btm_curve.dart';
import 'package:curves_ui/right_top_curve.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: CurvesUiPage());
  }
}

class CurvesUiPage extends StatelessWidget {
  const CurvesUiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(20, -30),
            child: ClipShadowPath(
              shadow: const BoxShadow(
                color: Colors.grey,
                offset: Offset(-5, 3),
                blurRadius: 5,
                spreadRadius: 10,
              ),
              clipper: RightTopCurveBtn(),
              child: Container(
                height: height * 0.99,
                width: width * 0.99,
                color: const Color(0xffEEEAEA),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(50, -25),
            child: ClipShadowPath(
              shadow: const BoxShadow(
                color: Colors.grey,
                offset: Offset(-5, 3),
                blurRadius: 5,
                spreadRadius: 10,
              ),
              clipper: RightTopCurve(),
              child: Container(
                width: width * 0.99,
                height: height * 0.99,
                color: const Color(0xffECE4E4),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 40),
            child: ClipShadowPath(
              shadow: const BoxShadow(
                color: Colors.grey,
                offset: Offset(-5, 3),
                blurRadius: 5,
                spreadRadius: 10,
              ),
              clipper: LeftBtmCurve(),
              child: Container(
                width: width * 0.99,
                height: height * 0.99,
                color: const Color(0xffEEEAEA),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 10),
            child: SizedBox(
              height: height * 0.99,
              width: width * 0.99,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                    "https://user-images.githubusercontent.com/31005114/78748465-b5327d00-799e-11ea-9f40-38d322a9531a.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-50, 50),
            child: ClipShadowPath(
              shadow: const BoxShadow(
                color: Colors.grey,
                offset: Offset(-5, 3),
                blurRadius: 5,
                spreadRadius: 10,
              ),
              clipper: LeftTopCurve(),
              child: Container(
                height: height * 0.99,
                width: width * 0.99,
                color: const Color(0xffECE4E4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
