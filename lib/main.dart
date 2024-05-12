import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GridViewPage(),
    );
  }
}

class ContainerModel {
  double sliderValue;
  List<bool> checkboxValues;
  List<String> checkboxTexts; // List to store checkbox texts

  ContainerModel({
    required this.sliderValue,
    required this.checkboxValues,
    required this.checkboxTexts,
  });
}

class GridViewPage extends StatefulWidget {
  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  late List<ContainerModel> containerModels = [
    ContainerModel(
        sliderValue: 33.333,
        checkboxValues: [true, false, false],
        checkboxTexts: ['jj', 'dd', 'ss'])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: containerModels.length,
        itemBuilder: (context, index) {
          return _buildContainer(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addContainer(); // Add a new container to the grid view
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContainer(int index) {
    return Container(
      margin: const EdgeInsets.all(15),
      color: const Color.fromARGB(255, 151, 102, 160),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              _navigateToContainerPage(context, index);
            },
          ),
          Text(
            'Container $index\nSlider value: ${containerModels[index].sliderValue}',
            textAlign: TextAlign.center,
          ),
          // ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteContainer(index);
            },
          ),
        ],
      ),
    );
  }

  void _deleteContainer(int index) {
    setState(() {
      containerModels.removeAt(index);
    });
  }

  void _addContainer() {
    setState(() {
      containerModels.add(ContainerModel(
        sliderValue: 0,
        checkboxValues: [],
        checkboxTexts: [],
      ));
    });
  }

  void _navigateToContainerPage(BuildContext context, int index) async {
    final updatedModel = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContainerPage(
          containerModel: containerModels[index],
        ),
      ),
    );

    if (updatedModel != null) {
      setState(() {
        containerModels[index] = updatedModel;
        containerModels[index].sliderValue = updatedModel
            .sliderValue; // Update the slider value in the container model
      });
    }
  }
}

class ContainerPage extends StatefulWidget {
  final ContainerModel containerModel;

  ContainerPage({required this.containerModel});

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  late double sliderValue;
  late List<bool> checkboxValues;
  late List<String> checkboxTexts; // List to store checkbox texts
  final TextEditingController _textEditingController = TextEditingController();
  GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    sliderValue = widget.containerModel.sliderValue;
    checkboxValues = List.from(widget.containerModel.checkboxValues);
    checkboxTexts = List.from(widget.containerModel.checkboxTexts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 102, 160),
      body: Column(
        children: [
          Slider(
            value: sliderValue,
            onChanged: null,
            min: 0.0,
            max: 100,
            divisions: checkboxValues.isNotEmpty ? checkboxValues.length : 1,
          ),
          ElevatedButton(
            onPressed: () async {
              await _addCheckbox();
            },
            child: Text('Add Checkbox'),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: checkboxValues.length,
              itemBuilder: (context, index, animation) {
                return _buildCheckboxItem(index, animation);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _returnUpdatedModel();
        },
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _buildCheckboxItem(int index, Animation<double> animation) {
    if (index < checkboxTexts.length) {
      return SizeTransition(
        sizeFactor: animation,
        child: Dismissible(
          key: Key('$index'),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            setState(() {
              _deleteCheckbox(index);
            });
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
          child: CheckboxListTile(
            title: Text(checkboxTexts[index]), // Use text value
            value: checkboxValues[index],
            onChanged: (value) {
              setState(() {
                checkboxValues[index] = value!;
                sliderValue = _calculateSliderValue();
              });
            },
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Future<void> _addCheckbox() async {
    _textEditingController.clear(); // Clear the text field

    final text = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Checkbox Text'),
          content: TextField(
            controller: _textEditingController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final newText = _textEditingController.text;
                  checkboxTexts.add(newText); // Add text to checkboxTexts
                  checkboxValues.add(false); // Add corresponding boolean value
                  _listKey.currentState?.insertItem(checkboxValues.length - 1);
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );

    if (text != null) {
      setState(() {
        sliderValue = _calculateSliderValue();
      });
    }
  }

  double _calculateSliderValue() {
    int checkedCount = checkboxValues.where((value) => value).length;
    double value = ((checkedCount / checkboxValues.length) * 100);

    return value;
  }

  void _returnUpdatedModel() {
    final updatedModel = ContainerModel(
      sliderValue: sliderValue,
      checkboxValues: checkboxValues,
      checkboxTexts: checkboxTexts,
    );
    Navigator.pop(context, updatedModel);
  }

  void _deleteCheckbox(int index) {
    setState(() {
      checkboxValues.removeAt(index);
      checkboxTexts.removeAt(index); // Remove text from checkboxTexts
      sliderValue = checkboxValues.isNotEmpty ? _calculateSliderValue() : 0.0;
    });
  }
}
