import 'package:flutter/material.dart';
import 'package:swipeable_button_animation_ui/Third_page.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List<String> items = [
    "Item 1",
    "Item 2",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade300,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThirdPage(),
                ),
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          int nextItem = items.length + 1;
          items.add("Item $nextItem");
          setState(
            () {},
          );
        },
        color: Colors.brown,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(items[index]),
              tileColor: Colors.white24,
            ),
          ),
          padding: const EdgeInsets.all(5),
        ),
      ),
    );
  }
}
