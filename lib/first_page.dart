import 'package:custom_transition/second_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return ListenableProvider(
                  create: (context) => animation,
                  child: const SecondPage(),
                );
                // return  SecondPage(
                //   transitionAnimation: animation,
                // );
              },
              transitionDuration: const Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.keyboard_arrow_left),
      ),
    );
  }
}
