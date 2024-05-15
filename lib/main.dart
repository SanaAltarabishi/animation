import 'package:card_app/demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
//! for osscam app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Demo()
      //CardMove()
    );
  }
}

class CardMove extends StatelessWidget {
   CardMove({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            title: const Text(
          'Draggable',
          style: TextStyle(fontSize: 20),
        )),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DraggableColumn(
                key: UniqueKey(),
                items: ['Item 1', 'Item 2', 'Item 3'],
                color: Colors.blue), //! when useing const : exeption appears..?
            DraggableColumn(
                key: UniqueKey(),
                items: ['Item 4', 'Item 5', 'Item 6'],
                color: Colors.green),
            DraggableColumn(
                key: UniqueKey(),
                items: ['Item 7', 'Item 8', 'Item 9'],
                color: Colors.orange),
          ],
        ),
      );
  }
}

class DraggableColumn extends StatefulWidget {
  final List<String> items;
  final Color color;

  DraggableColumn({Key? key, required this.items, required this.color})
      : super(key: key);

  @override
  _DraggableColumnState createState() => _DraggableColumnState();
}

class _DraggableColumnState extends State<DraggableColumn> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    updateItems();
  }

  void updateItems() {
    items = List.from(widget.items); // Copy the items from the widget's list
  }

  void _onDraggableDragEnd(
      String data, List<String> sourceList, List<String> targetList) {
    setState(() {
      sourceList.remove(data); // Remove item from the source list
      targetList.add(data); // Add item to the target list
      updateItems(); // Update items list after the drag operation
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
//? this widget that recive data when a draggable widget is dropped
      onAcceptWithDetails: (details) {
        String data = details.data;
        setState(() {
          widget.items.remove(data); // Remove item from the source list
          items.add(data); // Add item to the target list
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Column(
          children: items
              .asMap()
              .entries
              .map(
                (entry) => Draggable<String>(
//? this widget can be dragged from and drop to draggedTarget
                  data: entry.value,
//?the card when moving it chape :
//? this tracks the user's finger across the screen, and its required .. normally its the same of child
                  feedback: Card(
                    elevation: 8,
                    color: widget.color, // Use column's color for all cards
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('move'),
                    ),
                  ),
//? under the card when moving it , that change the child when dragging
                  childWhenDragging: Container(),
                  onDragCompleted: () {
                    setState(() {
                      items.remove(
                          entry.value); // Remove the item from the column
                    });
                  },
                  child: Card(
                    elevation: 4,
                    color: widget.color, // Use column's color for all cards
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(entry.value),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
