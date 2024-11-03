import 'package:custom_transition/card_hover.dart';
import 'package:custom_transition/download_button.dart';
import 'package:custom_transition/error_page.dart';
import 'package:custom_transition/hero_animation.dart';
import 'package:custom_transition/lamp.dart';
import 'package:custom_transition/lines_animation.dart';
import 'package:custom_transition/progressBar_animation_challenge.dart';
import 'package:custom_transition/falsh_page.dart';
import 'package:custom_transition/radial_wave_progress.dart';
import 'package:custom_transition/sliding_container.dart';
import 'package:custom_transition/stagger_animation.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});
  // final Animation<double> transitionAnimation;
  // const SecondPage({
  //   super.key,
  //   required this.transitionAnimation,
  // });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SlidingContainer(
              color: Colors.blueGrey,
              initialOffsetX: 1,
              intervalStart: 0,
              intervalEnd: 0.5,
              child: Wrap(
                spacing: 50,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Flutter404Animation(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.error),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StaggerAnimationPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.square),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FalshPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.flash_auto_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProgressBar(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.bar_chart_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HeroExample(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.airplanemode_active_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Radial(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.waves),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WindyLines(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.circle),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChainReactionLamps(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.light),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DownloadButtonAnimation(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CardHoverAnimation(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.card_travel_sharp),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SlidingContainer(
              color: Color.fromARGB(255, 24, 83, 112),
              initialOffsetX: -1,
              intervalStart: 0.5,
              intervalEnd: 1,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: const Text('Navigate Back'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
