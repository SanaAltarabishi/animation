import 'package:flutter/material.dart';

class ReversePage extends StatefulWidget {
  const ReversePage({super.key});

  @override
  State<ReversePage> createState() => _ReversePageState();
}

class _ReversePageState extends State<ReversePage> {
  final TextEditingController textEditingController = TextEditingController();
  String reversedWord = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Reverse App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.blueGrey,
              onPressed: () {
                if (textEditingController.text.isEmpty) return;
                setState(() {
                  reversedWord = reverseFunction(textEditingController.text);
                });
              },
              child: const Text('Reverese'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              reversedWord,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

String reverseFunction(String initalWord) {
  return initalWord.split('').reversed.join();
}
