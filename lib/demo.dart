import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  int _maxDrag = 1;
  Color _color = Colors.red;
  int index = 0;
  List<Map<String, dynamic>> _colors = [
    {
      'color': Colors.red,
      '_isDrop': false,
      'name': 'RED',
    },
    {
      'color': Colors.blue,
      '_isDrop': false,
      'name': 'BLUE',
    },
    {
      'color': Colors.green,
      '_isDrop': false,
      'name': 'GREEN',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Spacer(),
            Draggable<Color>(
              data: _color,
              maxSimultaneousDrags: _maxDrag,
              onDragCompleted: () {
                if (index < 2) {
                  index++;
                  setState(() {
                    _color = _colors[index]['color'];
                  });
                } else {
                  _color = Colors.grey;
                  _maxDrag = 0;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('congratulation')));
                }
              },
              feedback: Container(
                width: 100,
                height: 100,
                color: _color,
              ),
              childWhenDragging: Container(
                width: 100,
                height: 100,
                color: index + 1 >= _colors.length
                    ? Colors.grey
                    : _colors[index + 1]['color'],
              ),
              child: Container(
                width: 100,
                height: 100,
                color: _color,
              ),
            ),
            Spacer(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_colors.length, (index) {
                  return DragTarget<Color>(
                    onLeave: (data) {
                      debugPrint('missed');
                      if (data != _colors[index]['color']) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Incorrect, please try again!')));
                      }
                    },
                    onAccept: (data) {
                      setState(() {
                        _colors[index]['_isDrop'] = true;
                      });
                    },
                    onWillAccept: (data) {
                      return data == _colors[index]['color'];
                    },
                    builder: (context, accepted, rejected) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: _colors[index]['_isDrop']
                              ? _colors[index]['color']
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(!_colors[index]['_isDrop']
                              ? _colors[index]['name']
                              : 'Correct'),
                        ),
                      );
                    },
                  );
                })),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
