import 'package:flutter/material.dart';

class CardHoverAnimation extends StatefulWidget {
  const CardHoverAnimation({super.key});

  @override
  State<CardHoverAnimation> createState() => _CardHoverAnimationState();
}

class _CardHoverAnimationState extends State<CardHoverAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            CardHover(
              name: "sana Al tarabishy",
              image: "assets/images2.png",
              buttonColor: Color.fromARGB(255, 161, 85, 57),
              backgroundColor: Color.fromARGB(200, 161, 85, 57),
            ),
            CardHover(
              name: "sana ",
              image: "assets/images2.png",
              buttonColor: Color.fromARGB(255, 95, 52, 36),
              backgroundColor: Color.fromARGB(200, 95, 52, 36),
            ),
            CardHover(
              name: "sana al tarabishy",
              image: "assets/images2.png",
              buttonColor: Color.fromARGB(255, 188, 146, 131),
              backgroundColor: Color.fromARGB(200, 188, 146, 131),
            ),
          ],
        ),
      ),
    );
  }
}

class CardHover extends StatefulWidget {
  final Color backgroundColor;
  final String name;
  final String image;
  final Color buttonColor;
  const CardHover({
    super.key,
    required this.backgroundColor,
    required this.name,
    required this.image,
    required this.buttonColor,
  });

  @override
  State<CardHover> createState() => _CardHoverState();
}

class _CardHoverState extends State<CardHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovered = false;
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            //animated container for the card background :
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: isHovered ? 300 : 280,
              width: 220,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            //animated position for the inner container :
            AnimatedPositioned(
              top: isHovered ? -100 : 0,
              duration: const Duration(milliseconds: 350),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                height: isHovered ? 400 : 300,
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: AnimatedContainer(
                        duration: const Duration(microseconds: 350),
                        height: isHovered ? 180 : 200,
                        width: isHovered ? 180 : 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(widget.image),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Visibility(
                        visible: isHovered,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'ffffffffffffffffffffffffdddddddsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: isHovered,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: widget.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(15),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Read more",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
