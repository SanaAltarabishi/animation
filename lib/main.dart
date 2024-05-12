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
      home:CheckboxSliderScreen() ,
    );
  }
}

class CheckboxSliderScreen extends StatefulWidget {
  @override
  _CheckboxSliderScreenState createState() => _CheckboxSliderScreenState();
}

class _CheckboxSliderScreenState extends State<CheckboxSliderScreen> {
  List<bool> checkboxValues = List.generate(5, (index) => false);
  double sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox Slider Example'),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: checkboxValues.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text('Checkbox $index'),
                value: checkboxValues[index],
                onChanged: (value) {
                  setState(() {
                    checkboxValues[index] = value!;
                    if (value) {
                      sliderValue += 1.0;
                    } else {
                      sliderValue -= 1.0;
                    }
                  });
                },
              );
            },
          ),
          Slider(
            value: sliderValue,
            onChanged: null, // Disable slider interaction
            min: 0.0,
            max: checkboxValues.length.toDouble(),
            divisions: checkboxValues.length,
          ),
        ],
      ),
    );
  }
}