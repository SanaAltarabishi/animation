import 'package:flutter/material.dart';

class ParallaxEffect extends StatefulWidget {
  const ParallaxEffect({super.key});

  @override
  State<ParallaxEffect> createState() => _ParallaxEffectState();
}

class _ParallaxEffectState extends State<ParallaxEffect> {
  late ScrollController scrollController;

  List<String> texts = [
    "Parallax Effect",
    "Beauty of Nature",
  ];

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 2,
        controller: scrollController,
        itemBuilder: (context, index) {
          return Container(
            clipBehavior: Clip.hardEdge,
            height: size.height,
            decoration: const BoxDecoration(),
            child: Stack(
              children: [
                Container(
                  transform: Matrix4.identity()
                    ..translate(
                      0.0,
                      scrollController.hasClients
                          ? (-(index * size.height) +
                                  scrollController.position.pixels) /
2
                          : 1.0,
                    ),
                  width: size.width,
                  height: size.height,
                  child: Image.asset(
                    'assets/images${index + 1}.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text(
                    texts[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
