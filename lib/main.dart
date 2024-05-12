import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasketBallAnimation(),
    );
  }
}


//Animate.restartOnHotReload= true; on void main ..
class BasketBallAnimation extends StatelessWidget {
  final start = ValueNotifier(false);
  BasketBallAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const  Text(
              '🌎',
              style: TextStyle(fontSize: 190),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .moveY(
                  begin: -25,
                  end: 15,
                  curve: Curves.easeInOut,
                  duration:const Duration(milliseconds: 1000),
                )
                .then()
                .moveY(
                  begin: 15,
                  end: -25,
                  curve: Curves.easeInOut,
                ),
            // .shake()
            // .scaleX(end: 1.2),
            Padding(
              padding:const EdgeInsets.only(top: 15),
              child: Container(
                width: 150,
                height: 15,
                decoration:const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(150, 15),
                  ),
                ),
              ),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .scaleX(
                    begin: 1.2,
                    end: .8,
                    curve: Curves.easeInOut,
                    duration:const Duration(milliseconds: 1000))
                .then()
                .scaleX(
                  begin: .8,
                  end: 1.2,
                  curve: Curves.easeInOut,
                ),

         const   SizedBox(
              height: 200,
            ),
            ValueListenableBuilder(
              valueListenable: start,
              builder: (context, started, _) => StartButton(
                onPress: () => start.value = !start.value,
                lable: 'Tap',
              )
                  .animate(
                    target: started ? 1 : 0,
                    onPlay: (controller) => controller.reverse(),
                    onComplete: (controller) => debugPrint('complet'),
                  )
                  .elevation(
                    end: 20,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  )
                  .shake(hz: 2, rotation: .2)
                  .flip(
                    begin: -.2,
                  )
                  //.slideY(end: -.5)
                  .scaleXY(begin: .7)
                  .animate(
                    onPlay: (c) => c.repeat(),
                  )
                  .shimmer(delay: 5000.ms, duration: 1000.ms)
                  .shakeX(
                    hz: 5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  final void Function() onPress;
  final String lable;
 const StartButton({super.key, required this.onPress, required this.lable});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 60,
      height: 70,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.blueGrey.shade200),
        ),
        onPressed: onPress,
        child: Text(
          lable,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Colors.blueGrey.shade800,
          ),
        ),
      ),
    );
  }
}
