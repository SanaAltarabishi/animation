import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List myTiles = [
    'A',
    'B',
    'C',
    'D',
  ];

  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      // an adfustment is needed when moving the tile down the list :
      if (oldIndex < newIndex) {
        newIndex--;
      }
      // get the tile we are moving
      final tile = myTiles.removeAt(oldIndex);
      //place the tile in the new position
      myTiles.insert(newIndex, tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 118, 183, 235),
      appBar: AppBar(
        title: const Text('Drag Drop List'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 118, 183, 235),
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) => updateMyTiles(oldIndex, newIndex),
        children: [
          for (final tile in myTiles)
            ListTile(
              key: ValueKey(tile),
              title: Text(tile),
            )
        ],
      ),
    );
  }
}
