// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeautifulFlutterEffect extends StatefulWidget {
  const BeautifulFlutterEffect({super.key});

  @override
  State<BeautifulFlutterEffect> createState() => _BeautifulFlutterEffectState();
}

class _BeautifulFlutterEffectState extends State<BeautifulFlutterEffect> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final paletteState = Provider.of<ColorPaletteState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: paletteState.selectedColor.color,
      ),
      body: Container(
        height: size.height,
        color: paletteState.selectedColor.color,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white38,
            ),
            child: OverflowBox(
              maxHeight: 160,
              minHeight: 80,
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Consumer<ColorPaletteState>(
                    builder: (context, paletteState, child) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                paletteState.availableColorPalette.map<Widget>(
                              (palette) {
                                return GestureDetector(
                                  onTap: () {
                                    paletteState.changeSelectedColor(palette);
                                  },
                                  child: MouseRegion(
                                    onEnter: (event) {
                                      paletteState.changeHoveredColor(palette);
                                    },
                                    onExit: (event) {
                                      paletteState.changeHoveredColor(null);
                                    },
                                    child: SizedBox(
                                      height: 180,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 350,
                                            ),
                                            height: paletteState
                                                        .hoveredColorPalette ==
                                                    palette
                                                ? 95
                                                : paletteState
                                                            .hoveredColorPalette ==
                                                        null
                                                    ? 60
                                                    : (paletteState.hoveredColorPalette!
                                                                    .index ==
                                                                palette.index -
                                                                    1 ||
                                                            paletteState
                                                                    .hoveredColorPalette!
                                                                    .index ==
                                                                palette.index +
                                                                    1)
                                                        ? 70
                                                        : 50,
                                            width: paletteState
                                                        .hoveredColorPalette ==
                                                    palette
                                                ? 95
                                                : paletteState
                                                            .hoveredColorPalette ==
                                                        null
                                                    ? 60
                                                    : (paletteState.hoveredColorPalette!
                                                                    .index ==
                                                                palette.index -
                                                                    1 ||
                                                            paletteState
                                                                    .hoveredColorPalette!
                                                                    .index ==
                                                                palette.index +
                                                                    1)
                                                        ? 60
                                                        : 50,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: paletteState
                                                          .hoveredColorPalette ==
                                                      palette
                                                  ? 15
                                                  : 5,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: palette.color,
                                              border: Border.all(
                                                color: paletteState
                                                            .hoveredColorPalette ==
                                                        palette
                                                    ? Colors.black38
                                                    : Colors.transparent,
                                                width: 3,
                                              ),
                                            ),
                                          ),
                                          AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 350,
                                            ),
                                            margin: EdgeInsets.only(
                                              top: paletteState
                                                          .hoveredColorPalette ==
                                                      palette
                                                  ? 40
                                                  : paletteState
                                                              .hoveredColorPalette ==
                                                          null
                                                      ? 5
                                                      : (paletteState.hoveredColorPalette!
                                                                      .index ==
                                                                  palette.index -
                                                                      1 ||
                                                              paletteState
                                                                      .hoveredColorPalette!
                                                                      .index ==
                                                                  palette.index +
                                                                      1)
                                                          ? 20
                                                          : 5,
                                            ),
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                              color: paletteState
                                                          .hoveredColorPalette ==
                                                      palette
                                                  ? Colors.black38
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ColorPalette {
  Color color;
  int index;
  ColorPalette({
    required this.color,
    required this.index,
  });
}

class ColorPaletteState extends ChangeNotifier {
  ColorPalette selectedColor = ColorPalette(color: Colors.black12, index: 0);

  ColorPalette? hoveredColorPalette;

  List<ColorPalette> availableColorPalette = [
    ColorPalette(color: Colors.black12, index: 0),
    ColorPalette(color: Colors.red.shade100, index: 1),
    ColorPalette(color: Colors.orange.shade100, index: 2),
    ColorPalette(color: Colors.purple.shade100, index: 3),
    ColorPalette(color: Colors.pink.shade100, index: 4),
    ColorPalette(color: const Color.fromARGB(255, 207, 162, 162), index: 5),
    ColorPalette(color: Colors.yellow.shade100, index: 6),
    ColorPalette(color: Colors.green.shade100, index: 7),
    ColorPalette(color: Colors.blueGrey.shade100, index: 8),
  ];

  void changeSelectedColor(ColorPalette palette) {
    selectedColor = palette;
    notifyListeners();
  }

  void changeHoveredColor(ColorPalette? palette) {
    hoveredColorPalette = palette;
    notifyListeners();
  }
}
