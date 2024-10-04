import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  static const List<String> theList = <String>[
    'sana',
    'snsn',
    'meme',
    'cat',
    'mary',
    'lol',
    'ddd',
    'snsnss',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade300,
      ),
      body: RawAutocomplete(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return theList.where(
            (String item) {
              return item.contains(
                textEditingValue.text.toLowerCase(),
              );
            },
          );
        },
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              onFieldSubmitted: (value) {
                onFieldSubmitted();
              },
            ),
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Material(
                elevation: 4,
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final String option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                          title: Text(option),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
