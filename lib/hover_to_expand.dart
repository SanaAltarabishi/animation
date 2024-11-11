// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HoverToExpand extends StatefulWidget {
  const HoverToExpand({super.key});

  @override
  State<HoverToExpand> createState() => _HoverToExpandState();
}

class _HoverToExpandState extends State<HoverToExpand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            itemCount: dataInfo.length,
            itemBuilder: (context, index) {
              final data = dataInfo[index];
              return HoverItems(data: data);
            },
          ),
        ),
      ),
    );
  }
}

class HoverItems extends StatefulWidget {
  final ObjectToHover data;
  const HoverItems({
    super.key,
    required this.data,
  });

  @override
  State<HoverItems> createState() => _HoverItemsState();
}

class _HoverItemsState extends State<HoverItems> {
  bool isAnimate = false;
  bool textAppear = false;

  void change(bool a) {
    setState(() {
      if (a) {
        textAppear = true;
      } else {
        textAppear = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = isAnimate ? 320 : 275;
    double width = isAnimate ? 530 : 280;
    Color color = isAnimate ? widget.data.color2 : widget.data.color1;
    BorderRadius borderRadius =
        isAnimate ? BorderRadius.circular(40) : BorderRadius.circular(300);

    return MouseRegion(
      onEnter: (event) {
        isAnimate = true;
        change(isAnimate);
      },
      onExit: (event) {
        // setState(() {
        isAnimate = false;
        change(isAnimate);
        // });
      },
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: AnimatedContainer(
                height: height,
                width: width,
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: color,
                ),
                child: AnimatedOpacity(
                  opacity: textAppear ? 1 : 0,
                  duration: Duration(
                    milliseconds: textAppear ? 300 : 100,
                  ),
                  curve: Curves.easeIn,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          width: 200,
                          child: Text(
                            widget.data.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0),
            child: AnimatedContainer(
              padding: EdgeInsets.only(left: isAnimate ? 250 : 0),
              duration: const Duration(
                milliseconds: 200,
              ),
              height: height,
              child: Image(
                image: AssetImage(
                  widget.data.image,
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//model:
class ObjectToHover {
  String title;
  String description;
  String image;
  Color color1;
  Color color2;
  ObjectToHover({
    required this.title,
    required this.description,
    required this.image,
    required this.color1,
    required this.color2,
  });
}

List<ObjectToHover> dataInfo = [
  ObjectToHover(
    title: 'Pepsi',
    description:
        "lerem ipsum is simply dummy text of the printing and typesetting ",
    image: "assets/bottle.png",
    color1: Colors.red[700]!,
    color2: const Color(0xff004b93),
  ),
  ObjectToHover(
    title: "Coca cola",
    description:
        "lerem ipsum is simply dummy text of the printing and typesetting ",
    image: 'assets/coca.png',
    color1: Colors.black,
    color2: Colors.red,
  ),
  ObjectToHover(
    title: "BBB",
    description:
        "lerem ipsum is simply dummy text of the printing and typesetting ",
    image: 'assets/sprite.png',
    color1: Colors.blue,
    color2: Colors.orangeAccent,
  ),
];
