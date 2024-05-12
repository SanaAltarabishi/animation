import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyScreen(),
    );
  }
}



class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool _isContainerVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent,
      body: Stack(
        children: [

          
        GestureDetector(
          onTap: (){
             setState(() {
                  _isContainerVisible = false;
                });
          },
            child: Container(
              color:const Color.fromARGB(255, 78, 131, 163),
            ),
          ),
          AnimatedPositioned(
            duration:const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _isContainerVisible
                ? MediaQuery.of(context).size.height * 0.5
                : MediaQuery.of(context).size.height,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey, 
              child:const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Container Content',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          _isContainerVisible?const SizedBox():Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isContainerVisible = true;
                });
              },
              child: Container(
                height: 50,
                color: const Color.fromARGB(255, 24, 76, 118), // Replace with your button's color
                child:const Center(
                  child: Text(
                    'Show Container',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
