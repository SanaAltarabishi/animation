import 'package:flutter/material.dart';
import 'package:reverse_string/articles_app/splash_hooks.dart';
//import 'package:reverse_string/api_test_app/presentation/post_page.dart';
//import 'package:reverse_string/reverse/reverse_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen()
        // const ArticlesPage(),

        //2: PostsPage(), //3: ReversePage(),
        );
  }
}
