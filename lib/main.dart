import 'package:flutter/material.dart';
import 'package:sidebar_ui/sidebar/sidebar_layout.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SideBarLayout() ,
    );
  }
}
